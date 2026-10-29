import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';

/// 告警列表 Provider
///
/// 从 [AlertRepository] 获取所有告警数据。
/// AlertListPage 通过此 Provider 订阅告警列表。
final alertsProvider = FutureProvider.autoDispose<List<Alert>>((ref) {
  return di<AlertRepository>().getAlerts();
});

/// 今日告警数量 Provider
///
/// 用于导航栏告警徽章的计数显示。
final todayAlertCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return di<AlertRepository>().getTodayAlertCount();
});

/// 未确认告警数量 Provider
///
/// 统计所有未确认的告警数量，用于全屏弹窗和徽章提示。
final unacknowledgedAlertCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final alerts = await di<AlertRepository>().getAlerts();
  return alerts.where((a) => !a.acknowledged).length;
});

/// 实时告警事件 Provider
///
/// 仅订阅 WebSocket 推送的 alert_new 事件。
/// AlertListPage 和 VehicleShell 通过此 Provider 获取实时告警推送。
final liveAlertStreamProvider = StreamProvider.autoDispose<LiveEvent>((ref) {
  final wsService = di<MockWebSocketService>();

  // 确保 WebSocket 已连接
  if (!wsService.isConnected) {
    wsService.connect();
  }

  return wsService.eventStream.where((event) => event.isAlertNew);
});

/// 按严重级别筛选告警 Provider
///
/// [level] 支持的值：critical / warning / info
final alertsByLevelProvider =
    FutureProvider.autoDispose.family<List<Alert>, String>((ref, level) {
  return di<AlertRepository>().getAlertsByLevel(level);
});