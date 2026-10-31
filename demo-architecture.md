# 无人矿山生产管控终端 Demo — 架构设计方案

---

## 一、Demo 定位与目标

> **一句话定位**：面向面试展示的「矿山作业管控中心」跨平台终端 Demo，覆盖车载大屏、平板和手机三类终端，在一套 Flutter 代码库中演示模块化架构、实时数据、弱网离线、Agent 交互和地图集成等核心能力。

### Demo 场景闭环

```
矿山调度员下发运输任务 → 矿卡接收任务并执行
→ 车辆实时状态回传 → 异常告警触发 → Agent 辅助决策
→ 现场人员巡检确认 → 审批流转 → 任务闭环
```

### 演示终端矩阵

| 终端类型 | 设备形态 | 核心角色 | Demo 重点场景 |
|----------|---------|---------|-------------|
| **车载终端** | 12 寸横屏大屏（Chrome 模拟） | 矿卡驾驶员 | 任务接收、矿区地图导航、车辆状态、告警弹窗、Agent 对话 |
| **平板终端** | 10 寸自适应屏（Chrome 模拟） | 现场巡检/调度员 | 运营总览、任务面板、告警处置、地图视图、审批 |
| **手机终端** | 6 寸竖屏窄屏（Chrome 模拟） | 管理人员 | 运营概览看板、任务、告警、巡检打卡、审批、Agent 对话 |

---

## 二、整体架构分层

