import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';

/// 车辆状态指示器组件
///
/// 用于车辆卡片、详情页等展示在线/离线/告警状态。
/// 根据 [status] 自动计算状态标签和颜色。
class VehicleStatusBadge extends StatelessWidget {
  final String status;
  final bool online;
  final double fontSize;

  const VehicleStatusBadge({
    super.key,
    required this.status,
    required this.online,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    final label = _statusLabel(status);
    final color = _statusColor(status, online);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withAlpha(80), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: fontSize, color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'moving':
        return '行驶中';
      case 'idle':
        return '空闲';
      case 'loading':
        return '装载中';
      case 'dumping':
        return '卸料中';
      case 'charging':
        return '充电中';
      default:
        return status;
    }
  }

  Color _statusColor(String status, bool online) {
    if (!online) return CatColors.offline;
    switch (status) {
      case 'moving':
        return CatColors.online;
      case 'loading':
      case 'dumping':
        return CatColors.alertWarning;
      case 'charging':
        return CatColors.alertInfo;
      default:
        return CatColors.offline;
    }
  }
}