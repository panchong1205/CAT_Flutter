import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_domain/cat_domain.dart';
import '../providers/notification_provider.dart';
import '../providers/selected_source_provider.dart';

/// 通知中心页面
///
/// 汇总告警、任务、审批、巡检四类通知消息，
/// 按时序排列，支持点击跳转来源页面。
class NotificationCenterPage extends ConsumerWidget {
  final String title;
  const NotificationCenterPage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(title),
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('加载失败: $err')),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('暂无通知', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: notifications.length,
            itemBuilder: (context, index) =>
                _NotificationTile(message: notifications[index]),
          );
        },
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  final NotificationMessage message;

  const _NotificationTile({required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (icon, color) = switch (message.type) {
      'alert' => (Icons.warning_amber, CatColors.alertCritical),
      'mission' => (Icons.assignment, colors.primary),
      'approval' => (Icons.fact_check, Colors.orange),
      'patrol' => (Icons.location_on, Colors.blue),
      _ => (Icons.notifications, Colors.grey),
    };

    final levelColor = switch (message.level) {
      'critical' => CatColors.alertCritical,
      'warning' => Colors.orange,
      _ => Colors.blue,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          final route = message.sourceRoute;
          if (route != null && route.isNotEmpty) {
            ref.read(selectedSourceIdProvider.notifier).state = message.sourceId;
            GoRouter.of(context).go(route);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧等级指示条
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: levelColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              // 图标
              CircleAvatar(
                backgroundColor: color.withAlpha(20),
                radius: 18,
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              // 内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: color.withAlpha(20),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _typeLabel(message.type),
                            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            message.title,
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(message.body, style: TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (!message.isRead)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          ),
                        if (!message.isRead) const SizedBox(width: 6),
                        Text(
                          _formatTime(message.createdAt),
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 右箭头
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    return switch (type) {
      'alert' => '告警',
      'mission' => '任务',
      'approval' => '审批',
      'patrol' => '巡检',
      _ => '通知',
    };
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    return '${dt.month}/${dt.day} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}