import '../entities/mission.dart';
import '../repositories/mission_repository.dart';

/// 任务仓库的 Mock 实现
///
/// 返回硬编码的静态任务数据。
class MockMissionRepository implements MissionRepository {
  /// 模拟任务数据 — 23 个进行中任务，5 个待处理，15 个已完成
  /// 仅存储进行中的任务用于统计
  final List<Mission> _activeMissions = List.generate(23, (i) => Mission(
    id: 'mission-${(i + 1).toString().padLeft(3, '0')}',
    name: '运输任务 #${i + 1}',
    vehicleId: 'v-00${(i % 8) + 1}',
    status: i < 18 ? 'in_progress' : 'pending',
    loadPoint: '装载点-${["A", "B", "C"][i % 3]}',
    unloadPoint: '卸载点-${["X", "Y"][i % 2]}',
    targetLoad: 60.0 + (i * 2),
    currentLoad: i < 18 ? (20.0 + (i * 1.5)) : 0.0,
    createdAt: DateTime.now().subtract(Duration(hours: i + 1)),
    startedAt: i < 18 ? DateTime.now().subtract(Duration(minutes: i * 5)) : null,
    priority: i < 5 ? 'urgent' : (i < 12 ? 'high' : 'normal'),
  ));

  /// 所有任务（含已完成）
  final List<Mission> _allMissions = [
    ...List.generate(23, (i) => Mission(
      id: 'mission-${(i + 1).toString().padLeft(3, '0')}',
      name: '运输任务 #${i + 1}',
      vehicleId: 'v-00${(i % 8) + 1}',
      status: i < 18 ? 'in_progress' : 'pending',
      loadPoint: '装载点-${["A", "B", "C"][i % 3]}',
      unloadPoint: '卸载点-${["X", "Y"][i % 2]}',
      targetLoad: 60.0 + (i * 2),
      currentLoad: i < 18 ? (20.0 + (i * 1.5)) : 0.0,
      createdAt: DateTime.now().subtract(Duration(hours: i + 1)),
      startedAt: i < 18 ? DateTime.now().subtract(Duration(minutes: i * 5)) : null,
      priority: i < 5 ? 'urgent' : (i < 12 ? 'high' : 'normal'),
    )),
    ...List.generate(15, (i) => Mission(
      id: 'mission-completed-${(i + 1).toString().padLeft(3, '0')}',
      name: '已完成任务 #${i + 1}',
      vehicleId: 'v-00${(i % 8) + 1}',
      status: 'completed',
      loadPoint: '装载点-${["A", "B", "C"][i % 3]}',
      unloadPoint: '卸载点-${["X", "Y"][i % 2]}',
      targetLoad: 55.0 + (i * 3),
      currentLoad: 55.0 + (i * 3),
      createdAt: DateTime.now().subtract(Duration(days: i + 2)),
      startedAt: DateTime.now().subtract(Duration(days: i + 2)),
      completedAt: DateTime.now().subtract(Duration(days: i + 1)),
      priority: 'normal',
    )),
  ];

  @override
  Future<List<Mission>> getMissions() async {
    await Future.delayed(const Duration(milliseconds: 200)); // 模拟网络延迟
    return _allMissions;
  }

  @override
  Future<int> getActiveMissionCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _activeMissions.length; // 23
  }

  @override
  Future<Mission?> getMissionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _allMissions.cast<Mission?>().firstWhere(
      (m) => m?.id == id,
      orElse: () => null,
    );
  }

  @override
  Future<List<Mission>> getMissionsByStatus(String status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _allMissions.where((m) => m.status == status).toList();
  }
}