import 'package:cat_domain/cat_domain.dart';
import 'package:drift/drift.dart';
import '../drift/app_database.dart';
import '../drift/mappers/alert_mapper.dart';
import '../remote/http_client.dart';
import '../remote/api_services/alert_api_service.dart';

/// 告警仓储实现
///
/// 采用离线优先策略，先查本地缓存再异步更新。
class AlertRepoImpl implements AlertRepository {
  final AppDatabase _db;
  final CatHttpClient _httpClient;

  AlertRepoImpl({required AppDatabase db, required CatHttpClient httpClient})
      : _db = db,
        _httpClient = httpClient;

  @override
  Future<List<Alert>> getAlerts() async {
    final cached = await _db.getAllAlerts();
    _refreshAlerts();
    return cached.map((a) => a.toDomain()).toList();
  }

  @override
  Future<int> getTodayAlertCount() async {
    final count = await _db.getTodayAlertCount();
    if (count == 0) {
      await _refreshAlerts();
      return _db.getTodayAlertCount();
    }
    return count;
  }

  @override
  Future<List<Alert>> getAlertsByLevel(String level) async {
    final all = await getAlerts();
    return all.where((a) => a.level == level).toList();
  }

  @override
  Future<List<Alert>> getAlertsByAcknowledged(bool acknowledged) async {
    final all = await getAlerts();
    return all.where((a) => a.acknowledged == acknowledged).toList();
  }

  // ============================================================
  // 后台刷新
  // ============================================================

  /// 异步获取远端告警数据并批量写入本地数据库
  Future<void> _refreshAlerts() async {
    try {
      final response = await _httpClient.get('/alerts');
      final List<dynamic> raw = response.data['data'] as List<dynamic>;
      final alerts = raw.cast<Map<String, dynamic>>().map(alertFromJson).toList();

      final companions = alerts.map((a) {
        return AlertsCompanion.insert(
          id: a.id,
          title: a.title,
          message: a.message,
          level: a.level,
          source: a.source,
          vehicleId: Value(a.vehicleId),
          acknowledged: a.acknowledged,
          createdAt: a.createdAt.millisecondsSinceEpoch,
          acknowledgedAt: Value(a.acknowledgedAt?.millisecondsSinceEpoch),
          acknowledgedBy: Value(a.acknowledgedBy),
        );
      }).toList();
      await _db.upsertAlerts(companions);
    } catch (_) {
      // 静默失败
    }
  }
}