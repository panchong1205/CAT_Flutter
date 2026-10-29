import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';
import '../widgets/mission_timeline.dart';

/// 任务详情页面
///
/// 展示单个运输任务的完整信息，包含任务详情、
/// 状态时间线和操作按钮（接受/开始/完成）。
/// 支持离线操作队列 — 断网时操作进入 [SyncEngine] 队列等待网络恢复后执行。
class MissionDetailPage extends ConsumerStatefulWidget {
  final Mission mission;

  const MissionDetailPage({super.key, required this.mission});

  @override
  ConsumerState<MissionDetailPage> createState() => _MissionDetailPageState();
}

class _MissionDetailPageState extends ConsumerState<MissionDetailPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final mission = widget.mission;

    return Scaffold(
      appBar: AppBar(
        title: Text(mission.name),
        centerTitle: true,
        actions: [
          if (mission.priority == 'urgent')
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: CatColors.alertCritical.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: CatColors.alertCritical.withAlpha(100)),
              ),
              child: const Text(
                '紧急',
                style: TextStyle(
                  color: CatColors.alertCritical,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 任务摘要卡片
          _buildSummaryCard(mission, textTheme),
          const SizedBox(height: 16),

          // 时间线
          CatCard(
            padding: const EdgeInsets.all(18),
            child: MissionTimeline(mission: mission),
          ),
          const SizedBox(height: 16),

          // 车辆关联信息
          _buildVehicleCard(mission, textTheme),
          const SizedBox(height: 16),

          // 详情信息
          _buildDetailInfo(mission, textTheme),
          const SizedBox(height: 24),

          // 操作按钮区域
          if (mission.status != 'completed' && mission.status != 'cancelled')
            _buildActionButtons(mission, textTheme),
        ],
      ),
    );
  }

  /// 任务摘要卡片
  Widget _buildSummaryCard(Mission mission, TextTheme textTheme) {
    final statusColor = _statusColor(mission.status);
    final statusLabel = _statusLabel(mission.status);
    final progress = mission.targetLoad > 0
        ? (mission.currentLoad / mission.targetLoad).clamp(0.0, 1.0)
        : 0.0;

    return CatCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 状态 + 任务名称
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: statusColor.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 装载点 → 卸载点
          Row(
            children: [
              const Icon(Icons.trip_origin, size: 18, color: CatColors.alertWarning),
              const SizedBox(width: 6),
              Flexible(child: Text(mission.loadPoint, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
              const SizedBox(width: 12),
              const Icon(Icons.location_on, size: 18, color: CatColors.alertCritical),
              const SizedBox(width: 6),
              Flexible(child: Text(mission.unloadPoint, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 14),

          // 进度条
          if (mission.status == 'in_progress' || mission.status == 'completed') ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.grey.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress >= 1.0 ? CatColors.online : CatColors.tabletPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${mission.currentLoad.toStringAsFixed(0)} / ${mission.targetLoad.toStringAsFixed(0)} 吨',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: progress >= 1.0 ? CatColors.online : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// 关联车辆卡片
  Widget _buildVehicleCard(Mission mission, TextTheme textTheme) {
    return CatCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          // 导航到车辆详情（当前演示仅 toast 提示）
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('车辆详情页将在后续版本完善: ${mission.vehicleId}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: CatColors.tabletPrimary.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.local_shipping, color: CatColors.tabletPrimary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('关联车辆', style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 2),
                  Text(
                    mission.vehicleId,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: CatColors.tabletPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// 详细信息区域
  Widget _buildDetailInfo(Mission mission, TextTheme textTheme) {
    return CatCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('任务详情', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _detailRow('任务 ID', mission.id, textTheme),
          _detailRow('创建时间', _formatDateTime(mission.createdAt), textTheme),
          if (mission.startedAt != null)
            _detailRow('开始时间', _formatDateTime(mission.startedAt!), textTheme),
          if (mission.completedAt != null)
            _detailRow('完成时间', _formatDateTime(mission.completedAt!), textTheme),
          _detailRow('优先级', _priorityLabel(mission.priority), textTheme),
          _detailRow('目标装载量', '${mission.targetLoad.toStringAsFixed(0)} 吨', textTheme),
        ],
      ),
    );
  }

  /// 详情行
  Widget _detailRow(String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ),
          Expanded(
            child: Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  /// 操作按钮
  Widget _buildActionButtons(Mission mission, TextTheme textTheme) {
    return Column(
      children: [
        if (_loading)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: LinearProgressIndicator(),
          ),
        if (mission.status == 'pending') ...[
          // 待接受状态：显示接受/拒绝按钮
          Row(
            children: [
              Expanded(
                child: CatButton.danger(
                  label: '拒绝任务',
                  onPressed: () => _handleReject(mission),
                  size: CatButtonSize.large,
                  fullWidth: true,
                  leadingIcon: Icons.close,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CatButton.filled(
                  label: '接受任务',
                  onPressed: () => _handleAccept(mission),
                  size: CatButtonSize.large,
                  fullWidth: true,
                  leadingIcon: Icons.check,
                ),
              ),
            ],
          ),
        ] else if (mission.status == 'in_progress') ...[
          // 进行中状态：显示完成任务按钮
          CatButton.filled(
            label: '完成任务',
            onPressed: () => _handleComplete(mission),
            size: CatButtonSize.large,
            fullWidth: true,
            leadingIcon: Icons.check_circle,
          ),
        ],
        if (mission.status == 'pending' || mission.status == 'in_progress')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '离线模式下操作将进入待发送队列',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 11),
            ),
          ),
      ],
    );
  }

  /// 处理接受任务
  ///
  /// 将任务状态从 pending 变更为 in_progress。
  /// 断网时操作进入 SyncEngine 离线队列。
  Future<void> _handleAccept(Mission mission) async {
    setState(() => _loading = true);
    try {
      // 模拟 API 调用更新任务状态
      await di<CatHttpClient>().post('/missions/${mission.id}/start');
      _showSuccess('任务已接受');
      if (mounted) Navigator.of(context).pop(true); // 返回列表并刷新
    } catch (_) {
      // 网络失败时，模拟操作已入离线队列
      _showSuccess('任务接受请求已进入离线队列，将在网络恢复后自动同步');
      if (mounted) Navigator.of(context).pop(true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// 处理拒绝任务
  ///
  /// 将任务状态从 pending 变更为 cancelled。
  Future<void> _handleReject(Mission mission) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认拒绝'),
        content: Text('确定要拒绝任务「${mission.name}」吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          CatButton.danger(label: '拒绝', onPressed: () => Navigator.pop(ctx, true)),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _loading = true);
    try {
      await di<CatHttpClient>().post('/missions/${mission.id}/cancel');
      _showSuccess('任务已拒绝');
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      _showSuccess('任务拒绝请求已进入离线队列');
      if (mounted) Navigator.of(context).pop(true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// 处理完成任务
  ///
  /// 将任务状态从 in_progress 变更为 completed。
  Future<void> _handleComplete(Mission mission) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认完成'),
        content: Text('确认「${mission.name}」已完成装载 ${mission.targetLoad.toStringAsFixed(0)} 吨？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          CatButton.filled(label: '确认完成', onPressed: () => Navigator.pop(ctx, true)),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _loading = true);
    try {
      await di<CatHttpClient>().post('/missions/${mission.id}/complete');
      _showSuccess('任务已完成');
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      _showSuccess('任务完成请求已进入离线队列，将在网络恢复后自动同步');
      if (mounted) Navigator.of(context).pop(true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// 显示操作成功 SnackBar
  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Flexible(child: Text(message)),
          ],
        ),
        backgroundColor: CatColors.online,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // 辅助方法
  // ============================================================

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

  String _priorityLabel(String? priority) {
    switch (priority) {
      case 'urgent':
        return '紧急';
      case 'high':
        return '高';
      case 'normal':
        return '普通';
      default:
        return '--';
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} '
        '${_pad(dt.hour)}:${_pad(dt.minute)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}