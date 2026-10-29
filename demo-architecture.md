# 无人矿山生产管控终端 Demo — 架构设计方案

---

## 一、Demo 定位与目标

> **一句话定位**：面向面试展示的「矿山作业管控中心」跨平台终端 Demo，覆盖车载大屏、平板和手机三类终端，在一套 Flutter 代码库中演示模块化架构、实时数据、弱网离线、Agent 交互和地图集成等核心能力。

### Demo 场景闭环

```
矿山调度员下发运输任务 → 矿卡接收任务并执行 
→ 车辆实时状态回传 → 异常告警触发 → Agent 辅助决策 
→ 现场人员巡检确认 → 任务闭环
```

### 演示终端矩阵

| 终端类型 | 设备形态 | 核心角色 | Demo 重点场景 |
|----------|---------|---------|-------------|
| **Linux 车载终端** | 12 寸固定触摸屏 | 矿卡驾驶员 | 任务接收、路线导航、车辆状态、告警弹窗、Agent 语音 |
| **Android/iOS 平板** | 10 寸手持平板 | 现场巡检/调度员 | 设备总览、任务面板、告警处置、地图/Twin 视图 |
| **手机** | 6 寸手机 | 管理人员 | 运营概览看板、审批、消息通知、关键决策 |

---

## 二、整体架构分层

```
┌─────────────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐ │
│  │ 车载 Shell │  │ 平板 Shell │  │ 手机 Shell │  │  Agent Chat Overlay  │ │
│  │ (Landscape)│  │(Adaptive) │  │ (Portrait) │  │  (全终端共用)         │ │
│  └─────┬─────┘  └─────┬─────┘  └─────┬─────┘  └──────────┬───────────┘ │
│        │              │              │                    │             │
│  ┌─────┴──────────────┴──────────────┴────────────────────┴──────────┐ │
│  │                    SHARED UI COMPONENTS                             │ │
│  │  Design System │ Feature Widgets │ Agent Cards │ Adaptive Layout    │ │
│  └────────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                       APPLICATION LAYER                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Routing  │  │  State   │  │   DI     │  │  Config  │             │
│  │ (GoRouter)│  │(Riverpod)│  │ (GetIt)  │  │ (Env)    │             │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘             │
├─────────────────────────────────────────────────────────────────────┤
│                        DOMAIN LAYER                                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  Entities │  │ UseCases │  │Repository│  │  Models  │             │
│  │           │  │          │  │Interface │  │          │             │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘             │
├─────────────────────────────────────────────────────────────────────┤
│                         DATA LAYER                                    │
│  ┌──────────┐  ┌──────────┐  ┌───────────┐  ┌─────────────────────┐ │
│  │  Remote  │  │  Local   │  │  Cache    │  │  Native Bridge       │ │
│  │ (REST/WS)│  │ (Drift)  │  │ (Strategy)│  │  (Pigeon/FFI)        │ │
│  └──────────┘  └──────────┘  └───────────┘  └─────────────────────┘ │
├─────────────────────────────────────────────────────────────────────┤
│                      PLATFORM LAYER                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────────────┐│
│  │   Linux ARM  │  │  Android     │  │  iOS/iPadOS                  ││
│  │  (Embedded)  │  │  (Mobile)    │  │  (Mobile)                    ││
│  │              │  │              │  │                              ││
│  │ · Flutter    │  │ · Flutter    │  │ · Flutter                    ││
│  │   Embedder   │  │   Embedder   │  │   Embedder                   ││
│  │ · Wayland    │  │ · Surface    │  │ · UIKit/SwiftUI              ││
│  │ · CAN/FFI    │  │ · JNI/FFI    │  │ · FFI                        ││
│  └──────────────┘  └──────────────┘  └──────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────┘
```

---

## 三、项目模块结构（Monorepo）

