import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// Agent 信息卡片组件
///
/// 纯信息展示卡片，支持键值对字段列表。
/// 可配置不同图标以区分信息类型。
class AgentInfoCardWidget extends StatelessWidget {
  final InfoAgentCard card;

  const AgentInfoCardWidget({super.key, required this.card});

  IconData _icon() {
    return switch (card.iconName) {
      'success' => Icons.check_circle_outline,
      'warning' => Icons.warning_amber,
      'info' => Icons.info_outline,
      _ => Icons.info_outline,
    };
  }

  Color _iconColor() {
    return switch (card.iconName) {
      'success' => CatColors.online,
      'warning' => CatColors.alertWarning,
      _ => CatColors.alertInfo,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = _iconColor();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: iconColor.withAlpha(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_icon(), size: 20, color: iconColor),
                ),
                const SizedBox(width: 10),
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
            if (card.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                card.content,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
            // 键值对字段列表
            if (card.fields != null && card.fields!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withAlpha(80),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: card.fields!.map((field) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                field.label,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              field.value,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}