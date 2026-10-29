import '../entities/agent_message.dart';
import '../entities/agent_card.dart';

/// Agent 聊天 Repository 抽象接口
///
/// 定义与 AI Agent 对话的数据访问契约。
abstract class AgentRepository {
  /// 发送消息并获取流式响应
  ///
  /// [content] 用户输入的自然语言指令
  /// 返回流式消息流，支持逐字输出的打字机效果
  Stream<AgentMessage> sendMessageStream({
    required String content,
    List<AgentCard>? contextCards,
  });

  /// 执行卡片操作确认
  ///
  /// [actionId] 确认卡片上的操作 ID
  /// [confirmed] 用户是否确认执行
  /// 返回操作结果消息
  Future<AgentMessage> confirmAction({
    required String actionId,
    required bool confirmed,
  });

  /// 获取 Mock Agent 推荐消息（基于当前告警上下文自动触发）
  ///
  /// [alertContext] 当前活跃告警的上下文信息
  Future<AgentMessage?> getSuggestionForAlert(Map<String, dynamic> alertContext);

  /// 释放资源
  void dispose();
}