```
cat_app/
├── apps/                              # 三端入口应用
│   ├── cat_vehicle/                   # Linux 车载终端入口
│   │   ├── lib/main_vehicle.dart
│   │   ├── linux/                     # Linux embedder 配置
│   │   └── pubspec.yaml
│   ├── cat_tablet/                    # Android/iOS 平板入口
│   │   ├── lib/main_tablet.dart
│   │   ├── android/
│   │   ├── ios/
│   │   └── pubspec.yaml
│   └── cat_phone/                     # 手机入口
│       ├── lib/main_phone.dart
│       ├── android/
│       ├── ios/
│       └── pubspec.yaml
│
├── packages/                          # 共享包（Melos 管理）
│   ├── cat_core/                      # 核心基础设施
│   │   └── lib/src/
│   │       ├── di/                    # 依赖注入 (GetIt)
│   │       ├── routing/               # 路由定义与守卫
│   │       ├── config/                # 环境配置、主题常量
│   │       ├── network/               # HTTP Client、拦截器、重试
│   │       ├── connectivity/          # 网络状态监测、离线队列
│   │       ├── storage/               # Drift 数据库、Key-Value 缓存
│   │       ├── logging/               # 分级日志、崩溃收集 Stub
│   │       ├── error/                 # 全局错误处理、Failure 模型
│   │       └── utils/                 # 扩展方法、工具函数
│   │
│   ├── cat_design_system/             # 跨终端 Design System
│   │   └── lib/src/
│   │       ├── theme/                 # 主题（车载暗色/平板亮色/手机）
│   │       ├── tokens/                # 间距、圆角、字号、颜色 Token
│   │       ├── components/            # 原子组件 (Button, Card, Badge...)
│   │       ├── layout/                # 自适应布局组件
│   │       └── icons/                 # 矿山业务图标集
│   │
│   ├── cat_data/                      # 数据层
│   │   └── lib/src/
│   │       ├── remote/                # REST API 数据源
│   │       │   ├── fleet_api.dart
│   │       │   ├── mission_api.dart
│   │       │   ├── alert_api.dart
│   │       │   └── agent_api.dart
│   │       ├── local/                 # 本地持久化 (Drift DAO)
│   │       │   ├── mission_dao.dart
│   │       │   ├── alert_dao.dart
│   │       │   └── device_dao.dart
│   │       ├── realtime/              # WebSocket/MQTT 实时通道
│   │       │   ├── ws_channel.dart
│   │       │   ├── mqtt_channel.dart
│   │       │   └── subscription_manager.dart
│   │       ├── cache/                 # 缓存策略
│   │       │   ├── cache_policy.dart
│   │       │   └── stale_while_revalidate.dart
│   │       ├── sync/                  # 离线同步引擎
│   │       │   ├── sync_queue.dart
│   │       │   ├── conflict_resolver.dart
│   │       │   └── sync_engine.dart
│   │       ├── repository/            # Repository 实现
│   │       │   ├── fleet_repo_impl.dart
│   │       │   ├── mission_repo_impl.dart
│   │       │   └── alert_repo_impl.dart
│   │       └── dto/                   # 数据传输对象、序列化
│   │
│   ├── cat_domain/                    # 领域层
│   │   └── lib/src/
│   │       ├── entities/              # 核心业务实体
│   │       │   ├── vehicle.dart
│   │       │   ├── mission.dart
│   │       │   ├── alert.dart
│   │       │   ├── device.dart
│   │       │   └── agent_message.dart
│   │       ├── repositories/          # Repository 接口（抽象）
│   │       │   ├── fleet_repository.dart
│   │       │   ├── mission_repository.dart
│   │       │   └── alert_repository.dart
│   │       └── usecases/              # 用例
│   │           ├── start_mission.dart
│   │           ├── acknowledge_alert.dart
│   │           ├── send_agent_command.dart
│   │           └── submit_patrol_report.dart
│   │
│   ├── cat_features/                  # 业务功能模块
│   │   └── lib/src/
│   │       ├── dashboard/             # 运营概览
│   │       │   ├── presentation/      # UI + Riverpod Providers
│   │       │   └── models/            # 视图模型
│   │       ├── fleet/                 # 车队/设备管理
│   │       ├── mission/               # 任务管理
│   │       ├── alert/                 # 告警中心
│   │       ├── patrol/                # 现场巡检
│   │       ├── agent/                 # Agent 对话与卡片
│   │       ├── map/                   # 地图/Twin 视图
│   │       ├── approval/              # 审批流程
│   │       └── notification/          # 消息通知
│   │
│   └── cat_native/                    # 原生能力桥接
│       └── lib/src/
│           ├── platform/              # Platform Channel 封装
│           │   ├── can_bridge.dart    # CAN 数据读取 (车载)
│           │   ├── gnss_bridge.dart   # GNSS/RTK 定位
│           │   ├── camera_bridge.dart # 巡检拍照
│           │   └── tts_bridge.dart    # 语音播报
│           └── ffi/                   # FFI 绑定
│               └── twin_view_bridge.dart  # Digital Twin 原生视图
│
├── config/
│   ├── melos.yaml                     # Melos monorepo 配置
│   ├── analysis_options.yaml          # 项目级 Lint 规则
│   └── env/
│       ├── .env.dev                   # 开发环境
│       ├── .env.staging               # 测试环境
│       └── .env.prod                  # 生产环境
│
├── scripts/
│   ├── build_vehicle.sh               # 车载 Linux ARM 构建
│   ├── build_android.sh
│   ├── build_ios.sh
│   └── gen_pigeon.sh                  # Pigeon 代码生成
│
└── proto/                             # Protobuf 定义
    ├── fleet.proto
    ├── mission.proto
    └── agent.proto
```

