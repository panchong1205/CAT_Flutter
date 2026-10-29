import '../entities/mission.dart';

/// 启动任务 UseCase
///
/// 处理启动一个矿山运输任务的业务逻辑。
abstract class StartMission {
  /// 启动指定任务
  ///
  /// [missionId] 待启动的任务 ID
  /// [vehicleId] 分配执行的车辆 ID
  /// 返回更新后的任务对象
  Future<Mission> call({
    required String missionId,
    required String vehicleId,
  });
}