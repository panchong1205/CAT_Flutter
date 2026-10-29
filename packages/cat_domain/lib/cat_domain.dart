/// 无人矿山 CAT 系统 — 领域层
///
/// 包含核心业务实体、Repository 抽象接口、UseCase 和 Mock 实现。
library cat_domain;

export 'src/entities/vehicle.dart';
export 'src/entities/mission.dart';
export 'src/entities/alert.dart';
export 'src/entities/device.dart';
export 'src/entities/agent_message.dart';
export 'src/entities/agent_card.dart';
export 'src/entities/patrol_point.dart';
export 'src/entities/approval_request.dart';
export 'src/entities/notification_message.dart';
export 'src/repositories/fleet_repository.dart';
export 'src/repositories/mission_repository.dart';
export 'src/repositories/alert_repository.dart';
export 'src/repositories/agent_repository.dart';
export 'src/repositories/patrol_repository.dart';
export 'src/repositories/approval_repository.dart';
export 'src/usecases/start_mission.dart';
export 'src/usecases/acknowledge_alert.dart';
export 'src/usecases/send_agent_command.dart';
export 'src/mock/mock_fleet_repository.dart';
export 'src/mock/mock_mission_repository.dart';
export 'src/mock/mock_alert_repository.dart';
export 'src/mock/mock_patrol_repository.dart';
export 'src/mock/mock_approval_repository.dart';