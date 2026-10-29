import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// 网络连接状态监测服务
///
/// 基于 [connectivity_plus] 实现，支持 Web / Android / iOS / macOS 全平台。
/// 对外提供 [isOnline] 当前状态和 [onConnectivityChanged] 实时变化流。
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = true;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService() {
    _init();
  }

  /// 当前是否在线
  bool get isOnline => _isOnline;

  /// 网络状态变化流 — 订阅此 Stream 获取实时在线/离线通知
  Stream<bool> get onConnectivityChanged => _controller.stream;

  /// 初始化：检查当前状态 + 监听变化
  void _init() {
    // 检查初始网络状态
    _connectivity.checkConnectivity().then((results) {
      _updateStatus(!results.contains(ConnectivityResult.none));
    });

    // 监听网络状态变化
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _updateStatus(!results.contains(ConnectivityResult.none));
    });
  }

  void _updateStatus(bool online) {
    if (online != _isOnline) {
      _isOnline = online;
      _controller.add(online);
    }
  }

  /// 释放资源
  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}