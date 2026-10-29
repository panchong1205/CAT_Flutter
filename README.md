# CUSTOM — 无人矿山生产管控终端

> **C**ommand & **A**wareness **T**erminal  
> 基于 Flutter 的跨端矿山生产实时管控 Demo —— 车载端 / 平板端 / 手机端

---

## 项目简介

本 Demo 模拟无人矿山生产管控核心业务场景：从调度中心下发任务 → 矿卡接受执行 → 异常触发告警 → Agent 推送处理建议 → 现场巡检打卡 → 维修审批流转 → 任务完成归档的完整闭环。

支持三端运行（车载大屏 / 平板中屏 / 手机小屏），适配不同的操作场景和屏幕尺寸。

---

## 技术栈

| 分类 | 技术 |
|------|------|
| **框架** | Flutter 3.41+ / Dart 3.11+ |
| **状态管理** | Riverpod 2.x |
| **路由** | GoRouter 14.x（三端自适应 ShellRoute） |
| **依赖注入** | get_it + injectable |
| **本地存储** | Drift 2.x（SQLite ORM） |
| **网络层** | Dio 5.x + Mock 拦截器 |
| **实时通信** | WebSocket（web_socket_channel） |
| **地图** | flutter_map 7.x + latlong2（OpenStreetMap） |
| **代码生成** | freezed + build_runner + injectable_generator |
| **工程化** | Melos Monorepo |

---

## 项目架构

```
CAT_Flutter/
├── apps/                         # 三端入口（极薄，仅 main.dart + 平台配置）
│   ├── cat_vehicle/              # 车载端 (横屏 12 寸大屏)
│   ├── cat_tablet/               # 平板端 (中屏)
│   └── cat_phone/                # 手机端 (竖屏窄屏)
├── packages/                     # 共享包（Clean Architecture 分层）
│   ├── cat_domain/               # 领域层：实体定义、仓储接口、Mock 数据
│   ├── cat_data/                 # 数据层：Drift 数据库、Dio HTTP、WebSocket、离线队列
│   ├── cat_core/                 # 核心层：Riverpod Provider、GoRouter、DI、页面/组件
│   └── cat_design_system/        # 设计系统：主题、令牌、原子组件、自适应布局
├── pubspec.yaml                  # 根 workspace + melos 脚本
├── melos.yaml                    # Melos 配置
├── demo-workflow.md              # 分步构建工作流
└── CAT_Flutter-resume.md         # 简历项目经历
```

依赖方向严格单向：`apps → cat_core → cat_data → cat_domain`，`cat_design_system` 为横向支撑。

---

## 功能板块

| 模块 | 说明 | 车载 | 平板 | 手机 |
|------|------|:---:|:---:|:---:|
| **Dashboard** | 生产数据总览看板（在线车辆/活跃任务/待处理告警） | ✅ | ✅ | ✅ |
| **车队管理** | 车辆列表 + 详情（速度/油量/状态/位置），支持实时搜索 | ✅ | ✅ | — |
| **任务管理** | 任务列表 + 新建/接受/执行/完成全生命周期 | ✅ | ✅ | ✅ |
| **告警中心** | 三级严重度（危险/警告/信息），告警详情 + 确认操作 | ✅ | ✅ | ✅ |
| **Agent 对话** | 辅助决策对话系统，流式输出 + 结构化卡片 + 主动推送建议 | ✅ | ✅ | ✅ |
| **矿区地图** | OpenStreetMap 地图 + 车辆实时标记 + 告警气泡 + 全屏模式 | ✅ | ✅ | — |
| **巡检打卡** | 6 个巡检点 + 分类筛选 + 二次确认防误触 | ✅ | ✅ | ✅ |
| **审批管理** | 审批列表 + 详情（通过/驳回/转交 + 审批意见） | ✅ | ✅ | ✅ |
| **通知中心** | 四类消息聚合（告警/任务/审批/巡检）+ 点击跳转目标详情 | ✅ | ✅ | ✅ |

---

## 本地启动

### 前置条件

- Flutter SDK 3.41+（`flutter doctor` 确认环境就绪）
- Melos 已激活：`dart pub global activate melos`

### 初始化

```bash
cd CAT_Flutter

# 安装所有依赖
melos bootstrap

# 运行代码生成（freezed / drift / injectable）
melos run build_runner

# 静态分析验证
melos run analyze
```

### 启动应用（三端均使用 Chrome 模拟）

```bash
# 车载终端 (横屏模拟 12 寸大屏，端口 8081)
melos run run_vehicle

# 平板终端 (端口 8082)
melos run run_tablet

# 手机终端 (竖屏窄屏，端口 8083)
melos run run_phone

# 同时启动三端
melos run run_all
```

启动后在浏览器访问：
- 车载端：http://localhost:8081
- 平板端：http://localhost:8082
- 手机端：http://localhost:8083

> **提示**：三端均依赖 Mock 数据运行，无需后端服务即可体验完整业务流程。

### 其他常用命令

```bash
melos run analyze        # 全仓静态分析
melos run format         # 代码格式化
melos run clean          # 清理所有包
melos run test           # 运行测试
melos run build_runner   # 重新生成代码
```