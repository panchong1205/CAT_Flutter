import 'package:flutter/material.dart';

/// Badge 颜色变体枚举
enum CatBadgeVariant { primary, success, warning, danger, info, neutral }

/// 设计系统徽章组件
///
/// 以圆角矩形标签展示状态、标签或分类信息，
/// 支持六种颜色变体、实心/描边两种样式和可选图标。
class CatBadge extends StatelessWidget {
  final String label;
  final CatBadgeVariant variant;
  final bool outlined;
  final IconData? icon;
  final double fontSize;

  const CatBadge({
    super.key,
    required this.label,
    this.variant = CatBadgeVariant.primary,
    this.outlined = false,
    this.icon,
    this.fontSize = 11,
  });

  Color _bgColor() {
    switch (variant) {
      case CatBadgeVariant.primary:
        return const Color(0xFF58A6FF);
      case CatBadgeVariant.success:
        return const Color(0xFF3FB950);
      case CatBadgeVariant.warning:
        return const Color(0xFFD29922);
      case CatBadgeVariant.danger:
        return const Color(0xFFF85149);
      case CatBadgeVariant.info:
        return const Color(0xFF5AC8FA);
      case CatBadgeVariant.neutral:
        return const Color(0xFF8B949E);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _bgColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : color.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
        border: outlined ? Border.all(color: color, width: 1) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize + 2, color: outlined ? color : color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: outlined ? color : color,
            ),
          ),
        ],
      ),
    );
  }
}