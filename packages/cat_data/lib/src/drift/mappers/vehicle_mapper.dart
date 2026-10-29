import 'package:cat_domain/cat_domain.dart';
import '../app_database.dart';

/// DriftVehicle ↔ Vehicle 领域实体映射扩展
extension DriftVehicleMapper on DriftVehicle {
  /// 将 Drift 数据类转换为领域实体
  Vehicle toDomain() => Vehicle(
        id: id,
        name: name,
        type: type,
        latitude: latitude,
        longitude: longitude,
        altitude: altitude,
        speed: speed,
        fuel: fuel,
        online: online,
        status: status,
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(lastUpdated),
      );
}