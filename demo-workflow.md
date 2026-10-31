# 无人矿山生产管控终端 Demo — 分步构建工作流

> **原则**：每一步完成后必须能 `flutter run` 编译启动并在设备/模拟器上看到预览效果，不允许中间步骤出现编译失败或白屏。
> **约束**：所有新增代码必须包含必要的中文注释，包括类/方法的文档注释、关键逻辑的行内注释，确保团队成员能快速理解代码意图。

---

## 总览流程图

```
Step 1: Monorepo + 三端 Hello World
  └─> 验证: 车载/平板/手机三端各自显示 Hello World
      │
Step 2: Design System + 主题系统
  └─> 验证: 三端展示不同的主题样式（暗色/亮色）+ 组件库预览页
      │
Step 3: 三端自适应 Shell + 路由框架
  └─> 验证: 三端各自 Shell 布局 + 页面导航跳转
      │
Step 4: 领域层 + 数据模型
  └─> 验证: 静态数据渲染 Dashboard
      │
Step 5: 数据层 — REST API + Drift 本地存储
  └─> 验证: 带 Mock 数据的 Dashboard + 离线缓存展示
      │
Step 6: 数据层 — WebSocket 实时通道 + 离线队列
  └─> 验证: Dashboard 实时刷新 + 断网 Badge + 操作队列 UI
      │
Step 7: 车队设备管理模块
  └─> 验证: 车队列表/详情页 + 三端 Adaptive 布局
      │
Step 8: 任务管理模块
  └─> 验证: 任务列表/详情 + 任务状态流转（接受→执行→完成）
      │
Step 9: 告警中心模块
  └─> 验证: 告警列表 + 告警详情 + 确认操作
      │
Step 10: Agent 对话交互
  └─> 验证: Agent Chat UI + 结构化卡片 + 流式输出效果
      │
Step 11: 地图 + Twin 视图集成
  └─> 验证: 地图显示 + 车辆 Overlay + Flutter 控件叠加
      │
Step 12: 巡检 + 审批模块 + 场景串联
  └─> 验证: 完整 Demo 场景闭环可走通
```

---

## 详细步骤定义

---

### Step 1: Monorepo 搭建 + 三端 Hello World

**目标**：搭建 Melos monorepo 骨架，创建三个入口 App（车载/平板/手机），每个都能独立启动显示 Hello World。

**前置条件**：Flutter SDK 3.x 已安装，melos 已激活。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 1.1 | `flutter create` 创建 `cat_app` 根项目（作为 workspace） | 根项目骨架 |
| 1.2 | 在 `apps/` 下分别 `flutter create` 三个子项目：`cat_vehicle`、`cat_tablet`、`cat_phone` | 三个独立 Flutter App |
| 1.3 | 在 `packages/` 下创建共享包骨架：`cat_core`、`cat_design_system`、`cat_data`、`cat_domain`、`cat_features`、`cat_native` | 六个空包 |
| 1.4 | 根目录配置 `melos.yaml`，声明所有包及依赖链接 | Melos 配置 |
| 1.5 | 全局 `analysis_options.yaml` 统一 Lint 规则 | Lint 配置 |
| 1.6 | `melos bootstrap` 安装所有依赖 | 依赖就绪 |
| 1.7 | 修改三个 App 的 `main.dart`，显示差异化 Hello World（车载显示横屏暗色文字、平板显示居中标题、手机显示竖屏文字） | 可运行的三端入口 |
| 1.8 | 编写 `scripts/` 下的构建脚本 | 构建脚本 |

**编译验证**：

```bash
# 车载端 (Chrome 横屏模拟 12 寸大屏)
cd apps/cat_vehicle && flutter run -d chrome

# 平板端 (Chrome 可拖拽窗口模拟横竖屏切换)
cd apps/cat_tablet && flutter run -d chrome

# 手机端 (Chrome 窄窗口模拟竖屏)
cd apps/cat_phone && flutter run -d chrome
```

