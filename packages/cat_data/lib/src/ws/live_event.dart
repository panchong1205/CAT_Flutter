/// WebSocket 实时事件数据模型
///
/// 定义所有通过实时通道（WebSocket / Mock）推送的事件类型。
/// 统一从 Mock 服务或真实 WebSocket 发出的数据格式。
class LiveEvent {
  /// 事件类型：vehicle_update / alert_new / alert_acknowledged
  final String type;

  /// 事件携带的数据负载（JSON Map）
  final Map<String, dynamic> payload;

  /// 事件产生时间戳（毫秒 since epoch）
  final int timestamp;

  const LiveEvent({
    required this.type,
    required this.payload,
    required this.timestamp,
  });

  /// 从 JSON Map 构造
  factory LiveEvent.fromJson(Map<String, dynamic> json) {
    return LiveEvent(
      type: json['type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      timestamp: json['timestamp'] as int,
    );
  }

  /// 转为 JSON Map
  Map<String, dynamic> toJson() => {
        'type': type,
        'payload': payload,
        'timestamp': timestamp,
      };

  /// 是否为车辆状态更新事件
  bool get isVehicleUpdate => type == 'vehicle_update';

  /// 是否为告警事件
  bool get isAlertNew => type == 'alert_new';
}

/// 从车辆更新事件中提取车辆实时状态快照
class LiveVehicleSnapshot {
  final String vehicleId;
  final String name;
  final double speed;
  final double fuel;
  final String status;
  final double latitude;
  final double longitude;
  final int timestamp;

  const LiveVehicleSnapshot({
    required this.vehicleId,
    required this.name,
    required this.speed,
    required this.fuel,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory LiveVehicleSnapshot.fromEvent(LiveEvent event) {
    final p = event.payload;
    return LiveVehicleSnapshot(
      vehicleId: p['vehicleId'] as String,
      name: p['name'] as String,
      speed: (p['speed'] as num).toDouble(),
      fuel: (p['fuel'] as num).toDouble(),
      status: p['status'] as String,
      latitude: (p['latitude'] as num).toDouble(),
      longitude: (p['longitude'] as num).toDouble(),
      timestamp: event.timestamp,
    );
  }
}