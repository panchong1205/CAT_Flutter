import '../entities/agent_message.dart';

/// 发送 Agent 指令 UseCase
///
/// 向 AI 助手发送自然语言指令，返回助手响应。
abstract class SendAgentCommand {
  /// 发送指令
  ///
  /// [content] 用户输入的自然语言指令
  /// 返回助手的响应消息
  Future<AgentMessage> call({required String content});
}