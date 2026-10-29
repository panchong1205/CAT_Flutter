import 'package:cat_domain/cat_domain.dart';
import '../app_database.dart';

/// DriftAlert ↔ Alert 领域实体映射扩展
extension DriftAlertMapper on DriftAlert {
  /// 将 Drift 数据类转换为领域实体
  Alert toDomain() => Alert(
        id: id,
        title: title,
        message: message,
        level: level,
        source: source,
        vehicleId: vehicleId,
        acknowledged: acknowledged,
        createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
        acknowledgedAt: acknowledgedAt != null ? DateTime.fromMillisecondsSinceEpoch(acknowledgedAt!) : null,
        acknowledgedBy: acknowledgedBy,
      );
}