> **注意**：当前开发环境仅有 macOS Desktop 和 Chrome 两个 device。macOS Desktop 需要完整 Xcode（当前未安装），Linux device 在 macOS 上不可用。因此三端统一使用 Chrome 模拟，通过调整窗口尺寸模拟不同终端形态。

**预览效果**：
- 车载：横屏窗口，深色背景，大字 "CUSTOM Vehicle Terminal"
- 平板：可调整大小窗口，居中显示 "CUSTOM Tablet Console"  
- 手机：竖屏窄窗口，显示 "CUSTOM Phone Dashboard"

**交付物检查清单**：
- [ ] `melos.yaml` 配置正确
- [ ] `melos list` 能看到所有包
- [ ] 三个 App 各自 `flutter run` 不报错
- [ ] 三个 App 显示各自不同的 Hello World 文字

---

### Step 2: Design System + 主题系统

**目标**：搭建 `cat_design_system` 包，定义三套主题（车载暗色、平板亮色、手机亮色），并创建原子组件库，在平板端展示组件预览页。

**前置条件**：Step 1 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 2.1 | 在 `cat_design_system` 中定义颜色/间距/字号 Design Token | `tokens/` |
| 2.2 | 定义三套 `ThemeData`：`vehicleTheme`（高对比度暗色）、`tabletTheme`（标准亮色）、`phoneTheme`（紧凑亮色） | `theme/` |
| 2.3 | 创建原子组件：`CatButton`、`CatCard`、`CatBadge`、`CatAppBar`、`CatBottomBar` | `components/` |
| 2.4 | 创建自适应布局组件：`AdaptiveLayout`、`ResponsivePadding`、`DeviceClassProvider` | `layout/` |
| 2.5 | 在平板 App 中创建 `/design-preview` 路由，展示所有组件 | 组件预览页 |
| 2.6 | 三个 App 各自接入对应主题 | 三端差异化主题生效 |

**编译验证**：

```bash
cd apps/cat_tablet && flutter run -d chrome
# 导航到 /design-preview 查看组件预览页
```

**预览效果**：
- 组件预览页展示所有原子组件（按钮、卡片、徽章等）的多种状态
- 三端启动时应用不同主题：车载深色高对比度、平板/手机标准亮色

**交付物检查清单**：
- [ ] Design Token 定义完整
- [ ] 三套 ThemeData 可切换
- [ ] 至少 5 个原子组件可正常渲染
- [ ] 组件预览页可滚动查看所有组件
- [ ] 三端主题差异肉眼可见

---

### Step 3: 三端自适应 Shell + 路由框架

**目标**：为三端实现各自的 App Shell 布局，集成 GoRouter 路由框架，实现跨页面导航。

**前置条件**：Step 2 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 3.1 | 在 `cat_core` 中搭建 GoRouter 路由表（所有路由定义） | 路由骨架 |
| 3.2 | 创建 `VehicleShell`：全屏地图容器 + 左侧驾驶员专属侧边栏（5 项核心功能）+ 底部状态栏，始终横屏 | 车载 Shell |
| 3.3 | 创建 `TabletShell`：Master-Detail 双栏（横屏）/ 单栏 + BottomNav（竖屏） | 平板 Shell |
| 3.4 | 创建 `PhoneShell`：单栏 + BottomNavigationBar | 手机 Shell |
| 3.5 | 创建占位页面（Dashboard、Fleet、Mission、Alert、Map、Agent 各一个占位 Page，共 16 个占位页） | 占位页面 |
| 3.6 | 实现路由守卫（Redirect 逻辑按终端类型限制路由 — 车载端仅 5 条业务路由） | 路由守卫 |
| 3.7 | 在平板端添加分屏/窗口大小变化时的布局切换动画 | 自适应过渡动画 |
| 3.8 | 在车载 Shell 添加物理按键模拟（键盘 Esc/Enter/F1-F5 映射） | 按键映射 |

