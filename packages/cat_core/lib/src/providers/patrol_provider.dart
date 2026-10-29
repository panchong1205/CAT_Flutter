import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 巡检点列表 Provider
final patrolPointsProvider = FutureProvider<List<PatrolPoint>>((ref) async {
  final repo = di<PatrolRepository>();
  return repo.getPatrolPoints();
});

/// 待巡检数量 Provider
final pendingPatrolCountProvider = FutureProvider<int>((ref) async {
  final repo = di<PatrolRepository>();
  return repo.getPendingPatrolCount();
});

/// 巡检打卡操作
Future<PatrolPoint> checkInPatrolPoint(String id, {String? remark}) async {
  final repo = di<PatrolRepository>();
  return repo.checkIn(id, remark: remark);
}