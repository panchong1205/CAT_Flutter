import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// Agent 告警卡片组件
///
/// 在 Agent 对话中展示一条告警详情，内置操作按钮。
/// 告警级别影响卡片左侧边框和标题颜色。
class AgentAlertCardWidget extends StatelessWidget {
  final AlertAgentCard card;
  final void Function(String action)? onAction;

  const AgentAlertCardWidget({
    super.key,
    required this.card,
    this.onAction,
  });

  Color _levelColor() {
    return switch (card.level) {
      'critical' => CatColors.alertCritical,
      'warning' => CatColors.alertWarning,
      _ => CatColors.alertInfo,
    };
  }

  IconData _levelIcon() {
    return switch (card.level) {
      'critical' => Icons.report,
      'warning' => Icons.warning_amber,
      _ => Icons.info_outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final levelColor = _levelColor();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: levelColor.withAlpha(80)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 左侧颜色条
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: levelColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            // 内容区
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题行
                    Row(
                      children: [
                        Icon(_levelIcon(), size: 18, color: levelColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            card.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: levelColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // 详情
                    Text(
                      card.message,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (card.vehicleName != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.precision_manufacturing, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            card.vehicleName!,
                            style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                    // 操作按钮
                    if (card.actions != null && card.actions!.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: card.actions!.map((action) {
                          return _buildActionButton(context, action, levelColor);
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String action, Color levelColor) {
    final isPrimary = action == '暂停作业' || action == '发送警告' || action == '规划路线';

    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () => onAction?.call(action),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? levelColor : Colors.grey.withAlpha(20),
          foregroundColor: isPrimary ? Colors.white : levelColor,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: isPrimary ? BorderSide.none : BorderSide(color: levelColor.withAlpha(60)),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        child: Text(action),
      ),
    );
  }
}