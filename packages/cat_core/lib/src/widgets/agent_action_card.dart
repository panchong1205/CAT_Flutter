import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// Agent 动作卡片组件
///
/// 提供多个操作选项供用户选择。
/// 可展示操作结果状态（成功/失败/进行中）。
class AgentActionCardWidget extends StatelessWidget {
  final ActionAgentCard card;
  final void Function(String action)? onAction;

  const AgentActionCardWidget({
    super.key,
    required this.card,
    this.onAction,
  });

  Color _statusColor() {
    return switch (card.status) {
      'success' => CatColors.online,
      'failed' => CatColors.alertCritical,
      _ => CatColors.alertInfo,
    };
  }

  IconData _statusIcon() {
    return switch (card.status) {
      'success' => Icons.check_circle,
      'failed' => Icons.error,
      _ => Icons.pending,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.withAlpha(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行
            Row(
              children: [
                if (card.status != null) ...[
                  Icon(_statusIcon(), size: 18, color: _statusColor()),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    card.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // 描述
            if (card.description != null) ...[
              const SizedBox(height: 6),
              Text(
                card.description!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
            // 操作结果
            if (card.results != null && card.results!.isNotEmpty) ...[
              const SizedBox(height: 10),
              ...card.results!.map((result) {
                Color resultColor;
                IconData resultIcon;
                switch (result.status) {
                  case 'success':
                    resultColor = CatColors.online;
                    resultIcon = Icons.check_circle;
                  case 'failed':
                    resultColor = CatColors.alertCritical;
                    resultIcon = Icons.error;
                  default:
                    resultColor = Colors.grey;
                    resultIcon = Icons.pending;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(resultIcon, size: 14, color: resultColor),
                      const SizedBox(width: 6),
                      Text(
                        result.label,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        result.value,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: resultColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            // 操作按钮
            if (card.actions != null && card.actions!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: card.actions!.map((action) {
                  final isPrimary = card.actions!.indexOf(action) == 0;
                  return SizedBox(
                    height: 32,
                    child: isPrimary
                        ? ElevatedButton(
                            onPressed: () => onAction?.call(action),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CatColors.tabletPrimary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              elevation: 0,
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: Text(action),
                          )
                        : OutlinedButton(
                            onPressed: () => onAction?.call(action),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: CatColors.tabletPrimary,
                              side: BorderSide(color: CatColors.tabletPrimary.withAlpha(60)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: Text(action),
                          ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}