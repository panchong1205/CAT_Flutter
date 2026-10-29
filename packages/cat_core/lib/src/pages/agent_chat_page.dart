import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import '../providers/agent_provider.dart';
import '../widgets/agent_message_bubble.dart';

/// Agent AI 对话页面
///
/// 聊天界面，包含消息气泡列表和底部输入框。
/// 支持流式打字机输出效果和结构化卡片交互。
/// 页面首次打开时自动展示欢迎消息。
class AgentChatPage extends ConsumerStatefulWidget {
  const AgentChatPage({super.key});

  @override
  ConsumerState<AgentChatPage> createState() => _AgentChatPageState();
}

class _AgentChatPageState extends ConsumerState<AgentChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _showWelcomeIfNeeded();
  }

  /// 首次打开展示欢迎消息
  void _showWelcomeIfNeeded() {
    final initialized = ref.read(agentInitializedProvider);
    if (!initialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(agentInitializedProvider.notifier).state = true;
        final notifier = ref.read(agentChatProvider.notifier);
        if (ref.read(agentChatProvider).messages.isEmpty) {
          notifier.sendMessage('帮助');
        }
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 发送消息
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.unfocus();

    ref.read(agentChatProvider.notifier).sendMessage(text);
  }

  /// 处理卡片操作按钮
  void _onCardAction(String action) {
    // 将卡片操作作为消息发送给 Agent
    ref.read(agentChatProvider.notifier).sendMessage(action);
  }

  /// 处理确认/取消卡片
  void _onConfirmAction(String actionId, bool confirmed) {
    ref.read(agentChatProvider.notifier).confirmAction(actionId, confirmed);
  }

  /// 处理快捷操作点击
  void _onQuickAction(String action) {
    ref.read(agentChatProvider.notifier).sendMessage(action);
  }

  /// 滚动到底部
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(agentChatProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.colorScheme;

    // 新消息到达时自动滚动
    chatState.messages;
    _scrollToBottom();

    return Column(
      children: [
        // 顶部标题栏
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              bottom: BorderSide(color: theme.dividerColor, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: CatColors.tabletPrimary.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.smart_toy, size: 20, color: CatColors.tabletPrimary),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUSTOM AI 助手', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: CatColors.online,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        chatState.isLoading ? '正在输入...' : '在线',
                        style: textTheme.labelSmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // 清除对话按钮
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                tooltip: '清除对话',
                onPressed: () {
                  ref.read(agentChatProvider.notifier).clearHistory();
                  ref.read(agentInitializedProvider.notifier).state = false;
                  _showWelcomeIfNeeded();
                },
              ),
            ],
          ),
        ),

        // 消息列表
        Expanded(
          child: chatState.messages.isEmpty
              ? _buildEmptyState(textTheme)
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  itemCount: chatState.messages.length,
                  itemBuilder: (context, index) {
                    final msg = chatState.messages[index];
                    return AgentMessageBubble(
                      key: ValueKey(msg.id),
                      message: msg,
                      onCardAction: _onCardAction,
                      onConfirmAction: _onConfirmAction,
                    );
                  },
                ),
        ),

        // 底部输入栏
        _buildInputBar(colors, textTheme),
      ],
    );
  }

  /// 空白状态
  Widget _buildEmptyState(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.smart_toy, size: 64, color: Colors.grey.withAlpha(80)),
          const SizedBox(height: 16),
          Text('CUSTOM AI 助手', style: textTheme.headlineSmall?.copyWith(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            '输入消息开始对话，或点击下方快捷操作',
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // 快捷操作
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildQuickActionChip('查询车队状态', Icons.precision_manufacturing),
              _buildQuickActionChip('查看当前告警', Icons.warning_amber),
              _buildQuickActionChip('任务管理', Icons.assignment),
              _buildQuickActionChip('获取运营建议', Icons.lightbulb_outline),
              _buildQuickActionChip('系统状态', Icons.monitor_heart),
            ],
          ),
        ],
      ),
    );
  }

  /// 快捷操作 Chip
  Widget _buildQuickActionChip(String label, IconData icon) {
    final theme = Theme.of(context);
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      onPressed: () => _onQuickAction(label),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      side: BorderSide(color: Colors.grey.withAlpha(40)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  /// 底部输入栏
  Widget _buildInputBar(ColorScheme colors, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              onSubmitted: (_) => _sendMessage(),
              textInputAction: TextInputAction.send,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '输入消息...',
                hintStyle: textTheme.bodySmall?.copyWith(color: Colors.grey),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                isDense: true,
              ),
              style: textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          // 发送按钮
          Container(
            decoration: BoxDecoration(
              color: CatColors.tabletPrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
              onPressed: _sendMessage,
              tooltip: '发送',
            ),
          ),
        ],
      ),
    );
  }
}