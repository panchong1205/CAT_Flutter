import 'package:cat_domain/cat_domain.dart';

/// 告警 API JSON 序列化工具

/// 将 API 返回的 JSON Map 转换为 [Alert] 领域实体
Alert alertFromJson(Map<String, dynamic> json) => Alert(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      level: json['level'] as String,
      source: json['source'] as String,
      vehicleId: json['vehicleId'] as String?,
      acknowledged: json['acknowledged'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      acknowledgedAt: json['acknowledgedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['acknowledgedAt'] as int) : null,
      acknowledgedBy: json['acknowledgedBy'] as String?,
    );