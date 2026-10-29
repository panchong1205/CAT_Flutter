import '../entities/alert.dart';

/// 告警仓储抽象接口
///
/// 定义告警数据的访问契约。
abstract class AlertRepository {
  /// 获取所有告警列表
  Future<List<Alert>> getAlerts();

  /// 获取今日告警数量
  Future<int> getTodayAlertCount();

  /// 按告警级别筛选
  Future<List<Alert>> getAlertsByLevel(String level);

  /// 按确认状态筛选
  Future<List<Alert>> getAlertsByAcknowledged(bool acknowledged);
}