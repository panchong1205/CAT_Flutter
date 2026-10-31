import '../entities/approval_request.dart';

/// 审批仓储抽象接口
///
/// 定义审批工作流的数据访问契约，包括列表查询和审批操作。
abstract class ApprovalRepository {
  /// 获取所有审批请求列表
  Future<List<ApprovalRequest>> getApprovals();

  /// 获取待审批的数量（用于徽章/角标展示）
  Future<int> getPendingApprovalCount();

  /// 按状态筛选审批请求
  Future<List<ApprovalRequest>> getApprovalsByStatus(String status);

  /// 审批通过
  ///
  /// [id] 审批单 ID
  /// [comment] 审批意见（可选）
  Future<ApprovalRequest> approve(String id, {String? comment});

  /// 审批驳回
  ///
  /// [id] 审批单 ID
  /// [comment] 驳回理由（可选）
  Future<ApprovalRequest> reject(String id, {String? comment});

  /// 转交审批给其他审批人
  ///
  /// [id] 审批单 ID
  /// [toUser] 转交目标用户
  /// [comment] 转交说明（可选）
  Future<ApprovalRequest> transfer(String id, String toUser, {String? comment});
}