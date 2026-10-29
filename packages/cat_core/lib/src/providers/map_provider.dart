import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_data/cat_data.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 地图选中的车辆 ID
///
/// 点击地图上的车辆标记或 Fleet 列表中的车辆时更新。
/// 用于地图 ↔ 列表双向联动。
final selectedVehicleIdProvider = StateProvider<String?>((ref) => null);

/// 地图选中的车辆详情
///
/// 当 [selectedVehicleIdProvider] 变化时，自动查询对应车辆数据。
final selectedVehicleOnMapProvider = Provider.autoDispose<AsyncValue<Vehicle?>>((ref) {
  final id = ref.watch(selectedVehicleIdProvider);
  if (id == null) return const AsyncData(null);
  return ref.watch(vehicleOnMapProvider(id));
});

/// 按 ID 获取地图上的车辆（组合 Fleet 静态数据 + WebSocket 实时位置）
final vehicleOnMapProvider = FutureProvider.autoDispose.family<Vehicle?, String>((ref, id) {
  return di<FleetRepository>().getVehicleById(id);
});

/// WebSocket 实时车辆位置列表（用于地图标记）
///
/// 订阅 [MockWebSocketService] 推送的 vehicle_update 事件，
/// 返回去重后的车辆实时状态快照列表，同时合并 Fleet 中的静态数据。
final liveVehicleMapProvider = StreamProvider.autoDispose<List<MapVehicleSnapshot>>((ref) {
  final wsService = di<MockWebSocketService>();

  if (!wsService.isConnected) {
    wsService.connect();
  }

  final _snapshots = <String, LiveVehicleSnapshot>{};

  return wsService.eventStream
      .where((e) => e.isVehicleUpdate)
      .map((event) {
        final snapshot = LiveVehicleSnapshot.fromEvent(event);
        _snapshots[snapshot.vehicleId] = snapshot;
        return _snapshots.values
            .map((s) => MapVehicleSnapshot.fromLiveSnapshot(s))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
      });
});

/// 地图上的车辆快照（合并标识 + 位置）
class MapVehicleSnapshot {
  final String vehicleId;
  final String name;
  final double latitude;
  final double longitude;
  final double speed;
  final double fuel;
  final String status;
  final bool online;

  const MapVehicleSnapshot({
    required this.vehicleId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.fuel,
    required this.status,
    required this.online,
  });

  factory MapVehicleSnapshot.fromLiveSnapshot(LiveVehicleSnapshot s) {
    return MapVehicleSnapshot(
      vehicleId: s.vehicleId,
      name: s.name,
      latitude: s.latitude,
      longitude: s.longitude,
      speed: s.speed,
      fuel: s.fuel,
      status: s.status,
      online: s.speed > 0 || s.status != 'idle',
    );
  }
}

/// 车辆状态对应颜色
enum VehicleStatusColor {
  online(0xFF4CAF50),
  warning(0xFFFFC107),
  offline(0xFF9E9E9E),
  critical(0xFFF44336);

  final int value;
  const VehicleStatusColor(this.value);
}

VehicleStatusColor statusColorForVehicle(MapVehicleSnapshot v) {
  if (!v.online) return VehicleStatusColor.offline;
  if (v.fuel < 20) return VehicleStatusColor.critical;
  if (v.fuel < 40) return VehicleStatusColor.warning;
  return VehicleStatusColor.online;
}