```
┌─────────────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │ 车载 Shell │  │ 平板 Shell │  │ 手机 Shell │  │  Agent Chat Overlay  │ │
│  │ (Landscape)│  │(Adaptive) │  │(BottomNav)│  │  (全终端共用)         │ │
│  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘  └──────────┬───────────┘ │
│        │              │              │                    │             │
│  ┌─────┴──────────────┴──────────────┴────────────────────┴──────────┐ │
│  │                    SHARED UI COMPONENTS                             │ │
│  │  Design System (Tokens/Theme/Components) │ Feature Widgets           │ │
│  │  Agent Cards │ Adaptive Layout (phone/tablet/desktop)               │ │
│  └────────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                       APPLICATION LAYER                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │  Routing  │  │  State   │  │   DI     │  │  Network / Sync      │ │
│  │ (GoRouter)│  │(Riverpod)│  │ (GetIt)  │  │  (Connectivity)      │ │
│  └──────────┘  └──────────┘  └──────────┘  └──────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                        DOMAIN LAYER                                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │  Entities │  │ UseCases │  │Repository│  │  Mock Repositories   │ │
│  │ (freezed) │  │          │  │Interface │  │  (纯内存 Mock 数据)   │ │
│  └──────────┘  └──────────┘  └──────────┘  └──────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                         DATA LAYER                                    │
│  ┌──────────┐  ┌──────────┐  ┌───────────┐  ┌────────────────────┐ │
│  │  Remote  │  │  Local   │  │  Cache    │  │  Sync Engine       │ │
│  │ (Dio+Mock)│  │ (Drift)  │  │(Drift本地)│  │  (离线队列批量提交) │ │
│  └──────────┘  └──────────┘  └───────────┘  └────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                      PLATFORM LAYER                                   │
│  ┌───────────────────────────────┐  ┌──────────────────────────────┐ │
│  │         Chrome / Web          │  │      Android / iOS (规划中)   │ │
│  │  · Flutter Web (CanvasKit)    │  │  · Flutter Embedder          │ │
│  │  · 当前 Demo 主推目标平台       │  │  · 后续阶段扩展               │ │
│  └───────────────────────────────┘  └──────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 三、项目模块结构（Melos Monorepo）

```
CAT_Flutter/
├── apps/                              # 三端入口应用（极薄，仅 main.dart + 主题 + 方向锁定）
│   ├── cat_vehicle/                   # 车载终端入口
│   │   ├── lib/main.dart              # 强制横屏 + 车载暗色主题
│   │   └── pubspec.yaml               # 依赖: cat_core, cat_design_system
│   ├── cat_tablet/                    # 平板终端入口
│   │   ├── lib/main.dart              # 自适应方向 + 平板亮色主题
│   │   └── pubspec.yaml
│   └── cat_phone/                     # 手机终端入口
│       ├── lib/main.dart              # 竖屏 + 手机主题
│       └── pubspec.yaml
│
├── packages/                          # 共享包（Melos 管理，依赖方向单向）
│   ├── cat_core/                      # 应用核心层 — 路由、状态、DI、页面、组件
│   │   └── lib/
│   │       ├── cat_core.dart          # barrel 导出文件
│   │       └── src/
│   │           ├── di/                # GetIt 依赖注入容器 (di_container.dart)
│   │           ├── routing/           # GoRouter 三端路由定义 (app_router.dart)
│   │           ├── network/           # 网络连接监测 (connectivity_service.dart)
│   │           ├── providers/         # Riverpod Provider 层（13 个 Provider）
│   │           │   ├── dashboard_stats_provider.dart
│   │           │   ├── fleet_provider.dart
│   │           │   ├── mission_provider.dart
│   │           │   ├── alert_provider.dart
│   │           │   ├── agent_provider.dart
│   │           │   ├── map_provider.dart
│   │           │   ├── patrol_provider.dart
│   │           │   ├── approval_provider.dart
│   │           │   ├── notification_provider.dart
│   │           │   ├── connectivity_provider.dart
│   │           │   ├── live_vehicle_provider.dart
│   │           │   └── selected_source_provider.dart
│   │           ├── pages/             # 所有功能页面（17 个 Page）
│   │           │   ├── dashboard_page.dart
│   │           │   ├── fleet_page.dart / fleet_list_page.dart / fleet_detail_page.dart
│   │           │   ├── mission_page.dart / mission_list_page.dart / mission_detail_page.dart
│   │           │   ├── alert_page.dart / alert_list_page.dart / alert_detail_page.dart
│   │           │   ├── agent_page.dart / agent_chat_page.dart
│   │           │   ├── patrol_page.dart
│   │           │   ├── approval_list_page.dart / approval_detail_page.dart
│   │           │   ├── map_page.dart / vehicle_fullscreen_map_page.dart
│   │           │   ├── vehicle_status_page.dart
│   │           │   └── notification_center_page.dart
│   │           ├── shells/            # 三端 Shell 布局
│   │           │   ├── vehicle_shell.dart   # 左侧驾驶员专属导航栏（5 项）+ 全屏告警弹窗
│   │           │   ├── tablet_shell.dart    # 自适应双栏/单栏布局
│   │           │   └── phone_shell.dart     # BottomNavigationBar + IndexedStack
│   │           └── widgets/           # 业务共用组件（20 个 Widget）
│   │               ├── vehicle_card.dart / vehicle_status_badge.dart / vehicle_marker.dart
│   │               ├── mission_card.dart / mission_timeline.dart / mission_new_dialog.dart
│   │               ├── alert_badge.dart / alert_severity_indicator.dart
│   │               ├── agent_message_bubble.dart / agent_alert_card.dart
│   │               ├── agent_confirm_card.dart / agent_info_card.dart
│   │               ├── agent_action_card.dart / agent_overlay.dart
│   │               ├── mine_map_widget.dart / map_vehicle_popup.dart
│   │               ├── map_alert_overlay.dart / map_route_line.dart
│   │               └── connectivity_badge.dart
│   │
│   ├── cat_design_system/             # 跨终端设计系统
│   │   └── lib/
│   │       ├── cat_design_system.dart # barrel 导出文件
│   │       ├── tokens/                # 设计令牌
│   │       │   ├── colors.dart        # 颜色令牌（车载/平板/手机三套色板）
│   │       │   ├── spacing.dart       # 间距令牌
│   │       │   └── typography.dart    # 字体/排版令牌
│   │       ├── theme/                 # 主题定义
│   │       │   └── cat_themes.dart    # vehicleTheme / tabletTheme / phoneTheme
│   │       ├── components/            # 原子组件
│   │       │   ├── cat_button.dart
│   │       │   ├── cat_card.dart
│   │       │   ├── cat_badge.dart
│   │       │   ├── cat_app_bar.dart
│   │       │   └── cat_bottom_bar.dart
│   │       └── layout/                # 自适应布局
│   │           ├── adaptive_layout.dart
│   │           ├── device_class_provider.dart
│   │           └── responsive_padding.dart
│   │
│   ├── cat_data/                      # 数据层
│   │   └── lib/
│   │       ├── cat_data.dart          # barrel 导出文件
│   │       └── src/
│   │           ├── drift/             # Drift (SQLite) 本地数据库
│   │           │   ├── app_database.dart          # 数据库定义（含所有 DAO 操作）
│   │           │   ├── app_database.g.dart         # Drift 生成代码
│   │           │   ├── connection/                 # 平台连接策略
│   │           │   │   ├── database_connection.dart    # 统一入口
│   │           │   │   ├── database_connection_io.dart  # 原生文件数据库
│   │           │   │   └── database_connection_web.dart # Web 内存数据库
│   │           │   ├── tables/                     # 数据表定义
│   │           │   │   ├── vehicle_table.dart
│   │           │   │   ├── mission_table.dart
│   │           │   │   ├── alert_table.dart
│   │           │   │   ├── device_table.dart
│   │           │   │   └── sync_queue_table.dart
│   │           │   └── mappers/                    # Domain Entity ↔ Drift Row 映射
│   │           │       ├── vehicle_mapper.dart
│   │           │       ├── mission_mapper.dart
│   │           │       ├── alert_mapper.dart
│   │           │       └── device_mapper.dart
│   │           ├── remote/            # 远程 HTTP 数据源
│   │           │   ├── http_client.dart            # Dio HTTP 客户端封装
│   │           │   ├── mock_interceptor.dart       # Mock 数据拦截器
│   │           │   └── api_services/               # API 服务定义
│   │           │       ├── fleet_api_service.dart
│   │           │       ├── mission_api_service.dart
│   │           │       └── alert_api_service.dart
│   │           ├── ws/                # WebSocket 实时通道
│   │           │   ├── live_event.dart             # 实时事件模型
│   │           │   └── mock_ws_service.dart        # Mock WebSocket 推送服务
│   │           ├── services/          # 业务服务
│   │           │   └── agent_chat_service.dart     # Agent 对话服务
│   │           ├── repositories/      # Repository 接口实现（离线优先策略）
│   │           │   ├── fleet_repository_impl.dart
│   │           │   ├── mission_repository_impl.dart
│   │           │   ├── alert_repository_impl.dart
│   │           │   ├── agent_repository_impl.dart
│   │           │   ├── patrol_repository_impl.dart
│   │           │   └── approval_repository_impl.dart
│   │           └── sync/              # 离线同步引擎
│   │               └── sync_engine.dart
│   │
│   ├── cat_domain/                    # 领域层
│   │   └── lib/
│   │       ├── cat_domain.dart        # barrel 导出文件
│   │       └── src/
│   │           ├── entities/          # 核心业务实体（freezed 不可变模型）
│   │           │   ├── vehicle.dart
│   │           │   ├── mission.dart
│   │           │   ├── alert.dart
│   │           │   ├── device.dart
│   │           │   ├── agent_message.dart
│   │           │   ├── agent_card.dart
│   │           │   ├── patrol_point.dart
│   │           │   ├── approval_request.dart
│   │           │   └── notification_message.dart
│   │           ├── repositories/      # Repository 抽象接口
│   │           │   ├── fleet_repository.dart
│   │           │   ├── mission_repository.dart
│   │           │   ├── alert_repository.dart
│   │           │   ├── agent_repository.dart
│   │           │   ├── patrol_repository.dart
│   │           │   └── approval_repository.dart
│   │           ├── usecases/          # 用例（业务逻辑封装）
│   │           │   ├── start_mission.dart
│   │           │   ├── acknowledge_alert.dart
│   │           │   └── send_agent_command.dart
│   │           └── mock/              # Mock 数据仓库（纯内存实现，Demo 阶段使用）
│   │               ├── mock_fleet_repository.dart
│   │               ├── mock_mission_repository.dart
│   │               ├── mock_alert_repository.dart
│   │               ├── mock_patrol_repository.dart
│   │               └── mock_approval_repository.dart
│   │
│   ├── cat_features/                  # 业务功能模块（规划中，当前空包）
│   │   └── lib/                       # 当前所有页面和 Provider 位于 cat_core 中
│   │
│   └── cat_native/                    # 原生能力桥接（规划中，当前空包）
│       └── lib/                       # 后续阶段实现：CAN 数据、GNSS 定位、TTS 等
│
├── melos.yaml                         # Melos monorepo 配置
├── analysis_options.yaml              # 项目级 Lint 规则
├── pubspec.yaml                       # 根 workspace + melos 脚本
├── README.md                          # 项目说明与启动指南
├── demo-architecture.md               # 本文档：架构设计方案
├── demo-workflow.md                   # 分步构建工作流
├── CAT_Flutter-resume.md              # 简历项目经历
└── JD.md                              # 岗位 JD 要求
```

**依赖方向**（严格单向）：

```
apps (cat_vehicle / cat_tablet / cat_phone)
  └→ cat_core
       ├→ cat_design_system  (横向支撑，无领域依赖)
       ├→ cat_domain         (领域实体 + 接口)
       └→ cat_data           (数据实现)
            └→ cat_domain    (实现领域接口)