**编译验证**：

```bash
# 三端各自运行，点击 BottomNav / 侧边栏切换页面
cd apps/cat_vehicle && flutter run -d chrome
cd apps/cat_tablet && flutter run -d chrome
cd apps/cat_phone && flutter run -d chrome
```

**预览效果**：
- 车载：左侧侧边栏 + 右侧内容区，点击侧边栏切换占位页面，始终横屏
- 平板：窗口拉宽显示双栏，拉窄自动切换单栏 + 底部导航
- 手机：底部 4 个 Tab 切换占位页面

**交付物检查清单**：
- [ ] GoRouter 路由 `/dashboard` `/fleet` `/missions` `/alerts` `/map` `/agent` 均可访问
- [ ] 三端 Shell 布局正确
- [ ] 平板窗口 resize 时布局正确切换
- [ ] 车载按键映射生效
- [ ] 无路由跳转报错

---

### Step 4: 领域层 + 数据模型

**目标**：定义核心业务实体、Repository 接口、UseCase，创建 Mock 数据，让 Dashboard 渲染静态数据。

**前置条件**：Step 3 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 4.1 | 在 `cat_domain` 定义核心 Entity：`Vehicle`、`Mission`、`Alert`、`Device`、`AgentMessage`（使用 freezed） | 领域实体 |
| 4.2 | 定义 Repository 抽象接口：`FleetRepository`、`MissionRepository`、`AlertRepository` | Repository 接口 |
| 4.3 | 定义 UseCase 抽象：`StartMission`、`AcknowledgeAlert`、`SendAgentCommand` | UseCase |
| 4.4 | 创建 Mock Repository 实现，返回硬编码静态数据 | Mock 实现 |
| 4.5 | 在 `cat_core` 中搭建 GetIt DI 容器，注册 Mock 实现 | DI 容器 |
| 4.6 | 实现 `DashboardPage`：展示设备总数、在线车辆数、进行中任务数、今日告警数（静态数据） | Dashboard 页面 |
| 4.7 | 使用 Riverpod 创建 `dashboardStatsProvider` | 状态管理 |

**编译验证**：

```bash
cd apps/cat_phone && flutter run -d chrome
# 首页 Dashboard 展示静态统计数据
```

**预览效果**：
- Dashboard 显示 4 个统计卡片：设备总数 128、在线车辆 96、进行中任务 23、今日告警 7
- 卡片数字带入场动画

**交付物检查清单**：
- [ ] freezed 模型生成无报错
- [ ] GetIt DI 容器正确注册
- [ ] Dashboard 4 个统计卡片渲染正确
- [ ] Riverpod Provider 正常工作

---

### Step 5: 数据层 — REST API + Drift 本地存储

**目标**：搭建完整数据层，包括 Drift 数据库建表、Dio HTTP Client、Mock API 拦截器，实现离线优先的数据访问策略。

**前置条件**：Step 4 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 5.1 | 在 `cat_data` 中用 Drift 定义数据表：`vehicles`、`missions`、`alerts`、`devices` | Drift 表定义 |
| 5.2 | 生成 Drift DAO：增删改查方法 | DAO 代码 |
| 5.3 | 搭建 Dio HTTP Client + 拦截器链（日志、Mock、错误处理） | 网络层 |
| 5.4 | 实现 Mock 拦截器：拦截 REST 请求返回模拟 JSON 数据 | Mock API |
| 5.5 | 创建 Repository 实现类：`FleetRepoImpl`、`MissionRepoImpl`、`AlertRepoImpl` | Repository 实现 |
| 5.6 | 在 Repository 中实现 "本地优先" 策略：先返回缓存，后台刷新 | 离线优先逻辑 |
| 5.7 | 更新 GetIt DI，将 Fake 实现替换为真实 Repository | DI 更新 |
| 5.8 | 更新 Dashboard，用真实数据流渲染 | Dashboard 数据化 |

