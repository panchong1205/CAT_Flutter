import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shells/vehicle_shell.dart';
import '../shells/tablet_shell.dart';
import '../shells/phone_shell.dart';
import '../pages/dashboard_page.dart';
import '../pages/fleet_page.dart';
import '../pages/mission_page.dart';
import '../pages/alert_page.dart';
import '../pages/map_page.dart';
import '../pages/agent_page.dart';
import '../pages/patrol_page.dart';
import '../pages/approval_list_page.dart';
import '../pages/notification_center_page.dart';
import '../pages/vehicle_fullscreen_map_page.dart';

enum AppType { vehicle, tablet, phone }

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(AppType appType) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/dashboard',
    routes: [
      switch (appType) {
        AppType.vehicle => _buildVehicleRoutes(),
        AppType.tablet => _buildTabletRoutes(),
        AppType.phone => _buildPhoneRoutes(),
      },
      // 全屏地图（车载端顶层路由，独立于 Shell）
      if (appType == AppType.vehicle)
        GoRoute(
          path: '/vehicle/fullscreen-map',
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const VehicleFullscreenMapPage(),
          ),
        ),
    ],
  );
}

RouteBase _buildVehicleRoutes() {
  return ShellRoute(
    navigatorKey: shellNavigatorKey,
    builder: (context, state, child) => VehicleShell(child: child),
    routes: [
      GoRoute(path: '/dashboard', pageBuilder: (context, state) => _fadePage(context, state, const DashboardPage(title: '车载终端'))),
      GoRoute(path: '/fleet', pageBuilder: (context, state) => _fadePage(context, state, const FleetPage(title: '车队管理'))),
      GoRoute(path: '/missions', pageBuilder: (context, state) => _fadePage(context, state, const MissionPage(title: '任务管理'))),
      GoRoute(path: '/alerts', pageBuilder: (context, state) => _fadePage(context, state, const AlertPage(title: '告警中心'))),
      GoRoute(path: '/map', pageBuilder: (context, state) => _fadePage(context, state, const MapPage(title: '矿区地图'))),
      GoRoute(path: '/patrol', pageBuilder: (context, state) => _fadePage(context, state, const PatrolPage(title: '巡检打卡'))),
      GoRoute(path: '/approval', pageBuilder: (context, state) => _fadePage(context, state, const ApprovalListPage(title: '审批管理'))),
      GoRoute(path: '/notifications', pageBuilder: (context, state) => _fadePage(context, state, const NotificationCenterPage(title: '通知中心'))),
      GoRoute(path: '/agent', pageBuilder: (context, state) => _fadePage(context, state, const AgentPage(title: 'AI 助手'))),
    ],
  );
}

RouteBase _buildTabletRoutes() {
  return ShellRoute(
    navigatorKey: shellNavigatorKey,
    builder: (context, state, child) => TabletShell(child: child),
    routes: [
      GoRoute(path: '/dashboard', pageBuilder: (context, state) => _fadePage(context, state, const DashboardPage(title: '运营概览'))),
      GoRoute(path: '/fleet', pageBuilder: (context, state) => _fadePage(context, state, const FleetPage(title: '车队设备'))),
      GoRoute(path: '/missions', pageBuilder: (context, state) => _fadePage(context, state, const MissionPage(title: '任务管理'))),
      GoRoute(path: '/alerts', pageBuilder: (context, state) => _fadePage(context, state, const AlertPage(title: '告警中心'))),
      GoRoute(path: '/map', pageBuilder: (context, state) => _fadePage(context, state, const MapPage(title: '矿区地图'))),
      GoRoute(path: '/patrol', pageBuilder: (context, state) => _fadePage(context, state, const PatrolPage(title: '巡检打卡'))),
      GoRoute(path: '/approval', pageBuilder: (context, state) => _fadePage(context, state, const ApprovalListPage(title: '审批管理'))),
      GoRoute(path: '/notifications', pageBuilder: (context, state) => _fadePage(context, state, const NotificationCenterPage(title: '通知中心'))),
      GoRoute(path: '/agent', pageBuilder: (context, state) => _fadePage(context, state, const AgentPage(title: 'AI 助手'))),
      GoRoute(path: '/design-preview', pageBuilder: (context, state) => _fadePage(context, state, const _DesignPreviewRedirect())),
    ],
  );
}

RouteBase _buildPhoneRoutes() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => PhoneShell(navigationShell: navigationShell),
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(path: '/dashboard', pageBuilder: (context, state) => _fadePage(context, state, const DashboardPage(title: '运营概览'))),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: '/missions', pageBuilder: (context, state) => _fadePage(context, state, const MissionPage(title: '任务管理'))),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: '/alerts', pageBuilder: (context, state) => _fadePage(context, state, const AlertPage(title: '告警中心'))),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: '/patrol', pageBuilder: (context, state) => _fadePage(context, state, const PatrolPage(title: '巡检打卡'))),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: '/approval', pageBuilder: (context, state) => _fadePage(context, state, const ApprovalListPage(title: '审批管理'))),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(path: '/agent', pageBuilder: (context, state) => _fadePage(context, state, const AgentPage(title: 'AI 助手'))),
      ]),
    ],
  );
}

Page _fadePage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}

class _DesignPreviewRedirect extends StatelessWidget {
  const _DesignPreviewRedirect();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).go('/dashboard');
    });
    return const DashboardPage(title: '运营概览');
  }
}