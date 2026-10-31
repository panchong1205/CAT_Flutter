import 'package:cat_domain/cat_domain.dart';
import 'package:drift/drift.dart';
import '../drift/app_database.dart';
import '../drift/mappers/mission_mapper.dart';
import '../remote/http_client.dart';
import '../remote/api_services/mission_api_service.dart';

/// 任务仓储实现
///
/// 采用离线优先策略，先查本地缓存再异步更新。
class MissionRepoImpl implements MissionRepository {
  final AppDatabase _db;
  final CatHttpClient _httpClient;

  MissionRepoImpl({required AppDatabase db, required CatHttpClient httpClient})
      : _db = db,
        _httpClient = httpClient;

  @override
  Future<List<Mission>> getMissions() async {
    final cached = await _db.getAllMissions();
    _refreshMissions();
    return cached.map((m) => m.toDomain()).toList();
  }

  @override
  Future<int> getActiveMissionCount() async {
    final count = await _db.getActiveMissionCount();
    if (count == 0) {
      await _refreshMissions();
      return _db.getActiveMissionCount();
    }
    return count;
  }

  @override
  Future<Mission?> getMissionById(String id) async {
    final all = await getMissions();
    try {
      return all.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Mission>> getMissionsByStatus(String status) async {
    final all = await getMissions();
    return all.where((m) => m.status == status).toList();
  }

  // ============================================================
  // 后台刷新
  // ============================================================

  /// 异步获取远端任务数据并批量写入本地数据库
  Future<void> _refreshMissions() async {
    try {
      final response = await _httpClient.get('/missions');
      final List<dynamic> raw = response.data['data'] as List<dynamic>;
      final missions = raw.cast<Map<String, dynamic>>().map(missionFromJson).toList();

      final companions = missions.map((m) {
        return MissionsCompanion.insert(
          id: m.id,
          name: m.name,
          vehicleId: m.vehicleId,
          status: m.status,
          loadPoint: m.loadPoint,
          unloadPoint: m.unloadPoint,
          targetLoad: m.targetLoad,
          currentLoad: m.currentLoad,
          createdAt: m.createdAt.millisecondsSinceEpoch,
          startedAt: Value(m.startedAt?.millisecondsSinceEpoch),
          completedAt: Value(m.completedAt?.millisecondsSinceEpoch),
          priority: Value(m.priority),
        );
      }).toList();
      await _db.upsertMissions(companions);
    } catch (_) {
      // 静默失败
    }
  }
}