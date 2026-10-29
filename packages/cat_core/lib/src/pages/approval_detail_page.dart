import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/approval_provider.dart';

/// 审批详情页面
///
/// 展示审批单详情，提供通过/驳回/转交操作按钮。
class ApprovalDetailPage extends ConsumerStatefulWidget {
  final ApprovalRequest request;

  const ApprovalDetailPage({super.key, required this.request});

  @override
  ConsumerState<ApprovalDetailPage> createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends ConsumerState<ApprovalDetailPage> {
  late ApprovalRequest _request;
  bool _isProcessing = false;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _request = widget.request;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final statusConfig = switch (_request.status) {
      'approved' => ('已通过', CatColors.online, Icons.check_circle),
      'rejected' => ('已驳回', CatColors.alertCritical, Icons.cancel),
      'transferred' => ('已转交', Colors.purple, Icons.forward),
      _ => ('待审批', Colors.orange, Icons.hourglass_empty),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(_request.title),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态 + 类型
            Row(
              children: [
                Icon(_typeIcon(_request.type), size: 28, color: colors.primary),
                const SizedBox(width: 12),
                Text(_typeLabel(_request.type), style: textTheme.titleLarge),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusConfig.$2.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusConfig.$2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusConfig.$3, size: 16, color: statusConfig.$2),
                      const SizedBox(width: 6),
                      Text(statusConfig.$1, style: TextStyle(color: statusConfig.$2, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 审批详情卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('申请人', _request.applicantName),
                    const Divider(height: 24),
                    _detailRow('申请时间', _formatDateTime(_request.createdAt)),
                    if (_request.resolvedAt != null) ...[
                      const Divider(height: 24),
                      _detailRow('审批时间', _formatDateTime(_request.resolvedAt!)),
                    ],
                    if (_request.approverName != null) ...[
                      const Divider(height: 24),
                      _detailRow('审批人', _request.approverName!),
                    ],
                    if (_request.transferredTo != null) ...[
                      const Divider(height: 24),
                      _detailRow('转交人', _request.transferredTo!),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 申请描述
            Text('申请描述', style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_request.description, style: textTheme.bodyMedium?.copyWith(height: 1.6)),
              ),
            ),
            const SizedBox(height: 16),

            // 审批意见（仅已处理时显示）
            if (_request.comment != null) ...[
              Text('审批意见', style: textTheme.titleSmall),
              const SizedBox(height: 8),
              Card(
                color: _request.status == 'approved'
                    ? CatColors.online.withAlpha(15)
                    : CatColors.alertCritical.withAlpha(15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _request.status == 'approved' ? Icons.thumb_up_alt : Icons.thumb_down_alt,
                        color: _request.status == 'approved' ? CatColors.online : CatColors.alertCritical,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_request.comment!, style: textTheme.bodyMedium)),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // 操作按钮（仅待审批状态）
            if (_request.status == 'pending') ...[
              Text('审批操作', style: textTheme.titleSmall),
              const SizedBox(height: 12),
              // 审批意见输入
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: '输入审批意见（可选）',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              // 按钮组
              Row(
                children: [
                  // 通过
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : () => _handleAction('approve'),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('通过'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CatColors.online,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 驳回
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : () => _handleAction('reject'),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('驳回'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CatColors.alertCritical,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 转交
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isProcessing ? null : () => _handleTransfer(),
                      icon: const Icon(Icons.forward),
                      label: const Text('转交'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: TextStyle(color: Colors.grey))),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }

  Future<void> _handleAction(String action) async {
    setState(() => _isProcessing = true);
    try {
      final comment = _commentController.text.isNotEmpty ? _commentController.text : null;

      if (action == 'approve') {
        final updated = await approveRequest(_request.id, comment: comment ?? '同意');
        setState(() => _request = updated);
      } else {
        final updated = await rejectRequest(_request.id, comment: comment ?? '驳回');
        setState(() => _request = updated);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(action == 'approve' ? '审批已通过' : '审批已驳回'),
            backgroundColor: action == 'approve' ? CatColors.online : CatColors.alertCritical,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleTransfer() async {
    final user = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('转交审批'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('请选择转交人:'),
            const SizedBox(height: 16),
            _transferOption(ctx, '矿长 赵'),
            _transferOption(ctx, '安全总监 钱'),
            _transferOption(ctx, '调度主管 孙'),
          ],
        ),
      ),
    );

    if (user != null) {
      setState(() => _isProcessing = true);
      try {
        final updated = await transferRequest(_request.id, user);
        setState(() => _request = updated);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('已转交给 $user'), backgroundColor: Colors.purple),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('转交失败: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isProcessing = false);
      }
    }
  }

  Widget _transferOption(BuildContext ctx, String name) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(name),
      onTap: () => Navigator.of(ctx).pop(name),
    );
  }

  IconData _typeIcon(String type) {
    return switch (type) {
      'mission_change' => Icons.assignment,
      'device_repair' => Icons.build,
      'safety' => Icons.health_and_safety,
      _ => Icons.description,
    };
  }

  String _typeLabel(String type) {
    return switch (type) {
      'mission_change' => '任务变更',
      'device_repair' => '设备维修',
      'safety' => '安全稽核',
      _ => '其他',
    };
  }

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}