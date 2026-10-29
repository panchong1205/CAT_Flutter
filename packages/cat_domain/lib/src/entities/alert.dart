import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';

/// 告警实体
///
/// 表示矿山运营中产生的告警信息，如设备故障、超速等。
@freezed
class Alert with _$Alert {
  const factory Alert({
    required String id,           // 告警唯一标识
    required String title,        // 告警标题
    required String message,      // 告警详情
    required String level,        // 告警级别：critical / warning / info
    required String source,       // 告警来源：vehicle / system / safety
    String? vehicleId,            // 关联车辆 ID（可选）
    required bool acknowledged,   // 是否已确认
    required DateTime createdAt,  // 告警时间
    DateTime? acknowledgedAt,     // 确认时间
    String? acknowledgedBy,       // 确认人
  }) = _Alert;
}