**编译验证**：

```bash
cd apps/cat_phone && flutter run -d chrome
# Dashboard 数据来自 Drift + Mock API
```

**预览效果**：
- Dashboard 数字来自数据库
- 首次加载显示 Mock API 返回的数据
- 刷新页面后从缓存加载（证明 Drift 持久化生效）

**交付物检查清单**：
- [ ] Drift 建表 migration 正确执行
- [ ] Mock API 拦截器正确返回数据
- [ ] 数据从 API → Drift → Provider → UI 完整链路跑通
- [ ] 二次启动时数据来自本地缓存

---

### Step 6: 数据层 — WebSocket 实时通道 + 离线队列

**目标**：集成 WebSocket 实时通信（Mock 实现），实现网络状态监测和离线操作队列。

**前置条件**：Step 5 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 6.1 | 实现 Mock WebSocket 服务：定时推送模拟车辆状态变更、告警消息 | Mock WS |
| 6.2 | 实现 `WsChannel` 封装：连接管理、自动重连、心跳 | WS 通道 |
| 6.3 | 实现 `ConnectivityService`：网络状态监测（基于 `connectivity_plus`） | 网络监测 |
| 6.4 | 实现 `SyncQueue`：基于 Drift 的离线操作队列表 | 离线队列 |
| 6.5 | 实现 `SyncEngine`：网络恢复后批量执行队列操作 | 同步引擎 |
| 6.6 | 创建离线状态 Badge 组件，网络断开时显示 | 离线 UI |
| 6.7 | 在 Dashboard 添加实时车辆状态列表（WebSocket 驱动刷新） | 实时列表 |

**编译验证**：

```bash
cd apps/cat_phone && flutter run -d chrome
# 观察车辆状态列表实时刷新
# 断网后显示离线 Badge，数据仍可查看
# 恢复网络后自动同步
```

**预览效果**：
- Dashboard 底部显示 5 辆车辆实时状态卡片，数据自动刷新
- 断网（飞行模式）后顶部出现橙色 "离线模式" Badge
- 数据仍然可查看（来自 Drift 缓存）
- 恢复网络后 Badge 消失，数据自动同步

**交付物检查清单**：
- [ ] WebSocket Mock 定时推送正常工作
- [ ] 车辆状态实时刷新可见
- [ ] 离线 Badge 正确显示/隐藏
- [ ] SyncQueue 操作可在 DevTools 中查看

---

### Step 7: 车队设备管理模块

**目标**：实现完整的 Fleet 模块（设备列表 + 详情），展示三端 Adaptive 布局差异。

**前置条件**：Step 6 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 7.1 | 创建 `FleetListPage`：设备卡片网格（平板）/ 列表（手机） | 设备列表页 |
| 7.2 | 创建 `FleetDetailPage`：设备详情（状态、位置、任务历史） | 设备详情页 |
| 7.3 | 创建 `VehicleStatusBadge`：在线/离线/告警状态指示器 | 状态组件 |
| 7.4 | 创建 `VehicleCard`：设备信息卡片（可复用） | 卡片组件 |
| 7.5 | 实现搜索/筛选功能（按状态、类型筛选） | 搜索筛选 |
| 7.6 | 在 Fleet 页面中嵌入实时数据流 | 数据集成 |
| 7.7 | 在三端分别验证布局适配 | 三端验证 |

**编译验证**：

```bash
cd apps/cat_tablet && flutter run -d chrome
# 导航到 /fleet，查看设备列表
# 拉宽窗口看网格布局，拉窄看列表布局
# 点击设备进入详情页
```

**预览效果**：
- 平板横屏：设备卡片 3 列网格布局，左侧筛选栏
- 平板竖屏：设备卡片 2 列网格
- 手机：单列列表布局 + 顶部搜索框
- 设备详情页展示完整信息

