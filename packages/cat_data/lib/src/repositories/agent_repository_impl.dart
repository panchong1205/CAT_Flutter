import 'package:cat_domain/cat_domain.dart';
import '../services/agent_chat_service.dart';

/// Agent Repository 实现
///
/// 封装 AgentChatService（Mock），实现 agent_repository.dart 中定义的抽象接口。
/// 提供流式消息响应和操作确认能力。
class AgentRepositoryImpl implements AgentRepository {
  final AgentChatService _service = AgentChatService();

  /// 发送消息并获取流式响应
  @override
  Stream<AgentMessage> sendMessageStream({
    required String content,
    List<AgentCard>? contextCards,
  }) {
    return _service.sendMessage(content, contextCards: contextCards);
  }

  /// 执行卡片操作确认
  @override
  Future<AgentMessage> confirmAction({
    required String actionId,
    required bool confirmed,
  }) {
    return _service.confirmAction(actionId, confirmed);
  }

  /// 获取基于告警上下文的 Agent 建议
  @override
  Future<AgentMessage?> getSuggestionForAlert(Map<String, dynamic> alertContext) {
    return _service.getSuggestionForAlert(alertContext);
  }

  /// 获取历史消息
  List<AgentMessage> get history => _service.history;

  /// 清除对话历史
  void clearHistory() => _service.clearHistory();

  /// 释放所有资源
  @override
  void dispose() => _service.dispose();
}