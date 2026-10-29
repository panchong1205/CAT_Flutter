import '../entities/patrol_point.dart';

/// 巡检仓储抽象接口
abstract class PatrolRepository {
  /// 获取所有巡检点列表
  Future<List<PatrolPoint>> getPatrolPoints();

  /// 获取待巡检的点位数量
  Future<int> getPendingPatrolCount();

  /// 按状态筛选巡检点
  Future<List<PatrolPoint>> getPatrolPointsByStatus(String status);

  /// 巡检打卡（标记为已完成）
  Future<PatrolPoint> checkIn(String id, {String? remark});
}