```

---

## 四、核心技术选型

| 层次 | 技术 | 选型理由 |
|------|------|---------|
| **框架** | Flutter 3.41+ / Dart 3.11+ | 一套代码三端部署（当前 Web，规划 Android/iOS） |
| **状态管理** | Riverpod 2.x | 编译安全、可测试、支持 Provider 作用域隔离 |
| **路由** | GoRouter 14.x | 声明式路由、ShellRoute/StatefulShellRoute、自定义转场 |
| **依赖注入** | GetIt + Injectable | 懒加载、模块化注册、解耦 |
| **本地数据库** | Drift 2.x (SQLite) | 离线持久化核心，类型安全、跨平台（IO + Web） |
| **HTTP 网络层** | Dio 5.x + Mock 拦截器 | 拦截器链、Mock 数据模拟后端 API |
| **WebSocket** | Timer 模拟（Stream 广播） | MockWebSocketService 定时推送车辆状态和告警事件 |
| **序列化** | freezed | 不可变模型、copyWith、JSON 序列化 |
| **地图** | flutter_map 7.x + latlong2 | 轻量开源地图（OpenStreetMap 瓦片） |
| **Monorepo** | Melos | 多包管理、依赖链接、统一脚本 |
| **代码生成** | build_runner (drift_dev + freezed) | Drift 数据库代码生成、freezed 模型生成 |
| **网络监测** | connectivity_plus | 在线/离线状态检测，驱动离线同步引擎 |

---

## 五、路由设计（三端自适应 GoRouter）

### 路由定义

```dart
// packages/cat_core/lib/src/routing/app_router.dart
enum AppType { vehicle, tablet, phone }

