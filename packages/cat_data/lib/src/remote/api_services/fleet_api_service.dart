import 'package:cat_domain/cat_domain.dart';

/// 将 API 返回的 JSON Map 转换为 Vehicle 领域实体
Vehicle vehicleFromJson(Map<String, dynamic> json) => Vehicle(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: (json['altitude'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      fuel: (json['fuel'] as num).toDouble(),
      online: json['online'] as bool,
      status: json['status'] as String,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(json['lastUpdated'] as int),
    );

/// 将 API 返回的 JSON Map 转换为 Device 领域实体
Device deviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      status: (json['online'] as bool) ? 'online' : 'offline',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(json['lastSeen'] as int),
      battery: json['battery'] != null ? (json['battery'] as num).toDouble() : null,
      location: json['location'] as String?,
    );