**交付物检查清单**：
- [ ] 设备列表正确渲染
- [ ] 搜索筛选功能正常
- [ ] 三端布局自适应
- [ ] 详情页返回不报错

---

### Step 8: 任务管理模块

**目标**：实现 Mission 模块，展示任务全生命周期（下发→接受→执行→完成），演示实时状态同步。

**前置条件**：Step 7 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 8.1 | 创建 `MissionListPage`：任务列表（按状态分组） | 任务列表页 |
| 8.2 | 创建 `MissionDetailPage`：任务详情 + 操作按钮（接受/拒绝/完成） | 任务详情页 |
| 8.3 | 创建 `MissionTimeline`：任务状态时间线组件 | 时间线组件 |
| 8.4 | 创建 `MissionCard`：任务摘要卡片 | 任务卡片 |
| 8.5 | 实现任务状态流转逻辑（Provider + UseCase） | 状态流转 |
| 8.6 | 实现任务操作的离线队列支持 | 离线操作 |
| 8.7 | 在车载端实现「新任务弹窗 + TTS 播报」效果（驾驶员只看自己的任务） | 车载任务通知 |
| 8.8 | 实现任务与车辆的关联展示 | 关联展示 |

**编译验证**：

```bash
cd apps/cat_vehicle && flutter run -d chrome
# 车载端：模拟接收新任务 → 弹窗提醒 → 接受任务 → 更新状态
```

**预览效果**：
- 任务列表按「待接受/进行中/已完成」分组
- 任务详情展示完整时间线
- 接受任务后状态实时更新（WebSocket 推送）
- 车载端新任务弹窗 + TTS 语音播报（模拟）

**交付物检查清单**：
- [ ] 任务列表分组正确
- [ ] 任务状态流转完整
- [ ] 任务操作支持离线队列
- [ ] 车载端弹窗通知正确

---

### Step 9: 告警中心模块

**目标**：实现 Alert 模块，展示告警触发→确认→处置的完整流程，这是后续 Agent 交互的前置场景。

**前置条件**：Step 8 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 9.1 | 创建 `AlertListPage`：告警列表（按严重程度分色） | 告警列表页 |
| 9.2 | 创建 `AlertDetailPage`：告警详情 + 处置按钮 | 告警详情页 |
| 9.3 | 创建 `AlertBadge`：顶部导航栏告警计数徽章 | 告警徽章 |
| 9.4 | 创建 `AlertSeverityIndicator`：严重程度指示器（Critical/Warning/Info） | 严重度组件 |
| 9.5 | 实现告警确认逻辑（`AcknowledgeAlert` UseCase） | 确认逻辑 |
| 9.6 | Mock 定时生成新告警（WebSocket 推送） | 告警模拟 |
| 9.7 | 在车载端实现全屏告警弹窗（最高优先级中断，驾驶员确认当前车辆告警） | 全屏告警 |

**编译验证**：

```bash
cd apps/cat_vehicle && flutter run -d chrome
# 等待 Mock 推送告警 → 全屏弹窗 → 点击确认 → 告警列表已更新
```

**预览效果**：
- 告警列表红/橙/蓝三色分级
- 新告警实时推送，顶部徽章数字自动更新
- 车载端全屏告警弹窗（模拟紧急停车场景）
- 确认后告警状态变为「已确认」

**交付物检查清单**：
- [ ] 告警分级颜色正确
- [ ] 实时推送 + 徽章计数正常
- [ ] 确认逻辑跑通
- [ ] 车载全屏告警弹窗正确

---

### Step 10: Agent 对话交互

**目标**：实现 Agent Chat UI，支持结构化卡片渲染、流式输出打字机效果、操作确认工作流。

