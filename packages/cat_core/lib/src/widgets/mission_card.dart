import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// 任务摘要卡片组件（可复用）
///
/// 在任务列表中展示单个运输任务的摘要信息，
/// 包含任务名称、状态、装载/卸载点、进度条和优先级标识。
class MissionCard extends StatelessWidget {
  final Mission mission;
  final VoidCallback? onTap;

  const MissionCard({super.key, required this.mission, this.onTap});

  /// 获取任务状态的显示标签
  String _statusLabel(String status) {
    switch (status) {
      case 'pending':
        return '待接受';
      case 'in_progress':
        return '进行中';
      case 'completed':
        return '已完成';
      case 'cancelled':
        return '已取消';
      default:
        return status;
    }
  }

  /// 获取任务状态对应的颜色
  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return CatColors.alertWarning;
      case 'in_progress':
        return CatColors.online;
      case 'completed':
        return CatColors.tabletPrimary;
      case 'cancelled':
        return CatColors.offline;
      default:
        return CatColors.offline;
    }
  }

  /// 获取状态对应的图标
  IconData _statusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.schedule;
      case 'in_progress':
        return Icons.play_circle;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  /// 获取优先级标签
  String _priorityLabel(String? priority) {
    switch (priority) {
      case 'urgent':
        return '紧急';
      case 'high':
        return '高';
      case 'normal':
      default:
        return '普通';
    }
  }

  /// 获取优先级颜色
  Color _priorityColor(String? priority) {
    switch (priority) {
      case 'urgent':
        return CatColors.alertCritical;
      case 'high':
        return CatColors.alertWarning;
      case 'normal':
      default:
        return Colors.grey;
    }
  }

  /// 计算任务进度百分比
  double _progress() {
    if (mission.targetLoad <= 0) return 0;
    return (mission.currentLoad / mission.targetLoad).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusColor = _statusColor(mission.status);
    final progress = _progress();

    return CatCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 第一行：任务名称 + 优先级 + 状态
          Row(
            children: [
              Icon(_statusIcon(mission.status), size: 20, color: statusColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  mission.name,
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 优先级标签
              if (mission.priority == 'urgent' || mission.priority == 'high')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _priorityColor(mission.priority).withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _priorityLabel(mission.priority),
                    style: TextStyle(
                      fontSize: 10,
                      color: _priorityColor(mission.priority),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              // 状态 Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: statusColor.withAlpha(80), width: 0.5),
                ),
                child: Text(
                  _statusLabel(mission.status),
                  style: TextStyle(
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 第二行：装载点 → 卸载点
          Row(
            children: [
              const Icon(Icons.trip_origin, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Flexible(child: Text(mission.loadPoint, style: textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
              const SizedBox(width: 8),
              const Icon(Icons.location_on, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Flexible(child: Text(mission.unloadPoint, style: textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
            ],
          ),

          const SizedBox(height: 10),

          // 第三行：进度条 + 装载量
          if (mission.status == 'in_progress' || mission.status == 'completed') ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress >= 1.0 ? CatColors.online : CatColors.tabletPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${mission.currentLoad.toStringAsFixed(0)} / ${mission.targetLoad.toStringAsFixed(0)} 吨',
                  style: textTheme.bodySmall?.copyWith(
                    color: progress >= 1.0 ? CatColors.online : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],

          // 第四行：时间信息
          Row(
            children: [
              const Icon(Icons.access_time, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                _formatTime(mission.createdAt),
                style: textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 11),
              ),
              const Spacer(),
              // 车辆关联信息
              const Icon(Icons.local_shipping, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  mission.vehicleId,
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 格式化时间显示
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} 分钟前';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} 小时前';
    } else {
      return '${diff.inDays} 天前';
    }
  }
}