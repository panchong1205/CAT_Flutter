import 'package:drift/drift.dart';

/// 告警数据表
///
/// 存储系统告警和事件记录，按严重程度分级。
/// 对应领域层 Alert 实体。
@DataClassName('DriftAlert')
class Alerts extends Table {
  // 告警唯一标识
  TextColumn get id => text()();

  // 告警标题
  TextColumn get title => text()();

  // 告警详细描述
  TextColumn get message => text()();

  // 告警级别：critical / warning / info
  TextColumn get level => text()();

  // 告警来源：vehicle / device / system
  TextColumn get source => text()();

  // 关联车辆/设备 ID（可选）
  TextColumn get vehicleId => text().nullable()();

  // 是否已确认
  BoolColumn get acknowledged => boolean()();

  // 告警创建时间戳（毫秒 since epoch）
  IntColumn get createdAt => integer()();

  // 确认时间戳，null 表示尚未确认
  IntColumn get acknowledgedAt => integer().nullable()();

  // 确认人姓名
  TextColumn get acknowledgedBy => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}