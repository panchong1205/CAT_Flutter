import 'package:drift/drift.dart';

/// 非车辆设备数据表
///
/// 存储传感器、摄像头、基站等非车辆 IoT 设备信息。
/// 对应领域层 Device 实体。
@DataClassName('DriftDevice')
class Devices extends Table {
  // 设备唯一标识
  TextColumn get id => text()();

  // 设备名称
  TextColumn get name => text()();

  // 设备类型：sensor / camera / base_station / beacon
  TextColumn get type => text()();

  // 是否在线
  BoolColumn get online => boolean()();

  // 部署纬度
  RealColumn get latitude => real()();

  // 部署经度
  RealColumn get longitude => real()();

  // 最后在线时间戳（毫秒 since epoch）
  IntColumn get lastSeen => integer()();

  // 电池电量 (0-100)，有电池的设备，null 表示无电池
  RealColumn get battery => real().nullable()();

  // 部署位置描述
  TextColumn get location => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}