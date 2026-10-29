import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 通知中心 Provider
///
/// 聚合告警、任务、审批、巡检四个模块的通知消息，
/// 按时序排列，最新在前。
final notificationsProvider = FutureProvider<List<NotificationMessage>>((ref) async {
  final alertRepo = di<AlertRepository>();
  final missionRepo = di<MissionRepository>();
  final approvalRepo = di<ApprovalRepository>();
  final patrolRepo = di<PatrolRepository>();

  final results = await Future.wait([
    alertRepo.getAlerts(),
    missionRepo.getMissions(),
    approvalRepo.getApprovals(),
    patrolRepo.getPatrolPoints(),
  ]);

  final alerts = results[0] as List<Alert>;
  final missions = results[1] as List<Mission>;
  final approvals = results[2] as List<ApprovalRequest>;
  final patrols = results[3] as List<PatrolPoint>;

  final now = DateTime.now();
  final notifications = <NotificationMessage>[];

  // 告警 → 通知
  for (final a in alerts) {
    if (a.level == 'critical' || a.level == 'warning') {
      notifications.add(NotificationMessage(
        id: 'alert-${a.id}',
        title: a.title,
        body: a.message,
        type: 'alert',
        level: a.level,
        sourceId: a.id,
        sourceRoute: '/alerts',
        createdAt: a.createdAt,
        isRead: a.acknowledged,
      ));
    }
  }

  // 任务 → 通知
  for (final m in missions) {
    if (m.status == 'pending' || m.status == 'in_progress') {
      notifications.add(NotificationMessage(
        id: 'mission-${m.id}',
        title: m.status == 'pending' ? '新任务分配' : '任务进行中',
        body: '${m.name}: ${m.loadPoint} → ${m.unloadPoint}',
        type: 'mission',
        level: m.status == 'pending' ? 'info' : 'warning',
        sourceId: m.id,
        sourceRoute: '/missions',
        createdAt: m.createdAt,
        isRead: m.status != 'pending',
      ));
    }
  }

  // 审批 → 通知
  for (final a in approvals) {
    if (a.status == 'pending') {
      notifications.add(NotificationMessage(
        id: 'approval-${a.id}',
        title: '待审批: ${a.title}',
        body: '${a.applicantName} 提交了${_approvalTypeLabel(a.type)}审批',
        type: 'approval',
        level: 'warning',
        sourceId: a.id,
        sourceRoute: '/approval',
        createdAt: a.createdAt,
        isRead: false,
      ));
    }
  }

  // 巡检 → 通知
  for (final p in patrols) {
    if (p.status == 'pending') {
      notifications.add(NotificationMessage(
        id: 'patrol-${p.id}',
        title: '待巡检: ${p.name}',
        body: '${p.location} 需要${p.assigneeName ?? "巡检人员"}巡检',
        type: 'patrol',
        level: 'info',
        sourceId: p.id,
        sourceRoute: '/patrol',
        createdAt: p.scheduledAt ?? now,
        isRead: false,
      ));
    }
  }

  // 按时序排列，最新在前
  notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return notifications;
});

String _approvalTypeLabel(String type) {
  return switch (type) {
    'mission_change' => '任务变更',
    'device_repair' => '设备维修',
    'safety' => '安全',
    _ => '其他',
  };
}