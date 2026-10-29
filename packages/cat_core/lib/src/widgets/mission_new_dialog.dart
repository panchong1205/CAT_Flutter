import 'package:flutter/material.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';

/// 车载终端新任务弹窗
///
/// 当有新任务下发到车载终端时，全屏居中弹出此对话框，
/// 包含任务摘要信息和接受/拒绝操作按钮。
/// 同时添加模拟的 TTS 语音播报图标，提示有新任务到达。
class MissionNewDialog extends StatelessWidget {
  final Mission mission;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const MissionNewDialog({
    super.key,
    required this.mission,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final priorityColor = _priorityColor(mission.priority);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(40),
      child: Container(
        decoration: BoxDecoration(
          color: CatColors.vehicleSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: priorityColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: priorityColor.withAlpha(40),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TTS 语音播报模拟图标
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: priorityColor.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.campaign, size: 32, color: CatColors.alertWarning),
                  // 声波动画效果（静态模拟）
                  Positioned(
                    right: 4,
                    top: 12,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: priorityColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 标题
            Text(
              '🔔 新任务通知',
              style: textTheme.headlineSmall?.copyWith(
                color: CatColors.vehicleOnBg,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // 任务名称
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: CatColors.vehicleSurfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mission.name,
                style: textTheme.titleMedium?.copyWith(
                  color: CatColors.vehiclePrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // 任务详情
            _infoRow(Icons.trip_origin, '装载点', mission.loadPoint),
            const SizedBox(height: 8),
            _infoRow(Icons.location_on, '卸载点', mission.unloadPoint),
            const SizedBox(height: 8),
            _infoRow(Icons.scale, '目标装载量', '${mission.targetLoad.toStringAsFixed(0)} 吨'),
            const SizedBox(height: 8),
            _infoRow(Icons.local_shipping, '分配车辆', mission.vehicleId),
            const SizedBox(height: 8),
            _infoRow(Icons.flag, '优先级', _priorityLabel(mission.priority)),

            const SizedBox(height: 24),
            const Divider(color: CatColors.vehicleBorder),
            const SizedBox(height: 16),

            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: CatButton.danger(
                    label: '拒绝',
                    onPressed: onReject,
                    size: CatButtonSize.large,
                    fullWidth: true,
                    leadingIcon: Icons.close,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CatButton.filled(
                    label: '接受任务',
                    onPressed: onAccept,
                    size: CatButtonSize.large,
                    fullWidth: true,
                    leadingIcon: Icons.check,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            // TTS 模拟提示
            Text(
              '🔊 TTS 语音播报：新任务已下达',
              style: textTheme.bodySmall?.copyWith(
                color: CatColors.vehicleOnSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 详情行组件
  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: CatColors.vehicleOnSurface),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(color: CatColors.vehicleOnSurface, fontSize: 13),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: CatColors.vehicleOnBg,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
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
        return CatColors.tabletPrimary;
    }
  }
}