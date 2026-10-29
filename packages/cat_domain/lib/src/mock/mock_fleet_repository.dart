import '../entities/vehicle.dart';
import '../entities/device.dart';
import '../repositories/fleet_repository.dart';

/// 车队仓库的 Mock 实现
///
/// 返回硬编码的静态数据，用于 Demo 在数据层就绪前验证 UI 和数据流。
class MockFleetRepository implements FleetRepository {
  /// 模拟车辆数据 — 8 台车辆，6 在线 2 离线
  final List<Vehicle> _vehicles = [
    Vehicle(
      id: 'v-001', name: 'CUSTOM-001', type: 'mining_truck',
      latitude: 39.9042, longitude: 116.4074, altitude: 45.0,
      speed: 23.5, fuel: 78.0, online: true, status: 'moving',
      lastUpdated: DateTime.now().subtract(const Duration(seconds: 15)),
    ),
    Vehicle(
      id: 'v-002', name: 'CUSTOM-002', type: 'mining_truck',
      latitude: 39.9082, longitude: 116.4124, altitude: 42.0,
      speed: 15.0, fuel: 62.0, online: true, status: 'loading',
      lastUpdated: DateTime.now().subtract(const Duration(seconds: 30)),
    ),
    Vehicle(
      id: 'v-003', name: 'CUSTOM-003', type: 'excavator',
      latitude: 39.9192, longitude: 116.3924, altitude: 50.0,
      speed: 0.0, fuel: 85.0, online: true, status: 'idle',
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    Vehicle(
      id: 'v-004', name: 'CUSTOM-004', type: 'bulldozer',
      latitude: 39.8972, longitude: 116.3874, altitude: 55.0,
      speed: 5.0, fuel: 91.0, online: true, status: 'moving',
      lastUpdated: DateTime.now().subtract(const Duration(seconds: 45)),
    ),
    Vehicle(
      id: 'v-005', name: 'CUSTOM-005', type: 'mining_truck',
      latitude: 39.9152, longitude: 116.4274, altitude: 48.0,
      speed: 28.0, fuel: 45.0, online: true, status: 'dumping',
      lastUpdated: DateTime.now().subtract(const Duration(seconds: 10)),
    ),
    Vehicle(
      id: 'v-006', name: 'CUSTOM-006', type: 'mining_truck',
      latitude: 39.9122, longitude: 116.4304, altitude: 47.0,
      speed: 18.0, fuel: 55.0, online: true, status: 'moving',
      lastUpdated: DateTime.now().subtract(const Duration(seconds: 20)),
    ),
    Vehicle(
      id: 'v-007', name: 'CUSTOM-007', type: 'excavator',
      latitude: 39.8992, longitude: 116.4024, altitude: 51.0,
      speed: 0.0, fuel: 22.0, online: false, status: 'idle',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Vehicle(
      id: 'v-008', name: 'CUSTOM-008', type: 'mining_truck',
      latitude: 39.9062, longitude: 116.4184, altitude: 44.0,
      speed: 0.0, fuel: 10.0, online: false, status: 'idle',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  /// 模拟设备数据 — 120 台设备（传感器、摄像头等）
  final List<Device> _devices = List.generate(120, (i) => Device(
    id: 'dev-${(i + 1).toString().padLeft(3, '0')}',
    name: '传感器-${i + 1}',
    type: i < 40 ? 'sensor' : (i < 80 ? 'camera' : 'gateway'),
    status: i < 110 ? 'online' : 'offline',
    latitude: 39.90 + (i * 0.001),
    longitude: 116.40 + (i * 0.001),
    lastSeen: i < 110 ? DateTime.now().subtract(const Duration(minutes: 5)) : DateTime.now().subtract(const Duration(days: 1)),
    battery: i < 60 ? 50.0 + (i % 50).toDouble() : null,
    location: '矿区 A-${i ~/ 10 + 1}',
  ));

  @override
  Future<List<Vehicle>> getVehicles() async {
    await Future.delayed(const Duration(milliseconds: 200)); // 模拟网络延迟
    return _vehicles;
  }

  @override
  Future<Vehicle?> getVehicleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _vehicles.cast<Vehicle?>().firstWhere(
      (v) => v?.id == id,
      orElse: () => null,
    );
  }

  @override
  Future<List<Device>> getDevices() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _devices;
  }

  @override
  Future<int> getOnlineVehicleCount() async {
    final vehicles = await getVehicles();
    return vehicles.where((v) => v.online).length;
  }

  @override
  Future<int> getTotalDeviceCount() async {
    final vehicles = await getVehicles();
    final devices = await getDevices();
    return vehicles.length + devices.length; // 8 + 120 = 128
  }
}