GoRouter createAppRouter(AppType appType) {
  return GoRouter(
    // 车载端默认打开矿区地图，平板/手机默认打开运营概览
    initialLocation: switch (appType) {
      AppType.vehicle => '/map',
      AppType.tablet || AppType.phone => '/dashboard',
    },
    routes: [
      // 三端共享业务路由，根据 AppType 选择不同 Shell
      switch (appType) {
        AppType.vehicle => _buildVehicleRoutes(),
        AppType.tablet  => _buildTabletRoutes(),
        AppType.phone   => _buildPhoneRoutes(),
      },
      // 车载端专属：全屏地图（顶层无壳路由）
      if (appType == AppType.vehicle) GoRoute(path: '/vehicle/fullscreen-map', ...),
      // 手机端专属：通知中心（顶层路由，通过 AppBar 铃铛进入）
      if (appType == AppType.phone) GoRoute(path: '/notifications', ...),
    ],
  );
}
```

### 三端 Shell 策略

| 终端 | Shell 类型 | 导航方式 | 特点 |
|------|-----------|---------|------|
| **车载** | `ShellRoute` → `VehicleShell` | 左侧固定侧边栏（5 项导航，驾驶员专属） | 始终横屏、全屏告警弹窗中断、硬件键盘快捷键 |
| **平板** | `ShellRoute` → `TabletShell` | 左侧导航面板（10 项） | 自适应双栏/单栏、支持横竖屏切换 |
| **手机** | `StatefulShellRoute.indexedStack` → `PhoneShell` | 底部导航栏（6 个标签） | 保持页面状态、竖屏窄屏优化 |

### 路由表

| 路径 | 页面 | 车载 | 平板 | 手机 |
|------|------|:---:|:---:|:---:|
| `/dashboard` | 运营概览 | — | ✅ | ✅ (Tab 1) |
| `/fleet` | 车队管理 | — | ✅ | — |
| `/fleet/:id` | 车辆详情 | — | ✅ | — |
| `/missions` | 任务管理 | ✅ (我的任务) | ✅ | ✅ (Tab 2) |
| `/missions/:id` | 任务详情 | ✅ | ✅ | ✅ |
| `/alerts` | 告警中心 | ✅ (告警) | ✅ | ✅ (Tab 3) |
| `/alerts/:id` | 告警详情 | ✅ | ✅ | ✅ |
| `/map` | 矿区地图 | ✅ (默认首页) | ✅ | — |
| `/vehicle-status` | 车辆状态（驾驶员专属） | ✅ | — | — |
| `/vehicle/fullscreen-map` | 全屏地图（车载专属） | ✅ | — | — |
| `/patrol` | 巡检打卡 | — | ✅ | ✅ (Tab 4) |
| `/approval` | 审批管理 | — | ✅ | ✅ (Tab 5) |
| `/approval/:id` | 审批详情 | — | ✅ | ✅ |
| `/notifications` | 通知中心 | — | ✅ | ✅ (顶层) |
| `/agent` | AI 助手 | ✅ | ✅ | ✅ (Tab 6) |

---

## 六、状态管理架构（Riverpod）

```
┌─────────────────────────────────────────────────────┐
│                   Riverpod 分层                      │
│                                                      │
│  UI Layer              Business Layer     Data Layer │
│  ┌──────────┐         ┌───────────┐     ┌──────────┐│
│  │ Page     │──watch─>│ Provider  │──>─>│Repository││
│  │ (Widget) │<──read──│(Future/   │<────│(GetIt)   ││
│  │          │         │ Stream)   │     │          ││
│  └──────────┘         └─────┬─────┘     └──────────┘│
│                              │                       │
│                       ┌──────┴──────┐               │
│                       │ Stream      │               │
│                       │ (Mock WS)   │               │
│                       └─────────────┘               │
└─────────────────────────────────────────────────────┘
```

### 核心 Provider 清单

```dart
// 1. Dashboard 统计数据（聚合 fleet + mission + alert）
final dashboardStatsProvider = FutureProvider<DashboardStats>(...);

