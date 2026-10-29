import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';

/// 矿山设备实体
///
/// 表示矿区内的非车辆设备，如传感器、摄像头、通信基站等。
@freezed
class Device with _$Device {
  const factory Device({
    required String id,           // 设备唯一标识
    required String name,         // 设备名称
    required String type,         // 设备类型：sensor / camera / base_station / gateway
    required String status,       // 设备状态：online / offline / maintenance
    required double latitude,     // 部署纬度（可选地图定位）
    required double longitude,    // 部署经度
    required DateTime lastSeen,   // 最后在线时间
    double? battery,              // 电池电量百分比 (0-100)，有电池的设备
    String? location,             // 部署位置描述
  }) = _Device;
}