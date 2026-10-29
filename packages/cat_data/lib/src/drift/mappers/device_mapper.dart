import 'package:cat_domain/cat_domain.dart';
import '../app_database.dart';

/// DriftDevice ↔ Device 领域实体映射扩展
extension DriftDeviceMapper on DriftDevice {
  /// 将 Drift 数据类转换为领域实体
  Device toDomain() => Device(
        id: id,
        name: name,
        type: type,
        status: online ? 'online' : 'offline',
        latitude: latitude,
        longitude: longitude,
        lastSeen: DateTime.fromMillisecondsSinceEpoch(lastSeen),
        battery: battery,
        location: location,
      );
}