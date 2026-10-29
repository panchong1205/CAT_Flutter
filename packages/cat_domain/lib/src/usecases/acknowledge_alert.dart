import '../entities/alert.dart';

/// 确认告警 UseCase
///
/// 操作员确认一条告警，记录确认人和时间。
abstract class AcknowledgeAlert {
  /// 确认指定告警
  ///
  /// [alertId] 待确认的告警 ID
  /// [operatorName] 操作员姓名
  /// 返回更新后的告警对象
  Future<Alert> call({
    required String alertId,
    required String operatorName,
  });
}