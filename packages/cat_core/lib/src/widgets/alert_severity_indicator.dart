import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';

/// 告警严重程度指示器
///
/// 以图标 + 文字标签的形式展示告警级别：
/// - critical：红色，紧急图标
/// - warning：橙色，警告图标
/// - info：蓝色，信息图标
class AlertSeverityIndicator extends StatelessWidget {
  /// 告警级别：critical / warning / info
  final String level;
  /// 是否显示文字标签
  final bool showLabel;
  /// 图标大小
  final double iconSize;
  /// 字体大小
  final double fontSize;

  const AlertSeverityIndicator({
    super.key,
    required this.level,
    this.showLabel = true,
    this.iconSize = 18,
    this.fontSize = 13,
  });

  /// 获取严重级别对应的颜色
  static Color colorForLevel(String level) {
    switch (level) {
      case 'critical':
        return CatColors.alertCritical;
      case 'warning':
        return CatColors.alertWarning;
      case 'info':
        return CatColors.alertInfo;
      default:
        return CatColors.offline;
    }
  }

  /// 获取严重级别对应的图标
  static IconData iconForLevel(String level) {
    switch (level) {
      case 'critical':
        return Icons.report;
      case 'warning':
        return Icons.warning_amber;
      case 'info':
        return Icons.info_outline;
      default:
        return Icons.help_outline;
    }
  }

  /// 获取严重级别的中文标签
  static String labelForLevel(String level) {
    switch (level) {
      case 'critical':
        return '严重';
      case 'warning':
        return '警告';
      case 'info':
        return '提示';
      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = colorForLevel(level);
    final icon = iconForLevel(level);
    final label = labelForLevel(level);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: color),
        if (showLabel) ...[
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}