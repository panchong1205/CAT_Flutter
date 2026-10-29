import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_data/cat_data.dart';
import '../di/di_container.dart';

/// 车辆实时状态快照列表
typedef LiveVehicleSnapshots = List<LiveVehicleSnapshot>;

/// 实时车辆状态 Provider
///
/// 订阅 [MockWebSocketService] 推送的 vehicle_update 事件，
/// 维护一个按 vehicleId 去重的车辆状态快照字典。
/// Dashboard 通过此 Provider 获取实时车辆列表并渲染。
final liveVehicleProvider = StreamProvider<LiveVehicleSnapshots>((ref) {
  final wsService = di<MockWebSocketService>();

  // 如果尚未连接，自动建立连接
  if (!wsService.isConnected) {
    wsService.connect();
  }

  final _snapshots = <String, LiveVehicleSnapshot>{};

  return wsService.eventStream
      .where((event) => event.isVehicleUpdate)
      .map((event) {
        final snapshot = LiveVehicleSnapshot.fromEvent(event);
        _snapshots[snapshot.vehicleId] = snapshot;
        // 返回按 name 排序的快照列表
        final list = _snapshots.values.toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        return list;
      });
});

/// 实时告警事件 Provider
///
/// 仅推送 alert_new 类型事件，AlertPage（Step 9 实现）可订阅此 Provider。
final liveAlertProvider = StreamProvider<LiveEvent>((ref) {
  final wsService = di<MockWebSocketService>();

  if (!wsService.isConnected) {
    wsService.connect();
  }

  return wsService.eventStream.where((event) => event.isAlertNew);
});