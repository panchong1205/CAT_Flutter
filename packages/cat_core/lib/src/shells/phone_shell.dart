import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/alert_provider.dart';

/// 手机端底部导航 Shell
///
/// 配合 StatefulShellRoute.indexedStack 使用，由 GoRouter 管理分支索引。
/// Step 9 新增告警徽章 — 导航栏「告警」tab 上显示未确认告警数量。
class PhoneShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const PhoneShell({super.key, required this.navigationShell});

  static const _navItems = [
    (Icons.dashboard_outlined, Icons.dashboard, '概览'),
    (Icons.assignment_outlined, Icons.assignment, '任务'),
    (Icons.warning_outlined, Icons.warning_amber, '告警'),
    (Icons.assignment_turned_in_outlined, Icons.assignment_turned_in, '巡检'),
    (Icons.fact_check_outlined, Icons.fact_check, '审批'),
    (Icons.smart_toy_outlined, Icons.smart_toy, 'Agent'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: colors.surface,
          elevation: 0,
          scrolledUnderElevation: 1,
          titleSpacing: 0,
          // 使用 Stack 绕过 AppBar 内部 Row 的 Flex 布局限制：
          // centerTitle=true 时 title 和 trailing slot 竞争空间导致溢出。
          // 通过 leading 占位 + title 居中 + Positioned 右对齐 action 来规避。
          leading: const SizedBox(width: 56),
          title: const Center(child: Text('CAT Phone')),
          actions: const [
            SizedBox(
              width: 56,
              child: _AlertActionIcon(),
            ),
          ],
        ),
      ),
      // 由 StatefulShellRoute 管理子页面展示
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (i) => navigationShell.goBranch(i),
        destinations: List.generate(_navItems.length, (i) {
          final item = _navItems[i];
          return NavigationDestination(
            icon: _buildNavIcon(context, ref, i, item.$1),
            selectedIcon: _buildNavIcon(context, ref, i, item.$2),
            label: item.$3,
          );
        }),
      ),
    );
  }

  /// 构建导航栏图标，告警 tab 附加未确认计数徽章
  Widget _buildNavIcon(BuildContext context, WidgetRef ref, int index, IconData icon) {
    // 仅在告警 tab（索引 2）上显示徽章
    if (index != 2) {
      return Icon(icon);
    }

    final alertCountAsync = ref.watch(unacknowledgedAlertCountProvider);

    return alertCountAsync.when(
      loading: () => Icon(icon),
      error: (_, __) => Icon(icon),
      data: (count) {
        if (count <= 0) return Icon(icon);
        return Badge(
          backgroundColor: Theme.of(context).colorScheme.error,
          isLabelVisible: true,
          label: Text(
            count > 99 ? '99+' : '$count',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          child: Icon(icon),
        );
      },
    );
  }
}

/// AppBar 右侧告警图标（独立 ConsumerWidget 读取 provider）
///
/// 显示通知铃铛图标，未确认告警时叠加 Badge 计数。
class _AlertActionIcon extends ConsumerWidget {
  const _AlertActionIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final alertCountAsync = ref.watch(unacknowledgedAlertCountProvider);

    return alertCountAsync.when(
      loading: () => const Icon(Icons.notifications_outlined),
      error: (_, __) => const Icon(Icons.notifications_outlined),
      data: (count) => Badge(
        backgroundColor: colors.error,
        isLabelVisible: count > 0,
        smallSize: 14,
        label: Text(
          count > 99 ? '99+' : '$count',
          style: const TextStyle(fontSize: 9, color: Colors.white),
        ),
        child: const Icon(Icons.notifications_outlined),
      ),
    );
  }
}