// 2. 车辆/设备列表
final fleetVehiclesProvider = FutureProvider.autoDispose<List<Vehicle>>(...);
final fleetDevicesProvider = FutureProvider.autoDispose<List<Device>>(...);
final vehicleDetailProvider = FutureProvider.autoDispose.family<Vehicle?, String>(...);

// 3. 任务列表
final missionsProvider = FutureProvider.autoDispose<List<Mission>>(...);
final missionsByStatusProvider = FutureProvider.autoDispose.family<List<Mission>, String>(...);
final missionDetailProvider = FutureProvider.autoDispose.family<Mission?, String>(...);
final activeMissionCountProvider = FutureProvider.autoDispose<int>(...);

// 4. 告警列表
final alertsProvider = FutureProvider.autoDispose<List<Alert>>(...);
final alertsByLevelProvider = FutureProvider.autoDispose.family<List<Alert>, String>(...);
final todayAlertCountProvider = FutureProvider.autoDispose<int>(...);
final unacknowledgedAlertCountProvider = FutureProvider.autoDispose<int>(...);

// 5. Agent 对话
final agentProvider = StateNotifierProvider<AgentNotifier, AgentState>(...);

// 6. 网络连接状态
final connectivityProvider = StreamProvider<bool>(...);

// 7. WebSocket 实时数据流
final liveVehicleProvider = StreamProvider<LiveVehicleSnapshots>(...);
final liveAlertProvider = StreamProvider<LiveEvent>(...);
final liveAlertStreamProvider = StreamProvider.autoDispose<LiveEvent>(...);

// 8. 地图与巡检
final mapProvider = StateNotifierProvider<MapNotifier, MapState>(...);
final patrolProvider = FutureProvider.autoDispose<List<PatrolPoint>>(...);

// 9. 审批
final approvalProvider = FutureProvider.autoDispose<List<ApprovalRequest>>(...);

// 10. 通知
final notificationProvider = FutureProvider.autoDispose<List<NotificationMessage>>(...);
```

---

## 七、离线与同步引擎设计

### 7.1 数据分层访问策略（Repository 离线优先）

```dart
// Repository 实现中的离线策略
class MissionRepoImpl implements MissionRepository {
  final AppDatabase db;
  final CatHttpClient httpClient;

  Future<List<Mission>> getMissions() async {
    // 1. 先返回本地缓存（Drift，立即可用）
    final cached = await db.getAllMissions();
    // 2. 后台尝试网络更新（Demo 阶段由 MockInterceptor 拦截返回 Mock 数据）
    try {
      final remote = await httpClient.get('/api/missions');
      await db.upsertMissions(remote);  // 更新本地
      return remote;
    } catch (_) {
      return cached;  // 网络失败，使用缓存
    }
  }
}
```

### 7.2 离线操作队列

```
用户操作（如"确认告警"）
    │
    ▼
