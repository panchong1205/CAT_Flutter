/// CUSTOM Core Layer
///
/// 核心业务层公开 API，包含：
/// - GoRouter 三端路由配置
/// - GetIt DI 容器初始化
/// - Riverpod Provider（车队/任务/告警/Dashboard/Agent/通知/离线监测）
/// - Shell 组件（车载/平板/手机 三端自适应导航结构）
/// - 可复用业务组件（车辆卡片/任务卡片/地图/Agent 对话组件等）
/// - 所有业务页面
export 'src/routing/app_router.dart';
export 'src/di/di_container.dart';
export 'src/providers/dashboard_stats_provider.dart';
export 'src/providers/connectivity_provider.dart';
export 'src/providers/live_vehicle_provider.dart';
export 'src/providers/fleet_provider.dart';
export 'src/providers/mission_provider.dart';
export 'src/providers/alert_provider.dart';
export 'src/providers/agent_provider.dart';
export 'src/providers/map_provider.dart';
export 'src/providers/patrol_provider.dart';
export 'src/providers/approval_provider.dart';
export 'src/providers/notification_provider.dart';
export 'src/providers/selected_source_provider.dart';
export 'src/network/connectivity_service.dart';
export 'src/widgets/connectivity_badge.dart';
export 'src/widgets/vehicle_status_badge.dart';
export 'src/widgets/vehicle_card.dart';
export 'src/widgets/mission_card.dart';
export 'src/widgets/mission_timeline.dart';
export 'src/widgets/mission_new_dialog.dart';
export 'src/widgets/alert_severity_indicator.dart';
export 'src/widgets/alert_badge.dart';
export 'src/widgets/agent_message_bubble.dart';
export 'src/widgets/agent_alert_card.dart';
export 'src/widgets/agent_confirm_card.dart';
export 'src/widgets/agent_info_card.dart';
export 'src/widgets/agent_action_card.dart';
export 'src/widgets/agent_overlay.dart';
export 'src/widgets/vehicle_marker.dart';
export 'src/widgets/mine_map_widget.dart';
export 'src/widgets/map_route_line.dart';
export 'src/widgets/map_vehicle_popup.dart';
export 'src/widgets/map_alert_overlay.dart';
export 'src/pages/dashboard_page.dart';
export 'src/pages/fleet_page.dart';
export 'src/pages/mission_page.dart';
export 'src/pages/mission_list_page.dart';
export 'src/pages/mission_detail_page.dart';
export 'src/pages/alert_page.dart';
export 'src/pages/alert_list_page.dart';
export 'src/pages/alert_detail_page.dart';
export 'src/pages/map_page.dart';
export 'src/pages/agent_page.dart';
export 'src/pages/agent_chat_page.dart';
export 'src/pages/vehicle_fullscreen_map_page.dart';
export 'src/pages/patrol_page.dart';
export 'src/pages/approval_list_page.dart';
export 'src/pages/approval_detail_page.dart';
export 'src/pages/notification_center_page.dart';
export 'src/shells/vehicle_shell.dart';
export 'src/shells/tablet_shell.dart';
export 'src/shells/phone_shell.dart';