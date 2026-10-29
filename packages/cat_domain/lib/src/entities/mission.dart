import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission.freezed.dart';

/// 运输任务实体
///
/// 表示一次矿山运输任务，从装载点到卸载点。
@freezed
class Mission with _$Mission {
  const factory Mission({
    required String id,           // 任务唯一标识
    required String name,         // 任务名称
    required String vehicleId,    // 分配的车辆 ID
    required String status,       // 任务状态：pending / in_progress / completed / cancelled
    required String loadPoint,    // 装载点名称
    required String unloadPoint,  // 卸载点名称
    required double targetLoad,   // 目标装载量 (吨)
    required double currentLoad,  // 当前装载量 (吨)
    required DateTime createdAt,  // 任务创建时间
    DateTime? startedAt,          // 开始时间
    DateTime? completedAt,        // 完成时间
    String? priority,             // 优先级：normal / high / urgent
  }) = _Mission;
}