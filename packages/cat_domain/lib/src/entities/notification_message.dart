import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_message.freezed.dart';

/// 通知消息实体
///
/// 汇总来自告警、任务、审批、巡检等模块的通知消息。
@freezed
class NotificationMessage with _$NotificationMessage {
  const factory NotificationMessage({
    required String id,             // 消息唯一标识
    required String title,          // 消息标题
    required String body,           // 消息正文
    required String type,           // 类型：alert / mission / approval / patrol
    required String level,          // 级别：critical / warning / info
    String? sourceId,               // 来源 ID（可跳转到详情）
    String? sourceRoute,            // 来源路由（跳转路径）
    required DateTime createdAt,    // 消息时间
    required bool isRead,           // 是否已读
  }) = _NotificationMessage;

  const NotificationMessage._();
}