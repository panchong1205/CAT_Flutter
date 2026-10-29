import 'package:freezed_annotation/freezed_annotation.dart';
import 'agent_card.dart';

part 'agent_message.freezed.dart';

/// AI Agent 消息实体
///
/// 表示与 AI 助手的一次对话消息。
/// 支持文本内容 + 结构化卡片（AlertCard / ConfirmCard / InfoCard / ActionCard）。
@freezed
class AgentMessage with _$AgentMessage {
  const factory AgentMessage({
    required String id,           // 消息唯一标识
    required String content,      // 消息内容
    required String role,         // 角色：user / assistant / system
    required DateTime timestamp,  // 消息时间戳
    String? commandType,          // 指令类型（仅 assistant 消息）：query_fleet / start_mission / acknowledge_alert
    Map<String, dynamic>? data,   // 附加数据
    List<AgentCard>? cards,       // 结构化卡片列表（仅 assistant 消息）
    bool? isStreaming,            // 是否仍在流式输出中
  }) = _AgentMessage;
}