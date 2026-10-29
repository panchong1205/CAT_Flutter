import '../entities/alert.dart';
import '../repositories/alert_repository.dart';

/// 告警仓库的 Mock 实现
///
/// 返回硬编码的静态告警数据。
class MockAlertRepository implements AlertRepository {
  /// 模拟告警数据 — 7 条今日告警，共 25 条历史告警
  final List<Alert> _alerts = [
    Alert(
      id: 'alert-001', title: '车辆超速告警',
      message: 'CUSTOM-001 在矿区主路段超速行驶，当前速度 45km/h（限速 30km/h）',
      level: 'critical', source: 'vehicle', vehicleId: 'v-001',
      acknowledged: false, createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    Alert(
      id: 'alert-002', title: '油量过低告警',
      message: 'CUSTOM-008 油量不足 10%，请尽快安排加油',
      level: 'warning', source: 'vehicle', vehicleId: 'v-008',
      acknowledged: false, createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    Alert(
      id: 'alert-003', title: '设备离线告警',
      message: '传感器-115 已离线超过 2 小时，请检查网络连接',
      level: 'warning', source: 'system',
      acknowledged: false, createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Alert(
      id: 'alert-004', title: '装载偏差告警',
      message: 'CUSTOM-003 装载点 A 的装载量偏差超过 5%，请校准传感器',
      level: 'info', source: 'system', vehicleId: 'v-003',
      acknowledged: true, createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      acknowledgedAt: DateTime.now().subtract(const Duration(hours: 2)),
      acknowledgedBy: '操作员-张工',
    ),
    Alert(
      id: 'alert-005', title: '安全区域闯入告警',
      message: '爆破区 B 检测到未授权人员/车辆进入',
      level: 'critical', source: 'safety',
      acknowledged: false, createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Alert(
      id: 'alert-006', title: '车辆故障告警',
      message: 'CUSTOM-007 发动机温度异常，建议停机检查',
      level: 'critical', source: 'vehicle', vehicleId: 'v-007',
      acknowledged: true, createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      acknowledgedAt: DateTime.now().subtract(const Duration(hours: 4)),
      acknowledgedBy: '操作员-李工',
    ),
    Alert(
      id: 'alert-007', title: '通信中断告警',
      message: '矿区内通信基站 dev-090 信号异常，部分区域覆盖不足',
      level: 'warning', source: 'system',
      acknowledged: false, createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
  ];

  /// 历史告警（不在今日统计范围内）
  final List<Alert> _historyAlerts = List.generate(18, (i) => Alert(
    id: 'alert-hist-${(i + 1).toString().padLeft(3, '0')}',
    title: '历史告警 #${i + 1}',
    message: '这是一条今天之前的告警记录',
    level: ['info', 'warning', 'critical'][i % 3],
    source: ['vehicle', 'system', 'safety'][i % 3],
    acknowledged: i % 2 == 0,
    createdAt: DateTime.now().subtract(Duration(days: i + 1)),
    acknowledgedAt: i % 2 == 0 ? DateTime.now().subtract(Duration(days: i)) : null,
  ));

  @override
  Future<List<Alert>> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 200)); // 模拟网络延迟
    return [..._alerts, ..._historyAlerts];
  }

  @override
  Future<int> getTodayAlertCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    // 统计今天创建的告警
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayAlerts = _alerts.where(
      (a) => a.createdAt.isAfter(todayStart),
    );
    return todayAlerts.length; // 7
  }

  @override
  Future<List<Alert>> getAlertsByLevel(String level) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _alerts.where((a) => a.level == level).toList();
  }

  @override
  Future<List<Alert>> getAlertsByAcknowledged(bool acknowledged) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _alerts.where((a) => a.acknowledged == acknowledged).toList();
  }
}