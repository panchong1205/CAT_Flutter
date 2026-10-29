/// CAT Data Layer
///
/// 数据层公开 API，包含：
/// - Drift 本地数据库（跨平台：原生文件 / Web 内存）
/// - Dio HTTP 客户端
/// - Mock 拦截器
/// - Repository 实现（离线优先策略）
library cat_data;

// -- Drift 数据库 --
export 'src/drift/app_database.dart';
export 'src/drift/connection/database_connection.dart';

// -- HTTP 客户端 --
export 'src/remote/http_client.dart';
export 'src/remote/mock_interceptor.dart';

// -- Repository 实现 --
export 'src/repositories/fleet_repository_impl.dart';
export 'src/repositories/mission_repository_impl.dart';
export 'src/repositories/alert_repository_impl.dart';
export 'src/repositories/agent_repository_impl.dart';
export 'src/repositories/patrol_repository_impl.dart';
export 'src/repositories/approval_repository_impl.dart';

// -- WebSocket 实时通道 --
export 'src/ws/live_event.dart';
export 'src/ws/mock_ws_service.dart';

// -- Agent 聊天服务 --
export 'src/services/agent_chat_service.dart';

// -- 离线同步 --
export 'src/sync/sync_engine.dart';