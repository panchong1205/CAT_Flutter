import 'package:drift/drift.dart';

/// 运输任务数据表
///
/// 存储矿区内所有运输任务的信息与状态流转记录。
/// 对应领域层 Mission 实体。
@DataClassName('DriftMission')
class Missions extends Table {
  // 任务唯一标识
  TextColumn get id => text()();

  // 任务名称
  TextColumn get name => text()();

  // 指派车辆 ID（外键）
  TextColumn get vehicleId => text()();

  // 任务状态：pending / accepted / in_progress / completed / cancelled
  TextColumn get status => text()();

  // 装载点坐标描述
  TextColumn get loadPoint => text()();

  // 卸载点坐标描述
  TextColumn get unloadPoint => text()();

  // 目标装载量（吨）
  RealColumn get targetLoad => real()();

  // 当前装载量（吨）
  RealColumn get currentLoad => real()();

  // 任务创建时间戳（毫秒 since epoch）
  IntColumn get createdAt => integer()();

  // 任务开始时间戳，null 表示尚未开始
  IntColumn get startedAt => integer().nullable()();

  // 任务完成时间戳，null 表示尚未完成
  IntColumn get completedAt => integer().nullable()();

  // 优先级：normal / high / urgent
  TextColumn get priority => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}