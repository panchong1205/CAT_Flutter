import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// Dashboard 统计数据模型
///
/// 封装运营概览页面的四个核心统计指标。
class DashboardStats {
  final int totalDevices;       // 设备总数（车辆 + 其他设备）
  final int onlineVehicles;     // 在线车辆数
  final int activeMissions;     // 进行中任务数
  final int todayAlerts;        // 今日告警数

  const DashboardStats({
    required this.totalDevices,
    required this.onlineVehicles,
    required this.activeMissions,
    required this.todayAlerts,
  });
}

/// Dashboard 统计数据 Provider
///
/// 聚合 Fleet、Mission、Alert 三个仓库的数据，提供 Dashboard 所需的统计指标。
/// 当前 Demo 阶段数据来自 Mock 实现，Step 5 将切换到真实数据源。
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  // 并行获取各数据源统计数据
  final results = await Future.wait([
    di<FleetRepository>().getTotalDeviceCount(),
    di<FleetRepository>().getOnlineVehicleCount(),
    di<MissionRepository>().getActiveMissionCount(),
    di<AlertRepository>().getTodayAlertCount(),
  ]);

  return DashboardStats(
    totalDevices: results[0],      // 128 (8 车辆 + 120 设备)
    onlineVehicles: results[1],    // 6
    activeMissions: results[2],    // 23
    todayAlerts: results[3],       // 7
  );
});