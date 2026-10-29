import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// 任务状态时间线组件
///
/// 以纵向时间线形式展示任务从创建到完成的完整生命周期：
/// 创建 → 接受/开始 → 完成（或取消）
class MissionTimeline extends StatelessWidget {
  final Mission mission;

  const MissionTimeline({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nodes = _buildTimelineNodes();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('任务时间线', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        for (var i = 0; i < nodes.length; i++)
          _TimelineNode(
            node: nodes[i],
            isFirst: i == 0,
            isLast: i == nodes.length - 1,
          ),
      ],
    );
  }

  /// 构建时间线节点列表
  List<_TimelineNodeData> _buildTimelineNodes() {
    final nodes = <_TimelineNodeData>[];

    // 1. 任务创建
    nodes.add(_TimelineNodeData(
      icon: Icons.add_circle_outline,
      title: '任务创建',
      subtitle: mission.name,
      time: _formatDateTime(mission.createdAt),
      color: CatColors.tabletPrimary,
      completed: true,
    ));

    // 2. 任务开始（已接受/执行中）
    if (mission.startedAt != null) {
      nodes.add(_TimelineNodeData(
        icon: Icons.play_circle_outline,
        title: '任务开始',
        subtitle: '车辆 ${mission.vehicleId} 开始执行',
        time: _formatDateTime(mission.startedAt!),
        color: CatColors.online,
        completed: true,
      ));
    } else if (mission.status == 'pending') {
      // 待接受状态，开始节点为灰色
      nodes.add(_TimelineNodeData(
        icon: Icons.play_circle_outline,
        title: '等待接受',
        subtitle: '等待驾驶员接受任务',
        time: '--',
        color: Colors.grey,
        completed: false,
      ));
    }

    // 3. 任务完成或取消
    if (mission.status == 'completed' && mission.completedAt != null) {
      nodes.add(_TimelineNodeData(
        icon: Icons.check_circle_outline,
        title: '任务完成',
        subtitle: '装载 ${mission.currentLoad.toStringAsFixed(0)} 吨完成',
        time: _formatDateTime(mission.completedAt!),
        color: CatColors.online,
        completed: true,
      ));
    } else if (mission.status == 'cancelled') {
      nodes.add(_TimelineNodeData(
        icon: Icons.cancel_outlined,
        title: '任务取消',
        subtitle: '任务已被取消',
        time: '--',
        color: CatColors.alertCritical,
        completed: true,
      ));
    } else if (mission.status == 'in_progress') {
      // 进行中但未完成
      nodes.add(_TimelineNodeData(
        icon: Icons.check_circle_outline,
        title: '等待完成',
        subtitle: '预估还需 ${_remainingLoad().toStringAsFixed(0)} 吨',
        time: '--',
        color: Colors.grey,
        completed: false,
      ));
    }

    return nodes;
  }

  /// 计算剩余装载量
  double _remainingLoad() {
    return (mission.targetLoad - mission.currentLoad).clamp(0, double.infinity);
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} '
        '${_pad(dt.hour)}:${_pad(dt.minute)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}

/// 时间线节点数据
class _TimelineNodeData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  final bool completed;

  const _TimelineNodeData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
    required this.completed,
  });
}

/// 时间线单个节点
class _TimelineNode extends StatelessWidget {
  final _TimelineNodeData node;
  final bool isFirst;
  final bool isLast;

  const _TimelineNode({
    required this.node,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final effectiveColor = node.completed ? node.color : Colors.grey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧时间线轴线 + 图标
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // 上方连线
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 8,
                    color: Colors.grey.withAlpha(80),
                  )
                else
                  const SizedBox(height: 8),
                // 节点图标
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: effectiveColor.withAlpha(node.completed ? 25 : 15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: effectiveColor.withAlpha(node.completed ? 150 : 80),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(node.icon, size: 16, color: effectiveColor),
                ),
                // 下方连线
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: node.completed ? effectiveColor.withAlpha(80) : Colors.grey.withAlpha(40),
                    ),
                  )
                else
                  const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // 右侧内容区域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    node.title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: effectiveColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    node.subtitle,
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    node.time,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}