---

## 四、核心技术选型

| 层次 | 技术 | 选型理由 |
|------|------|---------|
| **框架** | Flutter 3.x + Dart 3.x | JD 核心要求，一套代码三端部署 |
| **状态管理** | Riverpod 2.x | 编译安全、可测试、支持 Provider 作用域隔离 |
| **路由** | GoRouter | 声明式路由、深度链接、路由守卫、自适应跳转 |
| **依赖注入** | GetIt + Injectable | 编译期 DI、懒加载、模块化注册 |
| **本地数据库** | Drift (SQLite) | 离线持久化核心，类型安全、迁移友好 |
| **网络层** | Dio + Retrofit | 拦截器链、重试策略、Protobuf/JSON 双协议 |
| **WebSocket** | web_socket_channel | 实时状态订阅通道 |
| **MQTT** | mqtt_client | 车载端物联网标准协议，低带宽友好 |
| **序列化** | Protobuf + freezed | Protobuf 用于高频实时数据，freezed 用于业务模型 |
| **地图** | flutter_map + 自定义 Tile | 轻量、可离线瓦片缓存，可替换为商用 SDK |
| **原生桥接** | Pigeon (类型安全) + dart:ffi | Pigeon 处理 Platform Channel，FFI 处理 C/C++ SDK |
| **Monorepo** | Melos | 多包管理、依赖链接、统一脚本 |
| **代码生成** | build_runner + mason | 模板化创建 Feature 模块 |
| **测试** | flutter_test + mocktail + patrol | 单元/Widget/集成测试三件套 |
| **崩溃** | Sentry (Dart + Native) | 全平台崩溃采集 |

---

## 五、Demo 核心场景与数据流设计

### 5.1 任务下发与执行（实时闭环）

```
调度员下发任务                   矿卡终端                      平台服务
     │                           │                            │
     │  POST /missions            │                            │
     │───────────────────────────────────────────────────────>│
     │                           │                            │
     │                           │  WS: mission.assigned      │
     │                           │<───────────────────────────│
     │                           │                            │
     │                           │  本地写入 Drift (离线容灾)  │
     │                           │  推送本地通知 + TTS 播报    │
     │                           │                            │
     │                           │  司机点击「接受」            │
     │                           │  PUT /missions/{id}/accept │
     │                           │───────────────────────────>│
     │                           │                            │
     │                           │  WS: mission.status_update │
     │                           │<───────────────────────────│ (同步到调度员)
```

**演示要点**：
- WebSocket 断线后自动重连，重连期间任务从本地 Drift 读取
- 任务状态变更加入离线队列，恢复网络后批量提交
- 展示消息去重（基于 `messageId + sequence`）

### 5.2 弱网离线演示

```
┌─────────────────────────────────────────┐
│            Offline-First Engine          │
│                                          │
│  网络状态监听 (connectivity_plus)         │
│       │                                  │
│       ├─ Online ──> 直接请求 + 清空队列   │
│       │                                  │
│       ├─ Offline ─> 读取本地缓存          │
│       │            写入操作入 SyncQueue   │
│       │            显示离线 Badge         │
│       │                                  │
│       └─ Reconnect ─> 冲突检测           │
│                       (last_write_wins   │
│                        或 手动合并)       │
│                       批量 Flush 队列     │
└─────────────────────────────────────────┘
```

**演示要点**：
- 飞行模式切换，界面无 crash、数据可用
- 恢复网络后自动同步，展示同步进度 Dialog
- 冲突时展示对比 UI，让用户手动选择

### 5.3 Agent 交互

