import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/alert_provider.dart';

/// 平板端自适应 Shell
///
/// 宽屏（>800px）显示左侧 NavigationRail + 右侧内容区的 Master-Detail 布局。
/// 窄屏自动切换为单栏 + 底部 NavigationBar 布局。
/// Step 9 新增告警导航项徽章 — 告警 tab 上实时显示未确认告警数量。
class TabletShell extends ConsumerStatefulWidget {
  final Widget child;
  const TabletShell({super.key, required this.child});

  @override
  ConsumerState<TabletShell> createState() => _TabletShellState();
}

class _TabletShellState extends ConsumerState<TabletShell> {
  static const _navItems = [
    (Icons.dashboard, '概览', '/dashboard'),
    (Icons.precision_manufacturing, '设备', '/fleet'),
    (Icons.assignment, '任务', '/missions'),
    (Icons.warning_amber, '告警', '/alerts'),
    (Icons.map, '地图', '/map'),
    (Icons.assignment_turned_in, '巡检', '/patrol'),
    (Icons.fact_check, '审批', '/approval'),
    (Icons.notifications, '通知', '/notifications'),
    (Icons.smart_toy, 'Agent', '/agent'),
  ];

  String _currentRoute() {
    return GoRouterState.of(context).uri.toString();
  }

  void _onNavigate(String route) {
    if (_currentRoute() != route) {
      GoRouter.of(context).go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;
    final currentRoute = _currentRoute();

    return Scaffold(
      body: isWide ? _buildWideLayout(currentRoute) : _buildNarrowLayout(currentRoute),
    );
  }

  Widget _buildWideLayout(String currentRoute) {
    final selectedIndex = _navItems.indexWhere((item) => currentRoute == item.$3);
    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
          onDestinationSelected: (i) => _onNavigate(_navItems[i].$3),
          labelType: NavigationRailLabelType.all,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Icon(Icons.precision_manufacturing, size: 32, color: Theme.of(context).colorScheme.primary),
          ),
          destinations: _navItems.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return NavigationRailDestination(
              icon: _buildRailIcon(i, item.$1),
              label: Text(item.$2),
            );
          }).toList(),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: widget.child,
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(String currentRoute) {
    final selectedIndex = _navItems.indexWhere((item) => currentRoute == item.$3);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: widget.child,
            ),
          ),
          NavigationBar(
            selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
            onDestinationSelected: (i) => _onNavigate(_navItems[i].$3),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: _navItems.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return NavigationDestination(
                icon: _buildNavIcon(i, item.$1),
                label: item.$2,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 构建 NavigationRail 图标（仅告警 tab 附带徽章）
  Widget _buildRailIcon(int index, IconData icon) {
    if (index != 3) return Icon(icon); // 索引 3 = 告警 tab

    // 使用 Consumer 订阅告警计数
    return Consumer(
      builder: (context, ref, _) {
        final countAsync = ref.watch(unacknowledgedAlertCountProvider);
        return countAsync.when(
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
      },
    );
  }

  /// 构建底部导航图标（仅告警 tab 附带徽章）
  Widget _buildNavIcon(int index, IconData icon) {
    if (index != 3) return Icon(icon);

    return Consumer(
      builder: (context, ref, _) {
        final countAsync = ref.watch(unacknowledgedAlertCountProvider);
        return countAsync.when(
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
      },
    );
  }
}