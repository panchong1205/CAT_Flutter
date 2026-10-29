import 'package:drift/drift.dart';

/// 离线操作队列表
///
/// 网络断开期间，所有对服务器的写操作（如确认告警、更新任务状态等）
/// 暂存到此表，网络恢复后由 [SyncEngine] 批量执行。
@DataClassName('DriftSyncQueueItem')
class SyncQueueItems extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 操作类型：acknowledge_alert / start_mission / complete_mission
  TextColumn get operationType => text()();

  /// 操作参数 JSON 字符串
  TextColumn get payload => text()();

  /// 创建时间戳
  DateTimeColumn get createdAt => dateTime()();

  /// 重试次数
  IntColumn get retries => integer().withDefault(const Constant(0))();

  /// 状态：pending / processing / done / failed
  TextColumn get status => text().withDefault(const Constant('pending'))();
}