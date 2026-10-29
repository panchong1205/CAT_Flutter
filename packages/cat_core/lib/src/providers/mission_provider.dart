import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 任务列表 Provider
///
/// 从 [MissionRepository] 获取所有运输任务。
/// MissionListPage 通过此 Provider 订阅任务数据。
final missionsProvider = FutureProvider.autoDispose<List<Mission>>((ref) {
  return di<MissionRepository>().getMissions();
});

/// 按状态筛选任务 Provider
///
/// 根据 [status] 参数返回对应状态的任务列表。
/// 支持的状态值：pending / in_progress / completed / cancelled
final missionsByStatusProvider =
    FutureProvider.autoDispose.family<List<Mission>, String>((ref, status) {
  return di<MissionRepository>().getMissionsByStatus(status);
});

/// 任务详情 Provider
///
/// 根据任务 [id] 获取单个任务的完整信息。
final missionDetailProvider =
    FutureProvider.autoDispose.family<Mission?, String>((ref, id) {
  return di<MissionRepository>().getMissionById(id);
});

/// 进行中任务数量 Provider
///
/// 用于 Dashboard 统计卡片等需要实时任务计数的场景。
final activeMissionCountProvider = FutureProvider.autoDispose<int>((ref) {
  return di<MissionRepository>().getActiveMissionCount();
});