┌──────────────┐
│  SyncQueue    │  ← Drift 表: sync_queue_items
│  ┌──────────┐ │     (id, operation_type, payload, retries, status)
│  │ Operation│ │
│  └──────────┘ │
└──────┬───────┘
       │ 网络恢复
       ▼
┌──────────────┐
│ SyncEngine   │  顺序执行 → 失败重试 (最多 3 次) → 成功删除
│              │  监听 ConnectivityService 的 onConnectivityChanged Stream
└──────────────┘
```

### 7.3 Mock WebSocket 实时推送

```dart
// MockWebSocketService — 使用 Timer 模拟真实 WebSocket 的数据推送
// 每 3 秒周期：
//   1. 随机选择若干车辆发送状态更新（速度、位置微调）
//   2. 以一定概率生成新的告警事件（LiveEvent.alertNew）
//
// 通过 StreamController.broadcast() 广播事件，UI 层通过 Riverpod
// StreamProvider 订阅。

// 车载端 VehicleShell 中额外监听 alert_new 事件：
//   - critical 级别告警 → 全屏弹窗中断当前操作（最高优先级）
//   - 支持键盘快捷键（Enter/Space 确认，Escape 关闭）
```

---

## 八、Demo 核心场景与数据流设计

### 8.1 任务下发与执行（实时闭环）

```
调度员下发任务                   矿卡终端                      平台服务 (Mock)
     │                           │                            │
     │  POST /missions            │                            │
     │───────────────────────────────────────────────────────>│
     │                           │                            │
     │                           │  Mock WS: mission.assigned │
     │                           │<───────────────────────────│
     │                           │                            │
     │                           │  司机点击「接受」            │
     │                           │  本地写入 Drift (离线容灾)  │
     │                           │                            │
     │                           │  PUT /missions/{id}/accept │
     │                           │───────────────────────────>│
```

### 8.2 弱网离线演示

- **离线状态**：界面无 crash，数据来自 Drift 本地缓存
- **操作离线排队**：写入类操作进入 SyncQueue 表，恢复网络后逐条提交
- **同步状态展示**：ConnectivityBadge 组件实时显示在线/离线状态
- **冲突处理**：当前采用 `last_write_wins` 策略（后续阶段增强为对比 UI）

### 8.3 Agent 交互

```
┌─────────────────────────────────────────┐
│              Agent Chat UI               │
│                                          │
│  Agent: 检测到 3 号矿卡发动机温度异常     │
│  (142°C)，建议暂停作业。                  │
│  ┌─────────────────────────────────────┐ │
│  │  🚨 温度告警 Card                   │ │
│  │  车辆: CUSTOM-003  温度: 142°C      │ │
│  │  [暂停作业] [忽略] [详情]           │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  User: 暂停该车辆并通知维修班组           │
│                                          │
│  Agent: 已暂停 CUSTOM-003，维修工单      │
│  #WO-2024-0891 已创建。                  │
│  ┌─────────────────────────────────────┐ │
│  │  ✅ 操作确认 Card                   │ │
│  │  工单: WO-2024-0891                │ │
│  │  [查看工单] [撤销操作]              │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**Agent 卡片类型**：
- `AgentAlertCard` — 告警信息卡片（温度、速度、油量异常等）
- `AgentActionCard` — 建议操作卡片（暂停/继续/改道等可执行动作）
- `AgentConfirmCard` — 操作确认卡片（结果回执 + 撤销按钮）
- `AgentInfoCard` — 通用信息卡片

---

## 九、设计系统（cat_design_system）

### 9.1 三套主题

```dart
// packages/cat_design_system/lib/theme/cat_themes.dart
class CatThemes {
  static ThemeData get vehicleTheme { ... }  // 暗色高对比度主题（Material 3）
  static ThemeData get tabletTheme { ... }   // 亮色主题（Material 3）
  static ThemeData get phoneTheme { ... }    // 亮色主题（Material 3）
}
```

### 9.2 设计令牌

| 令牌类别 | 文件 | 内容 |
|---------|------|------|
| 颜色 | `tokens/colors.dart` | 三套色板（primary / surface / border / error / on*） |
| 间距 | `tokens/spacing.dart` | xs(4) / sm(8) / md(16) / lg(24) / xl(32) |
| 排版 | `tokens/typography.dart` | 三套 TextTheme（字号/字重/行高按终端适配） |