**前置条件**：Step 9 完成（Agent 需要告警场景触发）。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 10.1 | 创建 `AgentChatPage`：对话界面（气泡列表 + 输入框） | 对话页面 |
| 10.2 | 创建 `AgentMessageBubble`：消息气泡（支持文本 + 内嵌卡片） | 消息气泡 |
| 10.3 | 创建结构化卡片组件：`AlertCard`、`ConfirmCard`、`InfoCard`、`ActionCard` | 卡片组件 |
| 10.4 | 实现卡片 JSON 协议解析 → Widget 映射 | 协议解析 |
| 10.5 | 实现流式输出打字机效果（逐字显示 + 光标闪烁） | 流式输出 |
| 10.6 | 实现 `SendAgentCommand` UseCase + 操作确认流程 | 命令交互 |
| 10.7 | Mock Agent 场景：告警自动触发 Agent 建议 | Mock 场景 |
| 10.8 | 实现 Agent 操作失败的回滚提示 | 失败处理 |
| 10.9 | 创建 Agent Overlay 模式（从任意页面唤起） | Overlay 模式 |

**编译验证**：

```bash
cd apps/cat_tablet && flutter run -d chrome
# 场景：告警触发 → Agent 自动分析 → 建议暂停车辆 → 用户确认 → 执行结果
```

**预览效果**：
- Agent 对话界面，消息气泡支持文本 + 内嵌交互卡片
- 打字机效果逐字输出
- 告警自动触发 Agent 建议（如："检测到 3 号矿卡发动机温度异常 (142°C)，建议暂停作业"）
- 卡片内 [暂停作业] [忽略] [详情] 三个按钮可交互
- 确认操作后有结果反馈

**交付物检查清单**：
- [ ] 对话界面正确渲染
- [ ] 结构化卡片解析正确
- [ ] 流式输出动画流畅
- [ ] 操作确认流程完整
- [ ] Agent Overlay 可从任意页面唤起

---

### Step 11: 地图 + Twin 视图集成

**目标**：集成 flutter_map，显示矿区地图，叠加车辆位置标记、路线和告警气泡。

**前置条件**：Step 10 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 11.1 | 集成 `flutter_map` + OpenStreetMap Tile（或自定义离线瓦片） | 地图组件 |
| 11.2 | 创建 `MineMapWidget`：矿区地图基础组件 | 地图组件 |
| 11.3 | 创建 `VehicleMarker`：车辆位置标记（带方向、状态颜色） | 车辆标记 |
| 11.4 | 创建 `AlertOverlay`：地图上的告警气泡浮层 | 告警浮层 |
| 11.5 | 创建 `RouteLine`：任务路线绘制（CustomPainter） | 路线绘制 |
| 11.6 | 实现地图上的车辆实时位置更新（WebSocket 驱动） | 实时位置 |
| 11.7 | 实现地图与 Fleet 列表的双向联动（点列表→地图聚焦，点地图→列表高亮） | 双向联动 |
| 11.8 | 在车载端实现全屏地图模式 | 全屏地图 |
| 11.9 | 实现地图上点击车辆弹出详情卡片 | 点击交互 |

**编译验证**：

```bash
cd apps/cat_vehicle && flutter run -d chrome
# 全屏地图 + 车辆标记 + 实时位置更新
```

**预览效果**：
- 地图显示矿区范围，5 辆矿卡实时位置标记
- 车辆标记带方向箭头和状态颜色（绿=在线，黄=告警，红=离线）
- 告警车辆上方有红色气泡
- 点击车辆弹出简略信息卡片
- 车载端全屏地图模式，左侧叠加任务面板

**交付物检查清单**：
- [ ] 地图正常加载瓦片
- [ ] 车辆标记实时更新位置
- [ ] 告警气泡正确显示
- [ ] 点击交互正常
- [ ] 车载全屏地图模式正常

---

### Step 12: 巡检 + 审批 + 场景串联闭环

**目标**：补充巡检和审批模块，串联完整 Demo 场景闭环。

**前置条件**：Step 11 完成。

**具体操作**：

