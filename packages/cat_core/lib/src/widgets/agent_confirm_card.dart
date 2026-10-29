import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// Agent 确认卡片组件
///
/// 需要用户确认的操作卡片，包含确认和取消按钮。
/// 严重程度影响边框和按钮颜色。
class AgentConfirmCardWidget extends StatelessWidget {
  final ConfirmAgentCard card;
  final void Function(bool confirmed)? onConfirm;

  const AgentConfirmCardWidget({
    super.key,
    required this.card,
    this.onConfirm,
  });

  Color _severityColor() {
    return switch (card.severity) {
      'danger' => CatColors.alertCritical,
      'warning' => CatColors.alertWarning,
      _ => CatColors.alertInfo,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final severityColor = _severityColor();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: severityColor.withAlpha(80)),
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
                    color: severityColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.help_outline, size: 20, color: severityColor),
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
            const SizedBox(height: 10),
            // 描述
            Text(
              card.message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),
            // 确认/取消按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 取消按钮
                SizedBox(
                  height: 34,
                  child: OutlinedButton(
                    onPressed: () => onConfirm?.call(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: BorderSide(color: Colors.grey.withAlpha(80)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(card.cancelLabel ?? '取消', style: const TextStyle(fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 10),
                // 确认按钮
                SizedBox(
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () => onConfirm?.call(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: severityColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 0,
                    ),
                    child: Text(card.confirmLabel ?? '确认', style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}