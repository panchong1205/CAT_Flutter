import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/patrol_provider.dart';
import '../providers/selected_source_provider.dart';

/// 巡检页面
///
/// 展示所有巡检点，支持按状态筛选和打卡操作。
class PatrolPage extends ConsumerStatefulWidget {
  final String title;
  const PatrolPage({super.key, required this.title});

  @override
  ConsumerState<PatrolPage> createState() => _PatrolPageState();
}

class _PatrolPageState extends ConsumerState<PatrolPage> {
  String _filterStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final patrolsAsync = ref.watch(patrolPointsProvider);
    final highlightId = ref.watch(selectedSourceIdProvider);
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // 通知中心跳转：高亮后自动清除，防止下次进入时重复触发
    ref.listen(selectedSourceIdProvider, (_, targetId) {
      if (targetId != null) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && ref.read(selectedSourceIdProvider) == targetId) {
            ref.read(selectedSourceIdProvider.notifier).state = null;
          }
        });
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Text(widget.title, style: textTheme.headlineMedium),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
          child: Text('矿区巡检打卡', style: TextStyle(color: Colors.grey)),
        ),
        // 状态筛选
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            spacing: 8,
            children: [
              _filterChip('全部', 'all'),
              _filterChip('待巡检', 'pending'),
              _filterChip('已完成', 'completed'),
              _filterChip('已跳过', 'skipped'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: patrolsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('加载失败: $err')),
            data: (patrols) {
              final filtered = _filterStatus == 'all'
                  ? patrols
                  : patrols.where((p) => p.status == _filterStatus).toList();
              if (filtered.isEmpty) {
                return const Center(child: Text('暂无巡检点', style: TextStyle(color: Colors.grey)));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filtered.length,
                itemBuilder: (context, index) =>
                    _PatrolCard(point: filtered[index], onCheckIn: _handleCheckIn, highlighted: filtered[index].id == highlightId),
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

  Future<void> _handleCheckIn(PatrolPoint point) async {
    // 确认弹窗，避免误点
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认打卡'),
        content: Text('确定对「${point.name}」进行巡检打卡吗？\n\n位置：${point.location}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: CatColors.online, foregroundColor: Colors.white),
            child: const Text('确认打卡'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await checkInPatrolPoint(point.id);
      ref.invalidate(patrolPointsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${point.name} 巡检打卡成功'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('打卡失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _PatrolCard extends StatelessWidget {
  final PatrolPoint point;
  final ValueChanged<PatrolPoint> onCheckIn;
  final bool highlighted;

  const _PatrolCard({required this.point, required this.onCheckIn, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final statusConfig = _statusConfig(point.status);
    final categoryIcon = _categoryIcon(point.category);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: highlighted ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: highlighted ? colors.primary : Colors.transparent,
          width: highlighted ? 2 : 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 类别图标
            CircleAvatar(
              backgroundColor: statusConfig.$2.withAlpha(25),
              radius: 22,
              child: Icon(categoryIcon, color: statusConfig.$2, size: 22),
            ),
            const SizedBox(width: 16),
            // 巡检点信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(point.name, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(point.location, style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _statusBadge(statusConfig.$1, statusConfig.$2),
                      const SizedBox(width: 12),
                      if (point.assigneeName != null)
                        Text('巡检人: ${point.assigneeName}', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            // 打卡按钮
            if (point.status == 'pending')
              ElevatedButton.icon(
                onPressed: () => onCheckIn(point),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('打卡'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CatColors.online,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  (String, Color) _statusConfig(String status) {
    return switch (status) {
      'completed' => ('已完成', CatColors.online),
      'skipped' => ('已跳过', Colors.orange),
      _ => ('待巡检', Colors.blue),
    };
  }

  IconData _categoryIcon(String category) {
    return switch (category) {
      'equipment' => Icons.precision_manufacturing,
      'safety' => Icons.health_and_safety,
      'environment' => Icons.eco,
      _ => Icons.place,
    };
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}