import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 车队/设备数据 Provider
///
/// 从 [FleetRepository] 获取所有车辆和设备列表。
/// FleetPage 和 FleetDetailPage 通过此 Provider 订阅数据。

/// 车辆列表 StreamProvider（后台自动刷新）
final fleetVehiclesProvider = FutureProvider.autoDispose<List<Vehicle>>((ref) {
  return di<FleetRepository>().getVehicles();
});

/// 设备列表 StreamProvider
final fleetDevicesProvider = FutureProvider.autoDispose<List<Device>>((ref) {
  return di<FleetRepository>().getDevices();
});

/// 按 ID 获取单辆车辆详情
final vehicleDetailProvider = FutureProvider.autoDispose.family<Vehicle?, String>((ref, id) {
  return di<FleetRepository>().getVehicleById(id);
});