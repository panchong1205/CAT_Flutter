import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/approval_provider.dart';
import '../providers/selected_source_provider.dart';
import 'approval_detail_page.dart';

/// 审批列表页面
///
/// 展示所有审批请求，按状态筛选，点击进入详情。
class ApprovalListPage extends ConsumerStatefulWidget {
  final String title;
  const ApprovalListPage({super.key, required this.title});

  @override
  ConsumerState<ApprovalListPage> createState() => _ApprovalListPageState();
}

class _ApprovalListPageState extends ConsumerState<ApprovalListPage> {
  String _filterStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final approvalsAsync = ref.watch(approvalsProvider);
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // 通知中心跳转：监听 + 首次检查，确保进入页面时自动打开对应审批详情
    final targetId = ref.watch(selectedSourceIdProvider);
    ref.listen(selectedSourceIdProvider, (_, next) {
      _tryOpenApprovalDetail(ref, next);
    });
    if (targetId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tryOpenApprovalDetail(ref, targetId);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Text(widget.title, style: textTheme.headlineMedium),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
          child: Text('审批管理', style: TextStyle(color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 8,
            children: [
              _filterChip('全部', 'all'),
              _filterChip('待审批', 'pending'),
              _filterChip('已通过', 'approved'),
              _filterChip('已驳回', 'rejected'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: approvalsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('加载失败: $err')),
            data: (approvals) {
              final filtered = _filterStatus == 'all'
                  ? approvals
                  : approvals.where((a) => a.status == _filterStatus).toList();
              if (filtered.isEmpty) {
                return const Center(child: Text('暂无审批', style: TextStyle(color: Colors.grey)));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filtered.length,
                itemBuilder: (context, index) => _ApprovalCard(
                  request: filtered[index],
                  onTap: () => _openDetail(filtered[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, String status) {
    final selected = _filterStatus == status;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _filterStatus = status),
    );
  }

  void _openDetail(ApprovalRequest request) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ApprovalDetailPage(request: request),
      ),
    );
  }

  void _tryOpenApprovalDetail(WidgetRef ref, String? targetId) {
    if (targetId == null) return;
    final approvals = ref.read(approvalsProvider).valueOrNull;
    if (approvals != null) {
      final match = approvals.where((a) => a.id == targetId).toList();
      if (match.isNotEmpty) {
        ref.read(selectedSourceIdProvider.notifier).state = null;
        _openDetail(match.first);
      }
    }
  }
}

class _ApprovalCard extends StatelessWidget {
  final ApprovalRequest request;
  final VoidCallback onTap;

  const _ApprovalCard({required this.request, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final statusConfig = switch (request.status) {
      'approved' => ('已通过', CatColors.online),
      'rejected' => ('已驳回', CatColors.alertCritical),
      'transferred' => ('已转交', Colors.purple),
      _ => ('待审批', Colors.orange),
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_typeIcon(request.type), size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(request.title, style: textTheme.titleMedium),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusConfig.$2.withAlpha(25),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: statusConfig.$2.withAlpha(80)),
                    ),
                    child: Text(statusConfig.$1, style: TextStyle(color: statusConfig.$2, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(request.description, style: textTheme.bodySmall?.copyWith(color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(request.applicantName, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(_formatTime(request.createdAt), style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
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

  String _formatTime(DateTime? dt) {
    if (dt == null) return '';
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}