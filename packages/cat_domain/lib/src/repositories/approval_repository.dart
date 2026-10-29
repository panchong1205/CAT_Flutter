import '../entities/approval_request.dart';

/// 审批仓储抽象接口
abstract class ApprovalRepository {
  /// 获取所有审批请求列表
  Future<List<ApprovalRequest>> getApprovals();

  /// 获取待审批的数量
  Future<int> getPendingApprovalCount();

  /// 按状态筛选审批
  Future<List<ApprovalRequest>> getApprovalsByStatus(String status);

  /// 审批通过
  Future<ApprovalRequest> approve(String id, {String? comment});

  /// 审批驳回
  Future<ApprovalRequest> reject(String id, {String? comment});

  /// 转交审批
  Future<ApprovalRequest> transfer(String id, String toUser, {String? comment});
}