### 9.3 原子组件

| 组件 | 用途 |
|------|------|
| `CatButton` | 统一按钮（支持 primary / secondary / danger / ghost 等样式） |
| `CatCard` | 统一卡片容器 |
| `CatBadge` | 徽标/标签 |
| `CatAppBar` | 统一应用栏（PreferredSizeWidget） |
| `CatBottomBar` | 统一底部导航栏 |

### 9.4 自适应布局

```dart
enum DeviceClass { phone, tablet, desktop }

// DeviceClassProvider 根据屏幕宽度自动判定：
// phone:    < 600dp
// tablet:   600-1024dp
// desktop:  > 1024dp

class AdaptiveLayout extends StatelessWidget {
  // 根据 DeviceClass 切换布局策略
}
```

---

## 十、Demo 可展示的关键技术亮点

| 序号 | 展示点 | 演示方式 |
|------|--------|---------|
| **1** | **模块化架构** | 展示 Melos Monorepo 目录结构，讲解 Clean Architecture 分层与单向依赖 |
| **2** | **三端角色自适应** | 同一套代码在车载（驾驶员 5 项导航）/ 平板（调度员 10 项面板）/ 手机（管理者 6 个 Tab）展示不同功能和主题 |
| **3** | **实时数据推送** | MockWebSocketService 模拟车辆状态实时刷新，地图上车辆标记平滑移动 |
| **4** | **离线可用** | 断网后数据来自 Drift 本地缓存，操作入离线队列，联网后 SyncEngine 自动同步 |
| **5** | **Agent 结构化交互** | 演示 4 种卡片类型的 Agent 对话：告警触发 → 建议操作 → 确认反馈 |
| **6** | **地图 + Overlay** | flutter_map 上展示车辆标记（VehicleMarker）+ 告警气泡 + 路线线条 |
| **7** | **车载驾驶员专属终端** | 车辆仪表盘实时数据（速度/油量/发动机温度）+ critical 全屏告警中断 + 键盘快捷键 |
| **8** | **代码质量** | freezed 不可变模型 + Drift 类型安全数据库 + Riverpod 编译安全 Provider + 全量中文文档注释 |

---

## 十一、核心依赖清单

```yaml
# packages/cat_core/pubspec.yaml (核心包依赖最全)
dependencies:
  flutter_riverpod: ^2.5.0
  go_router: ^14.0.0
  get_it: ^7.6.0
  injectable: ^2.4.0
  dio: ^5.4.0
  drift: ^2.16.0
  sqlite3_flutter_libs: ^0.5.0
  web_socket_channel: ^2.4.0
  freezed_annotation: ^2.4.0
  connectivity_plus: ^6.0.0
  flutter_map: ^7.0.0
  latlong2: ^0.9.1

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.4.0
  drift_dev: ^2.16.0
  injectable_generator: ^2.6.0
  mocktail: ^1.0.0
```

---

## 十二、面试讲述建议

> **开场 (1 分钟)**：「这是一个面向无人矿山场景的跨平台终端 Demo，我使用 Flutter + Melos Monorepo 架构，在一套代码库里同时支持车载大屏（驾驶员）、平板（调度员）和手机（管理者），每个终端按角色裁剪功能——车载端仅 5 项驾驶员核心功能，平板和手机各有完整的 9 个业务模块。接下来我分别展示架构分层、三端角色自适应、实时数据、离线能力和 Agent 交互。」

> **架构讲解 (3 分钟)**：从下往上讲 — 平台层 → 数据层（Drift + Dio Mock） → 领域层（freezed 实体 + Repository 接口） → 应用层（Riverpod Provider + GoRouter 三端按角色路由） → 表现层（三套 Shell + 角色差异化导航 + 共用组件），每层一句话说明职责，强调"依赖方向单向"、"模块复用"和"同代码库多角色终端"。

> **核心演示 (8 分钟)**：按上表清单顺序，每个点 1 分钟演示 + 1 句设计理由。

> **收尾 (3 分钟)**：主动提可以深入讲的部分（如离线同步引擎的队列设计、车载端车辆仪表盘实时数据与全屏告警中断逻辑、按角色裁剪路由的设计决策、Riverpod 的 autoDispose 与 Provider 作用域隔离），把主动权交给面试官。