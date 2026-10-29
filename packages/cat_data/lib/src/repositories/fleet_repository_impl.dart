import 'package:cat_domain/cat_domain.dart';
import 'package:drift/drift.dart';
import '../drift/app_database.dart';
import '../drift/mappers/vehicle_mapper.dart';
import '../drift/mappers/device_mapper.dart';
import '../remote/http_client.dart';
import '../remote/api_services/fleet_api_service.dart';

/// 车队/设备仓储实现
///
/// 采用离线优先（Offline-First）策略：
/// 1. 优先返回本地 SQLite 缓存数据
/// 2. 后台异步从 REST API 拉取最新数据
/// 3. 新数据覆盖本地缓存，下次查询自动生效
class FleetRepoImpl implements FleetRepository {
  final AppDatabase _db;
  final CatHttpClient _httpClient;

  FleetRepoImpl({required AppDatabase db, required CatHttpClient httpClient})
      : _db = db,
        _httpClient = httpClient;

  @override
  Future<List<Vehicle>> getVehicles() async {
    // 1. 立即返回缓存数据，避免 UI 等待
    final cached = await _db.getAllVehicles();
    
    // 2. 后台刷新远端数据
    _refreshVehicles();
    
    return cached.map((v) => v.toDomain()).toList();
  }

  @override
  Future<Vehicle?> getVehicleById(String id) async {
    final all = await getVehicles();
    try {
      return all.firstWhere((v) => v.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Device>> getDevices() async {
    // 1. 立即返回缓存
    final cached = await _db.getAllDevices();
    
    // 2. 后台刷新
    _refreshDevices();
    
    return cached.map((d) => d.toDomain()).toList();
  }

  @override
  Future<int> getOnlineVehicleCount() async {
    final count = await _db.getOnlineVehicleCount();
    if (count == 0) {
      await _refreshVehicles();
      return _db.getOnlineVehicleCount();
    }
    return count;
  }

  @override
  Future<int> getTotalDeviceCount() async {
    final count = await _db.getTotalDeviceCount();
    if (count == 0) {
      await _refreshDevices();
      return _db.getTotalDeviceCount();
    }
    return count;
  }

  // ============================================================
  // 后台刷新方法
  // ============================================================

  /// 异步获取远端车辆数据并写入本地数据库
  Future<void> _refreshVehicles() async {
    try {
      final response = await _httpClient.get('/vehicles');
      final List<dynamic> raw = response.data['data'] as List<dynamic>;
      final vehicles = raw.cast<Map<String, dynamic>>().map(vehicleFromJson).toList();

      // 构建 Drift Companions 进行批量 upsert
      final companions = vehicles.map((v) {
        return VehiclesCompanion.insert(
          id: v.id,
          name: v.name,
          type: v.type,
          latitude: v.latitude,
          longitude: v.longitude,
          altitude: v.altitude,
          speed: v.speed,
          fuel: v.fuel,
          online: v.online,
          status: v.status,
          lastUpdated: v.lastUpdated.millisecondsSinceEpoch,
        );
      }).toList();
      await _db.upsertVehicles(companions);
    } catch (_) {
      // 后台刷新失败静默处理，用户仍能看到缓存数据
    }
  }

  /// 异步获取远端设备数据并写入本地数据库
  Future<void> _refreshDevices() async {
    try {
      final response = await _httpClient.get('/devices');
      final List<dynamic> raw = response.data['data'] as List<dynamic>;
      final devices = raw.cast<Map<String, dynamic>>().map(deviceFromJson).toList();

      final companions = devices.map((d) {
        return DevicesCompanion.insert(
          id: d.id,
          name: d.name,
          type: d.type,
          online: d.status == 'online',
          latitude: d.latitude,
          longitude: d.longitude,
          lastSeen: d.lastSeen.millisecondsSinceEpoch,
          battery: Value(d.battery),
          location: Value(d.location),
        );
      }).toList();
      await _db.upsertDevices(companions);
    } catch (_) {
      // 后台刷新失败静默处理
    }
  }
}