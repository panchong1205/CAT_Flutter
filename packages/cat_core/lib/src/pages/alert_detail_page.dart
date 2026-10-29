import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';
import '../network/connectivity_service.dart';
import '../providers/alert_provider.dart';
import '../widgets/alert_severity_indicator.dart';

/// 告警详情页面
///
/// 展示单个告警的完整信息，包含告警严重程度、详情描述、
/// 来源信息和确认操作按钮。已确认的告警显示确认人和时间。
/// 支持离线确认 — 断网时操作进入 [SyncEngine] 队列等待网络恢复后执行。
class AlertDetailPage extends ConsumerStatefulWidget {
  final Alert alert;

  const AlertDetailPage({super.key, required this.alert});

  @override
  ConsumerState<AlertDetailPage> createState() => _AlertDetailPageState();
}

class _AlertDetailPageState extends ConsumerState<AlertDetailPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final alert = widget.alert;
    final severityColor = AlertSeverityIndicator.colorForLevel(alert.level);

    return Scaffold(
      appBar: AppBar(
        title: Text('告警详情'),
        centerTitle: true,
        backgroundColor: severityColor.withAlpha(25),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 返回前刷新列表
            ref.invalidate(alertsProvider);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 告警头部 — 严重级别 + 标题
          _buildAlertHeader(alert, severityColor, textTheme),
          const SizedBox(height: 16),

          // 告警详情卡片
          _buildDetailCard(alert, severityColor, textTheme),
          const SizedBox(height: 16),

          // 确认状态卡片
          _buildAcknowledgeCard(alert, textTheme),
          const SizedBox(height: 24),

          // 确认操作按钮
          if (!alert.acknowledged) _buildAcknowledgeButton(alert, severityColor),

          const SizedBox(height: 16),

          // 来源信息
          _buildSourceCard(alert, textTheme),
        ],
      ),
    );
  }

  /// 告警头部 — 严重级别大图标 + 标题
  Widget _buildAlertHeader(Alert alert, Color severityColor, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: severityColor.withAlpha(60), width: 1.5),
      ),
      child: Column(
        children: [
          // 大图标
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: severityColor.withAlpha(30),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: severityColor.withAlpha(80),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              AlertSeverityIndicator.iconForLevel(alert.level),
              size: 36,
              color: severityColor,
            ),
          ),
          const SizedBox(height: 16),

          // 告警级别标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: severityColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AlertSeverityIndicator.labelForLevel(alert.level),
                  style: TextStyle(
                    color: severityColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 告警标题
          Text(
            alert.title,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 告警详情卡片
  Widget _buildDetailCard(Alert alert, Color severityColor, TextTheme textTheme) {
    return CatCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: CatColors.tabletPrimary.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.description_outlined, size: 18, color: CatColors.tabletPrimary),
              ),
              const SizedBox(width: 10),
              Text('告警详情', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: severityColor.withAlpha(10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: severityColor.withAlpha(50)),
            ),
            child: Text(
              alert.message,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _detailRow('告警 ID', alert.id, textTheme),
          _detailRow('告警时间', _formatDateTime(alert.createdAt), textTheme),
          _detailRow('告警来源', _sourceLabel(alert.source), textTheme),
          if (alert.vehicleId != null)
            _detailRow('关联车辆', alert.vehicleId!, textTheme),
        ],
      ),
    );
  }

  /// 确认状态卡片
  Widget _buildAcknowledgeCard(Alert alert, TextTheme textTheme) {
    final isAcknowledged = alert.acknowledged;

    return CatCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isAcknowledged
                  ? CatColors.online.withAlpha(20)
                  : CatColors.alertWarning.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isAcknowledged ? Icons.check_circle : Icons.schedule,
              size: 18,
              color: isAcknowledged ? CatColors.online : CatColors.alertWarning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAcknowledged ? '已确认' : '等待确认',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isAcknowledged ? CatColors.online : CatColors.alertWarning,
                  ),
                ),
                const SizedBox(height: 2),
                if (isAcknowledged && alert.acknowledgedBy != null) ...[
                  Text(
                    '确认人：${alert.acknowledgedBy}',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '确认时间：${_formatDateTime(alert.acknowledgedAt!)}',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ] else ...[
                  Text(
                    '该告警需要操作员确认处置',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 确认操作按钮
  Widget _buildAcknowledgeButton(Alert alert, Color severityColor) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: _loading ? null : () => _acknowledge(alert),
        icon: _loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.check_circle_outline),
        label: Text(_loading ? '确认中...' : '确认告警'),
        style: ElevatedButton.styleFrom(
          backgroundColor: severityColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          elevation: 2,
        ),
      ),
    );
  }

  /// 来源信息卡片
  Widget _buildSourceCard(Alert alert, TextTheme textTheme) {
    return CatCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: CatColors.tabletPrimary.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.info_outline, size: 18, color: CatColors.tabletPrimary),
              ),
              const SizedBox(width: 10),
              Text('来源信息', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(80),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(_sourceIcon(alert.source), size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_sourceLabel(alert.source),
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(_sourceDesc(alert.source),
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 执行确认操作
  Future<void> _acknowledge(Alert alert) async {
    setState(() => _loading = true);

    try {
      // 使用离线同步引擎，断网时操作自动进入队列
      final db = di<AppDatabase>();
      final connectivityService = di<ConnectivityService>();

      if (!connectivityService.isOnline) {
        // 离线模式：加入同步队列
        await db.enqueueSyncOperation('acknowledge_alert', alert.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.cloud_off, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Flexible(child: Text('您处于离线状态，确认操作已加入队列，恢复网络后将自动同步')),
                ],
              ),
              backgroundColor: CatColors.alertWarning,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        // 在线模式：直接确认
        await db.acknowledgeAlert(
          alert.id,
          '操作员-系统',
          DateTime.now().millisecondsSinceEpoch,
        );
      }

      // 刷新告警列表
      ref.invalidate(alertsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Flexible(child: Text('告警已确认')),
              ],
            ),
            backgroundColor: CatColors.online,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // 返回列表并刷新
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Flexible(child: Text('确认失败：$e')),
              ],
            ),
            backgroundColor: CatColors.alertCritical,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// 详细信息行
  Widget _detailRow(String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ),
          Expanded(
            child: Text(value, style: textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  /// 来源中文标签
  String _sourceLabel(String source) {
    switch (source) {
      case 'vehicle':
        return '车辆传感器';
      case 'system':
        return '系统监测';
      case 'safety':
        return '安全系统';
      case 'device':
        return '设备监测';
      default:
        return source;
    }
  }

  /// 来源描述
  String _sourceDesc(String source) {
    switch (source) {
      case 'vehicle':
        return '由车载传感器自动触发';
      case 'system':
        return '由系统监测服务自动触发';
      case 'safety':
        return '由安全防护系统自动触发';
      case 'device':
        return '由设备监测模块自动触发';
      default:
        return '自动触发';
    }
  }

  /// 来源图标
  IconData _sourceIcon(String source) {
    switch (source) {
      case 'vehicle':
        return Icons.local_shipping;
      case 'system':
        return Icons.computer;
      case 'safety':
        return Icons.security;
      case 'device':
        return Icons.sensors;
      default:
        return Icons.notifications;
    }
  }

  /// 格式化日期时间
  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} '
        '${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}