```
┌─────────────────────────────────────────┐
│              Agent Chat UI               │
│                                          │
│  ┌─────────────────────────────────┐     │
│  │ Agent: 检测到 3 号矿卡发动机      │     │
│  │ 温度异常 (142°C)，建议暂停作业。  │     │
│  │                                  │     │
│  │ ┌─────────────────────────────┐ │     │
│  │ │  🚨 温度告警 Card           │ │     │
│  │ │  车辆: CAT-003              │ │     │
│  │ │  当前: 142°C  阈值: 120°C  │ │     │
│  │ │  [暂停作业] [忽略] [详情]   │ │     │
│  │ └─────────────────────────────┘ │     │
│  └─────────────────────────────────┘     │
│                                          │
│  ┌─────────────────────────────────┐     │
│  │ User: 暂停该车辆并通知维修班组   │     │
│  └─────────────────────────────────┘     │
│                                          │
│  ┌─────────────────────────────────┐     │
│  │ Agent: 已暂停 CAT-003，维修工单  │     │
│  │ #WO-2024-0891 已创建。          │     │
│  │ ┌─────────────────────────────┐ │     │
│  │ │  ✅ 操作确认 Card            │ │     │
│  │ │  动作: 暂停作业              │ │     │
│  │ │  工单: WO-2024-0891         │ │     │
│  │ │  时间: 14:32:05             │ │     │
│  │ │  [查看工单] [撤销操作]      │ │     │
│  │ └─────────────────────────────┘ │     │
│  └─────────────────────────────────┘     │
└─────────────────────────────────────────┘
```

**关键设计**：
- **结构化卡片协议**：Agent 返回的 JSON 包含 `cardType`、`payload`、`actions` 字段，客户端映射到对应 Widget
- **流式输出**：使用 SSE/WebSocket Streaming，展示打字机效果
- **高风险操作确认**：暂停车辆、修改路线等操作必须二次确认，调用后端权限校验
- **失败恢复**：Agent 操作执行失败后，展示回滚信息、支持重试

### 5.4 地图与 Digital Twin 视图

```
┌─────────────────────────────────────────┐
│  地图/Twin 容器 (PlatformView/Texture)   │
│                                          │
│  ┌──────────────────────────────────┐   │
│  │     Native GL/Vulkan Render      │   │ ← C/C++ SDK (FFI)
│  │  3D 矿区场景 + 车辆实时位置       │   │
│  └──────────────────────────────────┘   │
│                                          │
│  ┌─ Flutter Overlay ────────────────┐   │
│  │  ● 车辆状态标签 (Stack)           │   │
│  │  ● 告警气泡                      │   │
│  │  ● 任务路线 (CustomPainter)      │   │
│  │  ● Agent 建议浮层               │   │
│  └──────────────────────────────────┘   │
│                                          │
│  手势协调:                               │
│  · 原生 View 处理拖拽/缩放/旋转          │
│  · Flutter 处理 Overlay 点击/长按        │
│  · 通过 FFI 双向通知手势状态            │
└─────────────────────────────────────────┘
```

---

## 六、多终端自适应策略

### 6.1 Shell 模式

```dart
// 三端各自使用不同的 AppShell
// apps/cat_vehicle/lib/main_vehicle.dart
class VehicleShell extends StatelessWidget {
  // 全屏地图 + 左侧固定任务面板 + 底部状态栏
  // 始终横屏、无返回手势、大触摸目标 (48dp+)
  // 高对比度暗色主题、抗眩光
}

// apps/cat_tablet/lib/main_tablet.dart
class TabletShell extends StatelessWidget {
  // Master-Detail 双栏布局 (横屏)
  // 单栏 + BottomNav (竖屏)
  // 支持分屏、Slide Over
}

// apps/cat_phone/lib/main_phone.dart
class PhoneShell extends StatelessWidget {
  // 单栏 + BottomNavigationBar
  // 侧重查看/审批/通知，不执行高风险操作
}
```

### 6.2 自适应断点

```dart
// packages/cat_design_system/lib/src/layout/
enum DeviceClass { phone, tablet, desktop }

class AdaptiveLayout extends StatelessWidget {
  // phone:    < 600dp   → 单栏
  // tablet:   600-1024  → 双栏/可切换
  // desktop/vehicle: > 1024 → 多面板固定
}
```

### 6.3 输入适配

| 终端 | 输入方式 | 适配策略 |
|------|---------|---------|
| 车载 | 触摸 (戴手套) | 最小触摸目标 48dp、手势简化、物理按键映射 |
| 平板 | 触摸 + 键盘 | 标准触摸目标 44dp、支持快捷键 |
| 手机 | 触摸 | 标准 Material 交互 |

---

## 七、状态管理架构（Riverpod）

