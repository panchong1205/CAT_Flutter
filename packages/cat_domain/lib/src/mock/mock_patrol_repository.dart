import '../entities/patrol_point.dart';
import '../repositories/patrol_repository.dart';

/// 巡检 Mock 数据源
///
/// 提供 6 个矿山区巡检点，覆盖安全、设备、环境三类。
class MockPatrolRepository implements PatrolRepository {
  final List<PatrolPoint> _points = [
    const PatrolPoint(
      id: 'P001', name: '1号破碎站', location: '矿区北侧 A3 区',
      status: 'pending', category: 'equipment',
      assigneeName: '张工', scheduledAt: null,
    ),
    const PatrolPoint(
      id: 'P002', name: '2号皮带廊', location: '矿区中部 B1 区',
      status: 'completed', category: 'equipment',
      assigneeName: '张工', scheduledAt: null,
      completedAt: null,
    ),
    const PatrolPoint(
      id: 'P003', name: '3号矿卡加油站', location: '矿区南侧 C2 区',
      status: 'pending', category: 'safety',
      assigneeName: '李工', scheduledAt: null,
    ),
    const PatrolPoint(
      id: 'P004', name: '边坡监测点 A', location: '矿区东侧 D5 区',
      status: 'pending', category: 'safety',
      assigneeName: '李工',
    ),
    const PatrolPoint(
      id: 'P005', name: '排水沟检查点', location: '矿区西部 E1 区',
      status: 'skipped', category: 'environment',
      assigneeName: '王工',
    ),
    const PatrolPoint(
      id: 'P006', name: '4号转载台', location: '矿区北部 A5 区',
      status: 'pending', category: 'equipment',
      assigneeName: '张工',
    ),
  ];

  void _initDates() {
    final now = DateTime.now();
    for (var i = 0; i < _points.length; i++) {
      final p = _points[i];
      final newPoint = p.copyWith(
        scheduledAt: now.subtract(Duration(hours: 1)),
        completedAt: p.status == 'completed' ? now.subtract(const Duration(minutes: 30)) : null,
      );
      _points[i] = newPoint;
    }
  }

  @override
  Future<List<PatrolPoint>> getPatrolPoints() async {
    _initDates();
    await Future.delayed(const Duration(milliseconds: 200));
    return _points;
  }

  @override
  Future<int> getPendingPatrolCount() async {
    return _points.where((p) => p.status == 'pending').length;
  }

  @override
  Future<List<PatrolPoint>> getPatrolPointsByStatus(String status) async {
    return _points.where((p) => p.status == status).toList();
  }

  @override
  Future<PatrolPoint> checkIn(String id, {String? remark}) async {
    final index = _points.indexWhere((p) => p.id == id);
    if (index == -1) throw Exception('巡检点 $id 不存在');
    final updated = _points[index].copyWith(
      status: 'completed',
      completedAt: DateTime.now(),
      remark: remark ?? '巡检正常',
    );
    _points[index] = updated;
    return updated;
  }
}