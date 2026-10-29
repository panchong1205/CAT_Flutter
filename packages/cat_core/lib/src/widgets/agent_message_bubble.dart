import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import 'agent_alert_card.dart';
import 'agent_confirm_card.dart';
import 'agent_info_card.dart';
import 'agent_action_card.dart';

/// Agent 消息气泡组件
///
/// 根据角色（user/assistant/system）渲染不同样式的消息气泡。
/// 支持文本内容 + 内嵌结构化卡片 + 流式输出打字机光标。
/// 当 [isStreaming] 为 true 时，在文本末尾显示闪烁光标。
class AgentMessageBubble extends StatefulWidget {
  /// 消息数据
  final AgentMessage message;

  /// 卡片操作回调（ActionCard 按钮点击）
  final void Function(String action)? onCardAction;

  /// 确认/取消回调（ConfirmCard 按钮点击）
  final void Function(String actionId, bool confirmed)? onConfirmAction;

  const AgentMessageBubble({
    super.key,
    required this.message,
    this.onCardAction,
    this.onConfirmAction,
  });

  @override
  State<AgentMessageBubble> createState() => _AgentMessageBubbleState();
}

class _AgentMessageBubbleState extends State<AgentMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _updateCursorAnimation();
  }

  @override
  void didUpdateWidget(covariant AgentMessageBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCursorAnimation();
  }

  void _updateCursorAnimation() {
    if (widget.message.isStreaming == true) {
      _cursorController.repeat(reverse: true);
    } else {
      _cursorController.stop();
      _cursorController.value = 0;
    }
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.role == 'user';
    final isSystem = widget.message.role == 'system';
    final theme = Theme.of(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // 消息气泡主体
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSystem
                    ? Colors.orange.withAlpha(15)
                    : isUser
                        ? CatColors.tabletPrimary.withAlpha(isDark(context) ? 30 : 15)
                        : isDark(context)
                            ? Colors.white.withAlpha(10)
                            : Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 文本内容 + 打字机光标
                  _buildTextContent(theme),
                  // 结构化卡片
                  if (widget.message.cards != null &&
                      widget.message.cards!.isNotEmpty &&
                      widget.message.isStreaming != true) ...[
                    const SizedBox(height: 8),
                    ...widget.message.cards!.map((card) => _buildCard(card)),
                  ],
                ],
              ),
            ),
            // 时间戳
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
              child: Text(
                _formatTime(widget.message.timestamp),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 文本内容渲染（含打字机光标动画）
  Widget _buildTextContent(ThemeData theme) {
    final isStreaming = widget.message.isStreaming == true;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.message.content,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          if (isStreaming)
            WidgetSpan(
              child: FadeTransition(
                opacity: _cursorController,
                child: Container(
                  width: 2,
                  height: 16,
                  margin: const EdgeInsets.only(left: 1),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
        ],
      ),
    );
  }

  /// 根据卡片类型构建对应的 Widget
  Widget _buildCard(AgentCard card) {
    return switch (card) {
      AlertAgentCard() => AgentAlertCardWidget(
          card: card,
          onAction: widget.onCardAction,
        ),
      ConfirmAgentCard() => AgentConfirmCardWidget(
          card: card,
          onConfirm: (confirmed) =>
              widget.onConfirmAction?.call(card.actionId, confirmed),
        ),
      InfoAgentCard() => AgentInfoCardWidget(card: card),
      ActionAgentCard() => AgentActionCardWidget(
          card: card,
          onAction: widget.onCardAction,
        ),
    };
  }

  /// 格式化时间戳
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// 判断当前是否为暗色模式
  bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}