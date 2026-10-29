import 'package:drift/drift.dart';

/// 车辆/矿卡数据表
///
/// 存储车队中所有车辆的基本信息与实时状态。
/// 对应领域层 Vehicle 实体。
@DataClassName('DriftVehicle')
class Vehicles extends Table {
  // 车辆唯一标识
  TextColumn get id => text()();

  // 车辆名称/编号（如 "矿卡-001"）
  TextColumn get name => text()();

  // 车辆类型：truck / excavator / dozer / loader
  TextColumn get type => text()();

  // 当前纬度
  RealColumn get latitude => real()();

  // 当前经度
  RealColumn get longitude => real()();

  // 当前海拔（米）
  RealColumn get altitude => real()();

  // 当前速度（km/h）
  RealColumn get speed => real()();

  // 剩余油量百分比 (0-100)
  RealColumn get fuel => real()();

  // 是否在线
  BoolColumn get online => boolean()();

  // 运行状态：idle / moving / loading / dumping / charging
  TextColumn get status => text()();

  // 最后数据更新时间戳（毫秒 since epoch）
  IntColumn get lastUpdated => integer()();

  @override
  Set<Column> get primaryKey => {id};
}