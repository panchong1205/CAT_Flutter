import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';

/// 矿山车辆实体
///
/// 表示矿区内的一台运输车辆或辅助车辆，包含位置、状态等核心信息。
@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,           // 车辆唯一标识
    required String name,         // 车辆编号 / 名称，如 "CUSTOM-001"
    required String type,         // 车辆类型：mining_truck / excavator / bulldozer
    required double latitude,     // 当前纬度
    required double longitude,    // 当前经度
    required double altitude,     // 当前海拔 (米)
    required double speed,        // 当前速度 (km/h)
    required double fuel,         // 剩余油量百分比 (0-100)
    required bool online,         // 是否在线
    required String status,       // 运行状态：idle / moving / loading / dumping / charging
    required DateTime lastUpdated,// 最后数据更新时间
  }) = _Vehicle;
}