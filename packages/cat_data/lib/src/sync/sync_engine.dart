import 'dart:async';
import '../drift/app_database.dart';
import '../remote/http_client.dart';

/// 同步引擎
///
/// 监测网络恢复后，从 [AppDatabase] 的离线队列中取出所有待处理操作，
/// 按先入先出顺序逐一执行 HTTP 请求。失败的操作标记为 failed 并重试（最多 3 次）。
class SyncEngine {
  final AppDatabase _db;
  final CatHttpClient _httpClient;
  StreamSubscription<bool>? _connectivitySubscription;
  bool _isSyncing = false;

  SyncEngine({required AppDatabase db, required CatHttpClient httpClient})
      : _db = db,
        _httpClient = httpClient;

  /// 监听网络状态变化，网络恢复时自动触发同步
  void bindToConnectivity(Stream<bool> connectivityStream) {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = connectivityStream.listen((online) {
      if (online) {
        processQueue();
      }
    });
  }

  /// 遍历离线队列并逐一执行操作
  Future<void> processQueue() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pendingOps = await _db.getPendingSyncOps();
      for (final op in pendingOps) {
        if (op.retries >= 3) {
          // 超过最大重试次数，标记为最终失败
          await _db.markSyncOpFailed(op.id);
          continue;
        }
        try {
          await _executeOperation(op.operationType, op.payload);
          await _db.markSyncOpDone(op.id);
        } catch (_) {
          // 单次操作失败不阻塞整体同步
          await _db.markSyncOpFailed(op.id);
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  /// 根据操作类型执行对应的 HTTP 请求
  Future<void> _executeOperation(String operationType, String payload) async {
    switch (operationType) {
      case 'acknowledge_alert':
        await _httpClient.post('/alerts/$payload/acknowledge');
      case 'start_mission':
        await _httpClient.post('/missions/$payload/start');
      case 'complete_mission':
        await _httpClient.post('/missions/$payload/complete');
      default:
        throw UnsupportedError('未知离线操作类型: $operationType');
    }
  }

  /// 释放资源
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}