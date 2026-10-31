import 'package:cat_domain/cat_domain.dart';

/// 任务 API JSON 序列化工具

/// 将 API 返回的 JSON Map 转换为 [Mission] 领域实体
Mission missionFromJson(Map<String, dynamic> json) => Mission(
      id: json['id'] as String,
      name: json['name'] as String,
      vehicleId: json['vehicleId'] as String,
      status: json['status'] as String,
      loadPoint: json['loadPoint'] as String,
      unloadPoint: json['unloadPoint'] as String,
      targetLoad: (json['targetLoad'] as num).toDouble(),
      currentLoad: (json['currentLoad'] as num).toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      startedAt: json['startedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['startedAt'] as int) : null,
      completedAt: json['completedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['completedAt'] as int) : null,
      priority: json['priority'] as String?,
    );