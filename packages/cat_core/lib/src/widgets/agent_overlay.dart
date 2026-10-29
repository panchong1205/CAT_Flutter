import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/agent_provider.dart';
import '../pages/agent_chat_page.dart';

/// Agent 浮动叠加层
///
/// 可从任意页面唤起的 Agent 对话浮动面板。
/// 通过 [agentOverlayVisibleProvider] 控制显示/隐藏。
/// 支持从底部滑入的半屏模式或右上角 POPOVER 小窗模式。
class AgentOverlay extends ConsumerWidget {
  /// 是否以 POPOVER 小窗模式展示（桌面端）
  final bool popover;

  /// 关闭回调
  final VoidCallback? onDismiss;

  const AgentOverlay({
    super.key,
    this.popover = false,
    this.onDismiss,
  });

  /// 在目标上下文中显示 Agent Overlay
  static void show(BuildContext context, {bool popover = false}) {
    ProviderScope.containerOf(context)
        .read(agentOverlayVisibleProvider.notifier)
        .state = true;
  }

  /// 隐藏 Agent Overlay
  static void hide(BuildContext context) {
    ProviderScope.containerOf(context)
        .read(agentOverlayVisibleProvider.notifier)
        .state = false;
  }

  void _dismiss(WidgetRef ref) {
    onDismiss?.call();
    ref.read(agentOverlayVisibleProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(agentOverlayVisibleProvider);

    if (!isVisible) return const SizedBox.shrink();

    if (popover) {
      return _buildPopover(context, ref);
    }
    return _buildBottomSheet(context, ref);
  }

  /// POPOVER 小窗模式（桌面端/Tablet）
  Widget _buildPopover(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 背景遮罩
        GestureDetector(
          onTap: () => _dismiss(ref),
          child: Container(color: Colors.black.withAlpha(60)),
        ),
        // 浮动面板
        Positioned(
          right: 20,
          top: kToolbarHeight + 20,
          width: screenSize.width * 0.35,
          height: screenSize.height * 0.6,
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildPanelContent(context, ref, true),
            ),
          ),
        ),
      ],
    );
  }

  /// 底部滑入模式（移动端/Phone）
  Widget _buildBottomSheet(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // 背景遮罩
        GestureDetector(
          onTap: () => _dismiss(ref),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: Colors.black.withAlpha(100),
          ),
        ),
        // 底部面板
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Material(
            elevation: 16,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: _buildPanelContent(context, ref, false),
            ),
          ),
        ),
      ],
    );
  }

  /// 面板内容
  Widget _buildPanelContent(
    BuildContext context,
    WidgetRef ref,
    bool isPopover,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // 顶部拖拽条 + 关闭按钮
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
          ),
          child: Row(
            children: [
              // 拖拽指示条（底部模式）
              if (!isPopover)
                Expanded(
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(80),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              // 关闭
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => _dismiss(ref),
                tooltip: '关闭',
                splashRadius: 16,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // 实际聊天页面
        const Expanded(child: AgentChatPage()),
      ],
    );
  }
}