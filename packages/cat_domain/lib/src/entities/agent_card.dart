import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_card.freezed.dart';

/// Agent 结构化卡片类型枚举
enum AgentCardType {
  alert_card,
  confirm_card,
  info_card,
  action_card,
}

/// Agent 结构化卡片基类
///
/// Agent 回复消息中可以携带多种类型的结构化卡片，
/// 用于展示告警、确认操作、信息展示、动作按钮等交互。
@freezed
sealed class AgentCard with _$AgentCard {
  const AgentCard._();

  /// 告警卡片 — 展示一条告警详情，内置操作按钮
  const factory AgentCard.alertCard({
    required String alertId,      // 告警 ID
    required String title,        // 告警标题
    required String level,        // 告警级别：critical / warning / info
    required String message,      // 告警详情
    String? vehicleName,          // 关联车辆名称
    List<String>? actions,        // 操作按钮标签列表（如：['暂停作业', '忽略', '详情']）
  }) = AlertAgentCard;

  /// 确认卡片 — 需要用户确认的操作
  const factory AgentCard.confirmCard({
    required String actionId,     // 操作 ID，用于确认/取消回调
    required String title,        // 确认标题
    required String message,      // 确认描述
    String? confirmLabel,         // 确认按钮文字（默认「确认」）
    String? cancelLabel,          // 取消按钮文字（默认「取消」）
    String? severity,             // 严重程度：danger / warning / info
  }) = ConfirmAgentCard;

  /// 信息卡片 — 纯信息展示
  const factory AgentCard.infoCard({
    required String title,        // 信息标题
    required String content,      // 信息内容
    String? iconName,             // 图标名称（如 'info', 'success', 'warning'）
    List<InfoField>? fields,      // 键值对字段列表
  }) = InfoAgentCard;

  /// 动作卡片 — 提供多个操作选项
  const factory AgentCard.actionCard({
    required String title,        // 动作标题
    String? description,          // 动作描述
    List<ActionResult>? results,  // 动作结果列表（用于展示操作后的反馈）
    List<String>? actions,        // 可用操作列表
    String? status,               // 动作状态：pending / success / failed
  }) = ActionAgentCard;

  /// 从 JSON Map 构造 AgentCard
  factory AgentCard.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as Map<String, dynamic>;

    return switch (type) {
      'alert_card' => AgentCard.alertCard(
          alertId: data['alertId'] as String? ?? '',
          title: data['title'] as String? ?? '',
          level: data['level'] as String? ?? 'info',
          message: data['message'] as String? ?? '',
          vehicleName: data['vehicleName'] as String?,
          actions: (data['actions'] as List?)?.cast<String>(),
        ),
      'confirm_card' => AgentCard.confirmCard(
          actionId: data['actionId'] as String? ?? '',
          title: data['title'] as String? ?? '',
          message: data['message'] as String? ?? '',
          confirmLabel: data['confirmLabel'] as String?,
          cancelLabel: data['cancelLabel'] as String?,
          severity: data['severity'] as String?,
        ),
      'info_card' => AgentCard.infoCard(
          title: data['title'] as String? ?? '',
          content: data['content'] as String? ?? '',
          iconName: data['iconName'] as String?,
          fields: (data['fields'] as List?)
              ?.map((f) => InfoField.fromJson(f as Map<String, dynamic>))
              .toList(),
        ),
      'action_card' => AgentCard.actionCard(
          title: data['title'] as String? ?? '',
          description: data['description'] as String?,
          results: (data['results'] as List?)
              ?.map((r) => ActionResult.fromJson(r as Map<String, dynamic>))
              .toList(),
          actions: (data['actions'] as List?)?.cast<String>(),
          status: data['status'] as String?,
        ),
      _ => AgentCard.infoCard(title: '未知卡片类型', content: '无法解析的 Agent 卡片: $type'),
    };
  }

  /// 获取卡片类型
  AgentCardType get cardType => switch (this) {
    AlertAgentCard() => AgentCardType.alert_card,
    ConfirmAgentCard() => AgentCardType.confirm_card,
    InfoAgentCard() => AgentCardType.info_card,
    ActionAgentCard() => AgentCardType.action_card,
  };
}

/// 信息卡片的键值对字段
@freezed
class InfoField with _$InfoField {
  const factory InfoField({
    required String label,    // 字段标签
    required String value,    // 字段值
  }) = _InfoField;

  factory InfoField.fromJson(Map<String, dynamic> json) {
    return InfoField(
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );
  }
}

/// 动作卡片的结果项
@freezed
class ActionResult with _$ActionResult {
  const factory ActionResult({
    required String label,    // 结果标签
    required String value,    // 结果值
    String? status,           // 状态：success / failed / pending
  }) = _ActionResult;

  factory ActionResult.fromJson(Map<String, dynamic> json) {
    return ActionResult(
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
      status: json['status'] as String?,
    );
  }
}