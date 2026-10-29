import 'package:cat_domain/cat_domain.dart';

/// 巡检仓储实现
///
/// 当前使用 Mock 数据源。后续可扩展为 Drift 本地缓存 + HTTP 远程同步。
class PatrolRepoImpl implements PatrolRepository {
  final MockPatrolRepository _mock;

  PatrolRepoImpl({MockPatrolRepository? mock})
      : _mock = mock ?? MockPatrolRepository();

  @override
  Future<List<PatrolPoint>> getPatrolPoints() => _mock.getPatrolPoints();

  @override
  Future<int> getPendingPatrolCount() => _mock.getPendingPatrolCount();

  @override
  Future<List<PatrolPoint>> getPatrolPointsByStatus(String status) =>
      _mock.getPatrolPointsByStatus(status);

  @override
  Future<PatrolPoint> checkIn(String id, {String? remark}) =>
      _mock.checkIn(id, remark: remark);
}