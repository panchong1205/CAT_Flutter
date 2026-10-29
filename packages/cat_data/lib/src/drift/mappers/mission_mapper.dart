import 'package:cat_domain/cat_domain.dart';
import '../app_database.dart';

/// DriftMission ↔ Mission 领域实体映射扩展
extension DriftMissionMapper on DriftMission {
  /// 将 Drift 数据类转换为领域实体
  Mission toDomain() => Mission(
        id: id,
        name: name,
        vehicleId: vehicleId,
        status: status,
        loadPoint: loadPoint,
        unloadPoint: unloadPoint,
        targetLoad: targetLoad,
        currentLoad: currentLoad,
        createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
        startedAt: startedAt != null ? DateTime.fromMillisecondsSinceEpoch(startedAt!) : null,
        completedAt: completedAt != null ? DateTime.fromMillisecondsSinceEpoch(completedAt!) : null,
        priority: priority,
      );
}