```
┌─────────────────────────────────────────────────────┐
│                   Riverpod 分层                      │
│                                                      │
│  UI Layer              Business Layer     Data Layer │
│  ┌──────────┐         ┌───────────┐     ┌──────────┐│
│  │ Widget   │──watch─>│ AsyncNotifier│──>│Repository││
│  │          │<──read──│ (State)    │<───│          ││
│  └──────────┘         └─────┬─────┘     └──────────┘│
│                              │                       │
│                       ┌──────┴──────┐               │
│                       │  Stream     │               │
│                       │  (WS/MQTT)  │               │
│                       └─────────────┘               │
│                                                      │
│  Provider 作用域隔离:                                  │
│  · fleetScope    → 车辆状态相关 Providers             │
│  · missionScope  → 任务相关 Providers                │
│  · agentScope    → Agent 对话 Providers              │
│                                                      │
│  各自独立 dispose，避免内存泄漏                        │
└─────────────────────────────────────────────────────┘
```

### Demo 中的 5 个核心 Provider

```dart
// 1. 车辆列表 (WebSocket 驱动)
final fleetProvider = AsyncNotifierProvider<FleetNotifier, List<Vehicle>>(
  FleetNotifier.new,
);

// 2. 任务列表 (离线优先)
final missionProvider = AsyncNotifierProvider<MissionNotifier, List<Mission>>(
  MissionNotifier.new,
);

// 3. 网络状态
final connectivityProvider = StreamProvider<ConnectivityStatus>(
  (ref) => ref.watch(connectivityServiceProvider).statusStream,
);

// 4. Agent 对话 (流式)
final agentChatProvider = AsyncNotifierProvider<AgentChatNotifier, ChatState>(
  AgentChatNotifier.new,
);

// 5. 地图选中实体
final selectedEntityProvider = StateProvider<TwinEntity?>((ref) => null);
```

---

## 八、离线与同步引擎设计

### 8.1 数据分层访问策略

```dart
// Repository 中的离线策略
class MissionRepositoryImpl implements MissionRepository {
  
  Future<List<Mission>> getMissions() async {
    // 1. 先返回本地缓存 (立即可用)
    final cached = await localDao.getAll();
    
    // 2. 后台尝试网络更新
    if (await connectivity.isOnline) {
      try {
        final remote = await remoteApi.getMissions();
        await localDao.upsertAll(remote);  // 更新本地
        return remote;
      } catch (e) {
        // 网络失败，返回缓存
        logger.warn('Failed to fetch missions, using cache', e);
        return cached;
      }
    }
    
    return cached;  // 离线，纯本地
  }
}
```

### 8.2 离线操作队列

```
用户操作 (离线)
    │
    ▼
┌──────────────┐
│  SyncQueue    │  ← Drift 表: sync_queue
│  ┌──────────┐ │     id, action, payload, created_at, retry_count
│  │ Operation│ │
│  │ · accept │ │
│  │ · reject │ │
│  │ · update │ │
│  └──────────┘ │
└──────┬───────┘
       │ 网络恢复
       ▼
┌──────────────┐
│ SyncEngine   │  顺序执行 → 失败重试 (指数退避) → 成功删除
│              │  幂等性: 每个操作带 clientGeneratedId
└──────────────┘
```

### Demo 演示方式

在演示时通过设备飞行模式切换，展示：
1. 离线状态下数据正常展示（来自本地缓存）
2. 离线执行「确认告警」操作，操作加入队列
3. 恢复网络，自动同步，告警状态更新

---

## 九、Demo 页面路由设计

```dart
// GoRouter 配置
final router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    // ============ 通用路由 ============
    ShellRoute(
      builder: (context, state, child) => AdaptiveShell(child: child),
      routes: [
        GoRoute(path: '/dashboard',     pageBuilder: ...), // 运营概览
        GoRoute(path: '/fleet',         pageBuilder: ...), // 车队设备
        GoRoute(path: '/fleet/:id',     pageBuilder: ...), // 车辆详情
        GoRoute(path: '/missions',      pageBuilder: ...), // 任务列表
        GoRoute(path: '/missions/:id',  pageBuilder: ...), // 任务详情
        GoRoute(path: '/alerts',        pageBuilder: ...), // 告警中心
        GoRoute(path: '/patrol',        pageBuilder: ...), // 现场巡检
        GoRoute(path: '/map',           pageBuilder: ...), // 地图/Twin
      ],
    ),
    
    // ============ 车载专属 ============
    GoRoute(
      path: '/vehicle/fullscreen-map',
      pageBuilder: (context, state) => const FullScreenMapPage(),
    ),
    
    // ============ Agent (Overlay 模式) ============
    GoRoute(
      path: '/agent',
      pageBuilder: (context, state) => const AgentChatPage(),
    ),
    
    // ============ 审批 ============
    GoRoute(path: '/approvals',        pageBuilder: ...),
    GoRoute(path: '/approvals/:id',    pageBuilder: ...),
  ],
);
```

