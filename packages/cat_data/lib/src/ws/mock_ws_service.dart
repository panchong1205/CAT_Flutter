import 'dart:async';
import 'dart:math';
import 'live_event.dart';

/// Mock WebSocket 服务
///
/// 使用 [Timer] 定时生成模拟车辆状态变更和告警事件，模拟真实 WebSocket 的数据推送行为。
/// 每个周期（默认 3 秒）随机选择若干车辆发送状态更新，并以一定概率生成新的告警事件。
class MockWebSocketService {
  final _controller = StreamController<LiveEvent>.broadcast();
  final _random = Random();
  Timer? _timer;
  bool _isConnected = false;

  /// 车辆基础信息表（用于生成 Mock 更新）
  static const _vehicleNames = {
    'v001': '矿卡-001',
    'v002': '矿卡-002',
    'v003': '矿卡-003',
    'v004': '矿卡-004',
    'v005': '矿卡-005',
  };

  /// 车辆初始坐标
  static const _vehiclePositions = {
    'v001': [39.1234, 117.5678],
    'v002': [39.1256, 117.5710],
    'v003': [39.1278, 117.5734],
    'v004': [39.1210, 117.5650],
    'v005': [39.1290, 117.5750],
  };

  /// 是否已连接（推送活动中）
  bool get isConnected => _isConnected;

  /// 事件流 — 外部订阅此 Stream 获取实时事件
  Stream<LiveEvent> get eventStream => _controller.stream;

  /// 建立连接并开始推送
  void connect({Duration interval = const Duration(seconds: 3)}) {
    if (_isConnected) return;
    _isConnected = true;

    _timer = Timer.periodic(interval, (_) => _pushEvents());
  }

  /// 断开连接并停止推送
  void disconnect() {
    _isConnected = false;
    _timer?.cancel();
    _timer = null;
  }

  /// 释放所有资源
  void dispose() {
    disconnect();
    _controller.close();
  }

  /// 每个周期推送一批事件
  void _pushEvents() {
    if (!_isConnected) return;
    final now = DateTime.now().millisecondsSinceEpoch;

    // 1. 随机选取 1~3 辆车推送状态更新
    final vehicleIds = _vehicleNames.keys.toList()..shuffle(_random);
    final updateCount = 1 + _random.nextInt(3);
    for (int i = 0; i < updateCount; i++) {
      _controller.add(_generateVehicleUpdate(vehicleIds[i], now));
    }

    // 2. 10% 概率生成一条新告警
    if (_random.nextDouble() < 0.1) {
      _controller.add(_generateAlert(now));
    }
  }

  /// 生成一条车辆状态变更事件
  LiveEvent _generateVehicleUpdate(String vehicleId, int now) {
    final name = _vehicleNames[vehicleId]!;
    final basePos = _vehiclePositions[vehicleId]!;
    // 坐标微小随机偏移（±0.001 度 = ±100m）
    final lat = basePos[0] + (_random.nextDouble() - 0.5) * 0.002;
    final lng = basePos[1] + (_random.nextDouble() - 0.5) * 0.002;
    // 速度随机 0~45 km/h
    final speed = _random.nextDouble() * 45;
    // 油量递减 0.1~1.5%
    final fuel = max(0, 100 - _random.nextInt(20) * 1.0).toDouble();
    // 状态按概率分配
    final statuses = ['moving', 'idle', 'loading', 'dumping'];
    final status = statuses[_random.nextInt(statuses.length)];

    return LiveEvent(
      type: 'vehicle_update',
      payload: {
        'vehicleId': vehicleId,
        'name': name,
        'speed': speed,
        'fuel': fuel,
        'status': status,
        'latitude': lat,
        'longitude': lng,
        'online': speed > 0 || _random.nextBool(),
      },
      timestamp: now,
    );
  }

  /// 生成一条模拟告警事件
  LiveEvent _generateAlert(int now) {
    final alertTypes = [
      {'title': '发动机温度过高', 'level': 'critical'},
      {'title': '油量过低警告', 'level': 'warning'},
      {'title': '超速行驶', 'level': 'warning'},
      {'title': '传感器离线', 'level': 'warning'},
      {'title': 'GPS信号弱', 'level': 'info'},
    ];
    final type = alertTypes[_random.nextInt(alertTypes.length)];
    final vehicleIds = _vehicleNames.keys.toList();
    final vid = vehicleIds[_random.nextInt(vehicleIds.length)];

    return LiveEvent(
      type: 'alert_new',
      payload: {
        'id': 'ws_${now}_${_random.nextInt(1000)}',
        'title': type['title'] as String,
        'level': type['level'] as String,
        'message': '${_vehicleNames[vid]} — ${type['title']}（实时推送）',
        'vehicleId': vid,
      },
      timestamp: now,
    );
  }
}