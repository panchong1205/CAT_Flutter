import '../entities/vehicle.dart';
import '../entities/device.dart';

/// 车队/设备仓储抽象接口
///
/// 定义车队和设备数据的访问契约，具体实现由数据层提供。
abstract class FleetRepository {
  /// 获取所有车辆列表
  Future<List<Vehicle>> getVehicles();

  /// 获取单个车辆详情
  Future<Vehicle?> getVehicleById(String id);

  /// 获取所有设备列表
  Future<List<Device>> getDevices();

  /// 获取在线车辆数量
  Future<int> getOnlineVehicleCount();

  /// 获取设备总数（含车辆和设备）
  Future<int> getTotalDeviceCount();
}