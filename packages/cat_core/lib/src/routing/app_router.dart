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
import '../pages/vehicle_status_page.dart';

/// 应用终端类型枚举
///
/// 决定路由配置、Shell 结构和导航模式：
/// - [vehicle] 车载终端：侧边栏 + 横屏
/// - [tablet] 平板端：自适应双栏
/// - [phone] 手机端：底部导航栏 StatefulShellRoute
enum AppType { vehicle, tablet, phone }

/// 根导航 Key（用于全屏页面和 dialog overlay）
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Shell 内部导航 Key（各 Shell 的子页面导航栈）
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

/// 创建三端自适应路由
///
/// 根据 [appType] 返回不同的 [GoRouter] 配置：
/// - 车载端使用 [ShellRoute] 包裹 [VehicleShell]
/// - 平板端使用 [ShellRoute] 包裹 [TabletShell]
/// - 手机端使用 [StatefulShellRoute.indexedStack] 包裹 [PhoneShell]
///
/// 所有子页面带统一淡入淡出过渡动画。
GoRouter createAppRouter(AppType appType) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: switch (appType) {
      AppType.vehicle => '/map',
      AppType.tablet || AppType.phone => '/dashboard',
    },
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
      // 通知中心（手机端顶层路由，通过 AppBar 铃铛图标进入）
      if (appType == AppType.phone)
        GoRoute(
          path: '/notifications',
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const NotificationCenterPage(title: '通知中心'),
          ),
        ),
    ],
  );
}

/// 车载端路由配置
///
/// 使用 [ShellRoute] + [VehicleShell] 构建左侧侧边栏 + 右侧内容区的横屏布局。
/// 仅注册驾驶员角色所需的核心页面：矿区地图、我的任务、车辆状态、告警、AI 助手。
/// 额外注册 [VehicleFullscreenMapPage] 为顶层路由（独立于 Shell，全屏地图模式）。
RouteBase _buildVehicleRoutes() {
  return ShellRoute(
    navigatorKey: shellNavigatorKey,
    builder: (context, state, child) => VehicleShell(child: child),
    routes: [
      GoRoute(path: '/map', pageBuilder: (context, state) => _fadePage(context, state, const MapPage(title: '矿区地图'))),
      GoRoute(path: '/missions', pageBuilder: (context, state) => _fadePage(context, state, const MissionPage(title: '我的任务'))),
      GoRoute(path: '/vehicle-status', pageBuilder: (context, state) => _fadePage(context, state, const VehicleStatusPage(title: '车辆状态', vehicleId: 'V-008'))),
      GoRoute(path: '/alerts', pageBuilder: (context, state) => _fadePage(context, state, const AlertPage(title: '告警'))),
      GoRoute(path: '/agent', pageBuilder: (context, state) => _fadePage(context, state, const AgentPage(title: 'AI 助手'))),
    ],
  );
}

/// 平板端路由配置
///
/// 使用 [ShellRoute] + [TabletShell] 构建自适应双栏布局。
/// 额外包含 /design-preview 路由用于设计系统预览。
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

/// 手机端路由配置
///
/// 使用 [StatefulShellRoute.indexedStack] + [PhoneShell] 构建底部导航栏布局。
/// 6 个分支各对应一个底部 tab，额外注册通知中心为顶层路由。
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

/// 统一淡入淡出页面过渡动画
///
/// 所有子页面路由共用此过渡效果，200ms 淡入淡出。
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

/// 设计预览页的重定向占位
///
/// 构建完成后立即跳转到 /dashboard 首页。
/// 用于 /design-preview 路由（设计系统组件预览入口），当前简化为跳转回首页。
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