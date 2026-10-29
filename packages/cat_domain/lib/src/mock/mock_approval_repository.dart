import '../entities/approval_request.dart';
import '../repositories/approval_repository.dart';

/// 审批 Mock 数据源
///
/// 提供 5 条审批请求，涵盖任务变更、设备维修、安全稽核等场景。
class MockApprovalRepository implements ApprovalRepository {
  List<ApprovalRequest> _buildRequests() {
    final now = DateTime.now();
    return [
      ApprovalRequest(
        id: 'A001', title: '3号矿卡维修申请', description: '3号矿卡发动机温度传感器故障，需要更换传感器模块。预计维修时间2小时。',
        type: 'device_repair', status: 'pending',
        applicantName: '张工',
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      ApprovalRequest(
        id: 'A002', title: '任务 #M004 优先级变更', description: '因采区出矿量调整，需将任务 #M004 从 normal 提升至 high 优先级，提前完成运输。',
        type: 'mission_change', status: 'pending',
        applicantName: '调度员 李',
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
      ApprovalRequest(
        id: 'A003', title: '2号皮带廊安全稽核', description: '2号皮带廊巡检发现防护栏松动，需停机加固处理。',
        type: 'safety', status: 'approved',
        applicantName: '安全员 王',
        approverName: '矿长 赵',
        createdAt: now.subtract(const Duration(hours: 3)),
        resolvedAt: now.subtract(const Duration(minutes: 30)),
        comment: '同意，立即停机加固',
      ),
      ApprovalRequest(
        id: 'A004', title: '夜间作业照明升级', description: '矿区 B 区夜间照明不足，申请增加4组LED照明灯组。',
        type: 'other', status: 'rejected',
        applicantName: '班长 陈',
        approverName: '矿长 赵',
        createdAt: now.subtract(const Duration(hours: 2)),
        resolvedAt: now.subtract(const Duration(minutes: 30)),
        comment: '预算不足，下季度再议',
      ),
      ApprovalRequest(
        id: 'A005', title: '5号矿卡超载豁免', description: '5号矿卡因装载点计量误差，本次运输超出额定载重5%，申请豁免处理。',
        type: 'mission_change', status: 'pending',
        applicantName: '调度员 李',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
    ];
  }

  @override
  Future<List<ApprovalRequest>> getApprovals() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _buildRequests();
  }

  @override
  Future<int> getPendingApprovalCount() async {
    final requests = _buildRequests();
    return requests.where((r) => r.status == 'pending').length;
  }

  @override
  Future<List<ApprovalRequest>> getApprovalsByStatus(String status) async {
    final requests = _buildRequests();
    return requests.where((r) => r.status == status).toList();
  }

  @override
  Future<ApprovalRequest> approve(String id, {String? comment}) async {
    return _resolve(id, 'approved', comment);
  }

  @override
  Future<ApprovalRequest> reject(String id, {String? comment}) async {
    return _resolve(id, 'rejected', comment);
  }

  @override
  Future<ApprovalRequest> transfer(String id, String toUser, {String? comment}) async {
    final requests = _buildRequests();
    final index = requests.indexWhere((r) => r.id == id);
    if (index == -1) throw Exception('审批单 $id 不存在');
    return requests[index].copyWith(
      status: 'transferred',
      transferredTo: toUser,
      comment: comment ?? '已转交',
      resolvedAt: DateTime.now(),
    );
  }

  Future<ApprovalRequest> _resolve(String id, String status, String? comment) async {
    final requests = _buildRequests();
    final index = requests.indexWhere((r) => r.id == id);
    if (index == -1) throw Exception('审批单 $id 不存在');
    return requests[index].copyWith(
      status: status,
      approverName: '矿长 赵',
      comment: comment ?? (status == 'approved' ? '同意' : '驳回'),
      resolvedAt: DateTime.now(),
    );
  }
}