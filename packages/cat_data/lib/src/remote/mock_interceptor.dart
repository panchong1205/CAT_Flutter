import 'package:dio/dio.dart';

/// Mock API 拦截器
///
/// 拦截 Dio 发出的 HTTP 请求，返回模拟的 JSON 数据。
/// 仅在 Demo 阶段使用，正式上线后移除。
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 尝试匹配 Mock 数据
    final mockResponse = _buildMockResponse(options.path);
    if (mockResponse != null) {
      handler.resolve(Response(
        requestOptions: options,
        data: mockResponse,
        statusCode: 200,
      ));
    } else {
      handler.reject(DioException(
        requestOptions: options,
        error: '未找到 Mock 数据: ${options.path}',
        type: DioExceptionType.unknown,
      ));
    }
  }

  /// 根据请求路径返回对应的 Mock JSON 数据
  Map<String, dynamic>? _buildMockResponse(String path) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch;

    switch (path) {
      case '/vehicles':
        return {
          'success': true,
          'data': _mockVehicles(now),
        };

      case '/missions':
        return {
          'success': true,
          'data': _mockMissions(now),
        };

      case '/alerts':
        return {
          'success': true,
          'data': _mockAlerts(now, today),
        };

      case '/devices':
        return {
          'success': true,
          'data': _mockDevices(now),
          'total': 120,
        };

      case '/stats/dashboard':
        return {
          'success': true,
          'data': {
            'totalDevices': 128,    // 8 车辆 + 120 设备
            'onlineVehicles': 6,
            'activeMissions': 23,
            'todayAlerts': 7,
          },
        };

      default:
        return null;
    }
  }

  /// 生成 8 辆矿卡 Mock 数据
  List<Map<String, dynamic>> _mockVehicles(int now) {
    return [
      {'id': 'v001', 'name': '矿卡-001', 'type': 'truck', 'latitude': 39.1234, 'longitude': 117.5678, 'altitude': 45.2, 'speed': 25.0, 'fuel': 78.5, 'online': true, 'status': 'moving', 'lastUpdated': now},
      {'id': 'v002', 'name': '矿卡-002', 'type': 'truck', 'latitude': 39.1256, 'longitude': 117.5710, 'altitude': 48.1, 'speed': 0.0, 'fuel': 45.0, 'online': true, 'status': 'loading', 'lastUpdated': now - 30000},
      {'id': 'v003', 'name': '矿卡-003', 'type': 'truck', 'latitude': 39.1278, 'longitude': 117.5734, 'altitude': 50.5, 'speed': 30.0, 'fuel': 62.0, 'online': true, 'status': 'dumping', 'lastUpdated': now - 15000},
      {'id': 'v004', 'name': '矿卡-004', 'type': 'truck', 'latitude': 39.1210, 'longitude': 117.5650, 'altitude': 42.0, 'speed': 0.0, 'fuel': 15.0, 'online': false, 'status': 'idle', 'lastUpdated': now - 3600000},
      {'id': 'v005', 'name': '矿卡-005', 'type': 'truck', 'latitude': 39.1290, 'longitude': 117.5750, 'altitude': 53.0, 'speed': 28.0, 'fuel': 80.0, 'online': true, 'status': 'moving', 'lastUpdated': now - 10000},
      {'id': 'e001', 'name': '挖掘机-A1', 'type': 'excavator', 'latitude': 39.1240, 'longitude': 117.5690, 'altitude': 44.0, 'speed': 0.0, 'fuel': 55.0, 'online': true, 'status': 'idle', 'lastUpdated': now - 60000},
      {'id': 'e002', 'name': '推土机-B2', 'type': 'dozer', 'latitude': 39.1300, 'longitude': 117.5770, 'altitude': 52.5, 'speed': 0.0, 'fuel': 70.0, 'online': false, 'status': 'idle', 'lastUpdated': now - 7200000},
      {'id': 'l001', 'name': '装载机-C3', 'type': 'loader', 'latitude': 39.1260, 'longitude': 117.5720, 'altitude': 49.0, 'speed': 0.0, 'fuel': 40.0, 'online': true, 'status': 'charging', 'lastUpdated': now - 45000},
    ];
  }

  /// 生成任务 Mock 数据（23 个进行中）
  List<Map<String, dynamic>> _mockMissions(int now) {
    final missions = <Map<String, dynamic>>[];
    for (int i = 1; i <= 38; i++) {
      final isActive = i <= 23;
      missions.add({
        'id': 'm${i.toString().padLeft(3, '0')}',
        'name': '运输任务 #${i}',
        'vehicleId': 'v00${(i % 5) + 1}',
        'status': isActive ? (i <= 5 ? 'pending' : (i <= 15 ? 'accepted' : 'in_progress')) : 'completed',
        'loadPoint': '采区-A${i % 3 + 1}',
        'unloadPoint': '卸料区-B${i % 2 + 1}',
        'targetLoad': 30.0 + (i % 5) * 5,
        'currentLoad': isActive ? (i % 3) * 10.0 : 30.0 + (i % 5) * 5,
        'createdAt': now - (38 - i) * 1800000, // 每个任务间隔 30 分钟
        'startedAt': isActive && i > 5 ? now - (38 - i) * 1200000 : null,
        'completedAt': !isActive ? now - (38 - i) * 600000 : null,
        'priority': i <= 3 ? 'urgent' : (i <= 10 ? 'high' : 'normal'),
      });
    }
    return missions;
  }

  /// 生成告警 Mock 数据（今日 7 条）
  List<Map<String, dynamic>> _mockAlerts(int now, int today) {
    return [
      {'id': 'a001', 'title': '发动机温度过高', 'message': '矿卡-003 发动机温度达到 142°C，超过安全阈值 120°C', 'level': 'critical', 'source': 'vehicle', 'vehicleId': 'v003', 'acknowledged': false, 'createdAt': today + 3600000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a002', 'title': '油量过低警告', 'message': '矿卡-004 油量仅剩 15%，请及时加油', 'level': 'warning', 'source': 'vehicle', 'vehicleId': 'v004', 'acknowledged': false, 'createdAt': today + 5400000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a003', 'title': '传感器离线', 'message': '采区 A2 温湿度传感器失去连接超过 10 分钟', 'level': 'warning', 'source': 'device', 'vehicleId': null, 'acknowledged': true, 'createdAt': today + 7200000, 'acknowledgedAt': today + 7500000, 'acknowledgedBy': '王工'},
      {'id': 'a004', 'title': '边坡位移预警', 'message': '卸料区 B1 边坡位移速率达到 3.5mm/h，建议暂停作业', 'level': 'critical', 'source': 'system', 'vehicleId': null, 'acknowledged': false, 'createdAt': today + 10800000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a005', 'title': '超速行驶', 'message': '矿卡-001 在采区道路超速达 45km/h（限速 30km/h）', 'level': 'warning', 'source': 'vehicle', 'vehicleId': 'v001', 'acknowledged': false, 'createdAt': today + 14400000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a006', 'title': '粉尘浓度超标', 'message': '采区 A1 粉尘浓度 28mg/m³，超过阈值 15mg/m³', 'level': 'info', 'source': 'device', 'vehicleId': null, 'acknowledged': false, 'createdAt': today + 21600000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a007', 'title': '皮带运输机故障', 'message': '卸料区 B2 2号皮带电机电流异常，可能过载', 'level': 'critical', 'source': 'device', 'vehicleId': null, 'acknowledged': false, 'createdAt': today + 25200000, 'acknowledgedAt': null, 'acknowledgedBy': null},
      {'id': 'a008', 'title': '备用发电机启动', 'message': '矿区主电网波动，备用柴油发电机已自动启动', 'level': 'info', 'source': 'system', 'vehicleId': null, 'acknowledged': true, 'createdAt': now - 86400000, 'acknowledgedAt': now - 86300000, 'acknowledgedBy': '李工'},
      {'id': 'a009', 'title': 'GPS信号弱', 'message': '矿卡-002 在采区 C 隧道 GPS 信号丢失，切换到惯性导航', 'level': 'info', 'source': 'vehicle', 'vehicleId': 'v002', 'acknowledged': true, 'createdAt': now - 90000000, 'acknowledgedAt': now - 89000000, 'acknowledgedBy': null},
      {'id': 'a010', 'title': '液压系统压力异常', 'message': '挖掘机-A1 液压回油压力低于正常值 40%', 'level': 'warning', 'source': 'vehicle', 'vehicleId': 'e001', 'acknowledged': false, 'createdAt': now - 36000000, 'acknowledgedAt': null, 'acknowledgedBy': null},
    ];
  }

  /// 生成 120 台设备 Mock 数据摘要
  List<Map<String, dynamic>> _mockDevices(int now) {
    final devices = <Map<String, dynamic>>[];
    for (int i = 1; i <= 120; i++) {
      final typeIndex = i % 4;
      String type;
      String prefix;
      double? battery;
      switch (typeIndex) {
        case 0:
          type = 'sensor';
          prefix = '传感器';
          battery = (50 + i % 50).toDouble();
          break;
        case 1:
          type = 'camera';
          prefix = '摄像头';
          battery = null; // 摄像头一般接电源
          break;
        case 2:
          type = 'base_station';
          prefix = '基站';
          battery = null;
          break;
        default:
          type = 'beacon';
          prefix = '信标';
          battery = (30 + i % 70).toDouble();
      }
      devices.add({
        'id': 'd${i.toString().padLeft(3, '0')}',
        'name': '$prefix-${String.fromCharCode(65 + typeIndex)}${i}',
        'type': type,
        'online': i % 10 != 0, // 每 10 个有 1 个离线
        'latitude': 39.120 + (i % 100) * 0.001,
        'longitude': 117.565 + (i ~/ 100) * 0.01,
        'lastSeen': now - (i % 60) * 60000,
        'battery': battery,
        'location': '采区-${String.fromCharCode(65 + i % 3)}${(i % 10) + 1}区',
      });
    }
    return devices;
  }
}