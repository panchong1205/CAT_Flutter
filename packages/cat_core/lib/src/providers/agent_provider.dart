import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';

/// Agent 对话状态
class AgentChatState {
  final List<AgentMessage> messages;
  final bool isLoading;
  final String? streamingMessageId;

  const AgentChatState({
    this.messages = const [],
    this.isLoading = false,
    this.streamingMessageId,
  });

  AgentChatState copyWith({
    List<AgentMessage>? messages,
    bool? isLoading,
    String? streamingMessageId,
  }) {
    return AgentChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      streamingMessageId: streamingMessageId ?? this.streamingMessageId,
    );
  }
}

/// Agent 聊天状态管理 Notifier
///
/// 管理对话消息列表、流式消息更新、操作确认等状态。
class AgentChatNotifier extends StateNotifier<AgentChatState> {
  final AgentRepositoryImpl _repo;

  AgentChatNotifier(this._repo) : super(const AgentChatState());

  /// 获取 AgentRepository 实例
  AgentRepositoryImpl get repository => _repo;

  /// 发送用户消息
  ///
  /// 将用户输入发送给 Agent，通过流式返回逐字更新助手回复。
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // 标记开始加载
    state = state.copyWith(isLoading: true);

    try {
      await for (final msg in _repo.sendMessageStream(content: content)) {
        final messages = List<AgentMessage>.from(state.messages);

        if (msg.role == 'user') {
          // 添加用户消息
          messages.add(msg);
          state = state.copyWith(
            messages: messages,
            isLoading: true,
          );
        } else {
          // 更新或新增助手消息
          final existingIdx = messages.indexWhere(
            (m) => m.role == 'assistant' && m.id == msg.id,
          );

          if (existingIdx >= 0) {
            messages[existingIdx] = msg;
          } else {
            messages.add(msg);
          }

          state = state.copyWith(
            messages: messages,
            isLoading: msg.isStreaming == true,
            streamingMessageId: msg.isStreaming == true ? msg.id : null,
          );
        }
      }
    } catch (e) {
      // 加载失败
      final messages = List<AgentMessage>.from(state.messages);
      messages.add(AgentMessage(
        id: 'error_${DateTime.now().millisecondsSinceEpoch}',
        content: '抱歉，处理您的请求时出错了：$e',
        role: 'system',
        timestamp: DateTime.now(),
      ));
      state = state.copyWith(messages: messages, isLoading: false);
    }
  }

  /// 确认/取消卡片操作
  Future<void> confirmAction(String actionId, bool confirmed) async {
    final result = await _repo.confirmAction(
      actionId: actionId,
      confirmed: confirmed,
    );

    final messages = List<AgentMessage>.from(state.messages);
    messages.add(result);
    state = state.copyWith(messages: messages);
  }

  /// 处理告警触发的 Agent 建议
  Future<void> handleAlertSuggestion(Map<String, dynamic> alertContext) async {
    final suggestion = await _repo.getSuggestionForAlert(alertContext);
    if (suggestion != null) {
      final messages = List<AgentMessage>.from(state.messages);
      messages.add(suggestion);
      state = state.copyWith(messages: messages);
    }
  }

  /// 清除对话历史
  void clearHistory() {
    _repo.clearHistory();
    state = const AgentChatState();
  }
}

/// Agent 聊天 Notifier Provider
final agentChatProvider =
    StateNotifierProvider<AgentChatNotifier, AgentChatState>((ref) {
  final repo = di<AgentRepositoryImpl>();
  return AgentChatNotifier(repo);
});

/// Agent Overlay 可见性 Provider
///
/// 控制从任意页面唤起 Agent 浮动面板的显示/隐藏。
final agentOverlayVisibleProvider = StateProvider<bool>((ref) => false);

/// Agent 初始化状态标记 Provider
///
/// 标记 Agent Chat 页面首次打开时是否应先展示一条欢迎消息。
final agentInitializedProvider = StateProvider<bool>((ref) => false);