| # | 操作 | 产出 |
|---|------|------|
| 12.1 | 创建 `PatrolPage`：巡检列表 + 巡检点打卡 | 巡检模块 |
| 12.2 | 创建 `ApprovalListPage`：审批列表 + 审批详情 | 审批模块 |
| 12.3 | 实现审批操作按钮（通过/驳回/转交） | 审批操作 |
| 12.4 | 创建 `NotificationCenter`：消息通知中心（汇总页面） | 通知中心 |
| 12.5 | 串联完整 Demo 场景：下发任务 → 矿卡接受 → 异常告警 → Agent 建议 → 巡检确认 → 任务完成（各终端按角色视角参与） | 场景串联 |
| 12.6 | 在手机端优化 Dashboard 运营概览看板 | 运营看板 |
| 12.7 | 确保三端所有路由可正常导航（车载端 5 条业务路由 / 平板端 10 条 / 手机端 6 个 Tab） | 全路由验证 |
| 12.8 | 整体编译检查 + 静态分析 + 格式化 | 代码质量 |

**编译验证**：

```bash
# 三端分别编译验证
cd apps/cat_vehicle && flutter run -d chrome
cd apps/cat_tablet && flutter run -d chrome
cd apps/cat_phone && flutter run -d chrome

# 代码质量检查
melos run analyze
melos run format
```

**预览效果**：
- 完整场景闭环可在 3 分钟内走完
- 三端各角色视角完整
- 巡检、审批模块功能可用
- 通知中心汇总所有消息

**交付物检查清单**：
- [ ] 巡检打卡流程可用
- [ ] 审批通过/驳回操作可用
- [ ] 通知中心汇总正确
- [ ] 三端无路由报错
- [ ] `flutter analyze` 无 error

---

## 工作流控制规则

### 每步执行流程

```
用户确认开始 Step N
    │
    ▼
创建新分支: step/N-description
    │
    ▼
按操作列表逐步执行
    │
    ▼
编译验证 (flutter run)
    │
    ▼
预览效果确认
    │
    ▼
用户确认 Step N 完成
    │
    ▼
git commit (带 step 标签)
    │
    ▼
等待用户指令进入 Step N+1
```

### 步骤间暂停规则

1. **每一步完成后必须等待用户确认**，不得自动进入下一步
2. 编译验证时，提供启动命令和预期效果描述
3. 如果编译失败，在当前步骤内修复，不进入下一步
4. 用户可随时要求回退到任意已完成的步骤

### 分支命名规范

```
step/01-monorepo-hello-world
step/02-design-system-theme
step/03-shell-routing
step/04-domain-models
step/05-data-rest-drift
step/06-data-websocket-offline
step/07-fleet-module
step/08-mission-module
step/09-alert-module
step/10-agent-chat
step/11-map-twin
step/12-patrol-approval-integration
```

### Git 提交规范

```
feat(step-01): monorepo 搭建 + 三端 Hello World

- 创建 Melos monorepo 结构
- 三端 App 可独立运行
- 差异化 Hello World 展示

Ref: demo-workflow.md#step-1
```

---

## 快速启动（Step 0 — 环境检查）

在进入 Step 1 之前，先执行环境检查：

```bash
# 检查 Flutter 版本
flutter --version

# 检查 Dart 版本  
dart --version

# 激活 Melos
dart pub global activate melos

# 确认 melos 可用
melos --version
```

---

## 附录：关键决策记录

| 决策 | 原因 |
|------|------|
| 每步都必须可编译运行 | 防止积累大量错误后期难以排查 |
| 先做数据模型再做 UI | UI 依赖数据流，数据流先行可减少返工 |
| Mock 数据优先于真实后端 | Demo 无需真实后端，Mock 足以展示能力 |
| 车载端优先横屏桌面模拟 | Linux embedder 环境搭建复杂，桌面模拟降低门槛 |
| 使用 Melos monorepo | 架构文档指定，且适合多包管理 |