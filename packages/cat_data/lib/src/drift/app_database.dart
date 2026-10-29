import 'package:drift/drift.dart';

import 'tables/vehicle_table.dart';
import 'tables/mission_table.dart';
import 'tables/alert_table.dart';
import 'tables/device_table.dart';
import 'tables/sync_queue_table.dart';

part 'app_database.g.dart';

/// CUSTOM App 本地数据库
///
/// 基于 Drift (SQLite) 实现，管理车辆、任务、告警、设备、离线队列的本地持久化存储。
/// 所有 CRUD 操作直接定义在此类中，避免 DAO 层的循环导入问题。
///
/// 接收一个 [QueryExecutor] 参数来解耦平台特定的连接创建逻辑：
/// - Web 平台：使用 WasmDatabase.inMemory()
/// - 原生平台：使用文件数据库，由工厂方法创建
@DriftDatabase(tables: [Vehicles, Missions, Alerts, Devices, SyncQueueItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase({required QueryExecutor executor}) : super(executor);

  // ============================================================
  // 车辆 DAO
  // ============================================================

  /// 查询所有车辆，按名称排序
  Future<List<DriftVehicle>> getAllVehicles() => select(vehicles).get();

  /// 统计在线车辆数
  Future<int> getOnlineVehicleCount() async {
    final rows = await (selectOnly(vehicles)..addColumns([vehicles.id])..where(vehicles.online.equals(true))).get();
    return rows.length;
  }

  /// 批量插入或更新车辆数据
  Future<void> upsertVehicles(List<VehiclesCompanion> vehiclesToUpsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(vehicles, vehiclesToUpsert);
    });
  }

  // ============================================================
  // 任务 DAO
  // ============================================================

  /// 查询所有任务，按创建时间降序排列
  Future<List<DriftMission>> getAllMissions() => (select(missions)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  /// 统计进行中任务数（pending / accepted / in_progress）
  Future<int> getActiveMissionCount() async {
    final rows = await (selectOnly(missions)
          ..addColumns([missions.id])
          ..where(missions.status.isIn(['pending', 'accepted', 'in_progress'])))
        .get();
    return rows.length;
  }

  /// 批量插入或更新任务数据
  Future<void> upsertMissions(List<MissionsCompanion> missionsToUpsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(missions, missionsToUpsert);
    });
  }

  /// 更新单个任务状态
  Future<void> updateMissionStatus(String id, String status) {
    return (update(missions)..where((t) => t.id.equals(id))).write(MissionsCompanion(status: Value(status)));
  }

  // ============================================================
  // 告警 DAO
  // ============================================================

  /// 查询所有告警，按创建时间降序排列
  Future<List<DriftAlert>> getAllAlerts() => (select(alerts)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  /// 统计今日告警数（当天 00:00 至今）
  Future<int> getTodayAlertCount() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final rows = await (selectOnly(alerts)
          ..addColumns([alerts.id])
          ..where(alerts.createdAt.isBiggerOrEqualValue(startOfDay)))
        .get();
    return rows.length;
  }

  /// 批量插入或更新告警数据
  Future<void> upsertAlerts(List<AlertsCompanion> alertsToUpsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(alerts, alertsToUpsert);
    });
  }

  /// 确认告警
  Future<void> acknowledgeAlert(String id, String acknowledgedBy, int acknowledgedAt) {
    return (update(alerts)..where((t) => t.id.equals(id))).write(
      AlertsCompanion(
        acknowledged: const Value(true),
        acknowledgedBy: Value(acknowledgedBy),
        acknowledgedAt: Value(acknowledgedAt),
      ),
    );
  }

  // ============================================================
  // 设备 DAO
  // ============================================================

  /// 查询所有设备
  Future<List<DriftDevice>> getAllDevices() => select(devices).get();

  /// 统计设备总数
  Future<int> getTotalDeviceCount() async {
    final rows = await (selectOnly(devices)..addColumns([devices.id])).get();
    return rows.length;
  }

  /// 批量插入或更新设备数据
  Future<void> upsertDevices(List<DevicesCompanion> devicesToUpsert) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(devices, devicesToUpsert);
    });
  }

  // ============================================================
  // 离线同步队列 DAO
  // ============================================================

  /// 将操作加入离线队列
  Future<int> enqueueSyncOperation(String operationType, String payload) {
    return into(syncQueueItems).insert(
      SyncQueueItemsCompanion.insert(
        operationType: operationType,
        payload: payload,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// 查询所有待处理的操作（pending / failed），按创建时间升序
  Future<List<DriftSyncQueueItem>> getPendingSyncOps() {
    return (select(syncQueueItems)
      ..where((t) => t.status.isIn(['pending', 'failed']))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  /// 将操作标记为 done
  Future<void> markSyncOpDone(int id) {
    return (update(syncQueueItems)..where((t) => t.id.equals(id)))
        .write(const SyncQueueItemsCompanion(status: Value('done')));
  }

  /// 将操作标记为 failed 并增加重试次数
  Future<void> markSyncOpFailed(int id) async {
    final item = await (select(syncQueueItems)..where((t) => t.id.equals(id))).getSingle();
    await (update(syncQueueItems)..where((t) => t.id.equals(id))).write(
      SyncQueueItemsCompanion(
        status: const Value('failed'),
        retries: Value(item.retries + 1),
      ),
    );
  }

  // ============================================================
  // 数据库版本
  // ============================================================

  @override
  int get schemaVersion => 2;
}