import '../entities/mission.dart';

/// 任务仓储抽象接口
///
/// 定义运输任务的访问契约。
abstract class MissionRepository {
  /// 获取所有任务列表
  Future<List<Mission>> getMissions();

  /// 获取进行中的任务数量
  Future<int> getActiveMissionCount();

  /// 根据 ID 获取任务详情
  Future<Mission?> getMissionById(String id);

  /// 按状态筛选任务
  Future<List<Mission>> getMissionsByStatus(String status);
}