---

## 十、Demo 可展示的关键技术亮点

### 展示清单（面试 15-20 分钟演示路径）

| 序号 | 展示点 | JD 对应 | 演示方式 |
|------|--------|---------|---------|
| **1** | **模块化架构** | 架构设计 | 展示项目目录结构，Melos 依赖图，讲解分层 |
| **2** | **三端自适应** | 多终端 | 同一套代码在车载/平板/手机上展示不同布局 |
| **3** | **WebSocket 实时数据** | 实时通信 | 车辆状态实时刷新，模拟平台推送 |
| **4** | **离线可用** | 弱网离线 | 断网后数据仍可查看和操作，联网后自动同步 |
| **5** | **Agent 结构化交互** | Agent 交互 | 演示告警自动触发 Agent 建议，卡片确认操作 |
| **6** | **地图 + Overlay** | 数字孪生 | 地图上 Flutter Overlay 展示车辆标签、路线 |
| **7** | **代码质量** | 工程质量 | 展示 Riverpod 测试用例 + Sentry 崩溃采集面板 |
| **8** | **性能** | 性能优化 | DevTools 展示帧率、内存、启动时间 |

---

## 十一、Demo 依赖清单（pubspec.yaml 摘要）

```yaml
# packages/cat_core/pubspec.yaml
dependencies:
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  go_router: ^14.0.0
  get_it: ^7.6.0
  injectable: ^2.4.0
  dio: ^5.4.0
  drift: ^2.16.0
  sqlite3_flutter_libs: ^0.5.0
  web_socket_channel: ^2.4.0
  mqtt_client: ^10.2.0
  freezed_annotation: ^2.4.0
  protobuf: ^3.1.0
  connectivity_plus: ^6.0.0
  sentry_flutter: ^8.0.0
  flutter_map: ^6.1.0
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  riverpod_generator: ^2.4.0
  freezed: ^2.4.0
  drift_dev: ^2.16.0
  injectable_generator: ^2.6.0
  mocktail: ^1.0.0
  patrol: ^3.0.0           # 集成测试 (车载/平板/手机)
```

---

## 十二、Demo 工作量估算与分阶段交付

| 阶段 | 内容 | 预估时间 | 输出 |
|------|------|---------|------|
| **Phase 1: 骨架** | Monorepo 搭建、核心模块（core + design_system）、三端 Shell 可运行 | 2 天 | Hello World 在三端同时运行 |
| **Phase 2: 数据层** | Drift 建表、REST API 对接、WebSocket 通道、离线队列 | 3 天 | 数据流完整跑通 |
| **Phase 3: 业务功能** | Dashboard、Fleet、Mission、Alert 模块 UI | 3 天 | 核心场景可交互 |
| **Phase 4: Agent** | Chat UI、结构化卡片、流式输出、确认工作流 | 2 天 | Agent 交互完整演示 |
| **Phase 5: 地图** | 地图组件集成、业务 Overlay、车辆实时位置 | 2 天 | 地图 + Overlay 联动 |
| **Phase 6: 打磨** | 离线演示、性能调优、Sentry 集成、测试补充 | 2 天 | 面试-ready 状态 |
| **合计** | | **~14 天** | |

---

## 十三、面试讲述建议

> **开场 (1 分钟)**: "这是一个面向无人矿山场景的跨平台终端 Demo，我使用 Flutter + Monorepo 架构在一套代码库里同时支持 Linux 车载大屏、Android/iOS 平板和手机。接下来我分别展示架构分层、三端自适应、实时数据、离线能力和 Agent 交互。"

> **架构讲解 (3 分钟)**: 从下往上讲 — 平台层 → 数据层 → 领域层 → 表现层，每层一句话说明职责，重点强调"为什么这么分层"以及"模块如何复用"。

> **核心演示 (8 分钟)**: 按上面清单顺序，每个点 1 分钟演示 + 1 句设计理由。

> **收尾 (3 分钟)**: 主动提可以深入讲的部分（如离线同步引擎的冲突解决算法、FFI 集成的坑、Riverpod 测试策略），把主动权交给面试官。