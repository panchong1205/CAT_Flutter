import 'package:freezed_annotation/freezed_annotation.dart';

part 'patrol_point.freezed.dart';

/// 巡检点实体
///
/// 表示矿山中的一个巡检检查点，包含打卡位置和巡检状态。
@freezed
class PatrolPoint with _$PatrolPoint {
  const factory PatrolPoint({
    required String id,             // 巡检点唯一标识
    required String name,           // 巡检点名称（如"1号破碎站"）
    required String location,       // 巡检位置描述
    required String status,         // 状态：pending / completed / skipped
    required String category,       // 类别：safety / equipment / environment
    String? assigneeName,           // 巡检人姓名
    DateTime? scheduledAt,          // 计划巡检时间
    DateTime? completedAt,          // 实际完成时间
    String? photoUrl,               // 巡检拍照 URL（可选）
    String? remark,                 // 巡检备注
  }) = _PatrolPoint;

  const PatrolPoint._();
}