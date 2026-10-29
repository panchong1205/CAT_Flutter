import 'package:cat_domain/cat_domain.dart';

/// 审批仓储实现
///
/// 当前使用 Mock 数据源。后续可扩展为 Drift 本地缓存 + HTTP 远程同步。
class ApprovalRepoImpl implements ApprovalRepository {
  final MockApprovalRepository _mock;

  ApprovalRepoImpl({MockApprovalRepository? mock})
      : _mock = mock ?? MockApprovalRepository();

  @override
  Future<List<ApprovalRequest>> getApprovals() => _mock.getApprovals();

  @override
  Future<int> getPendingApprovalCount() => _mock.getPendingApprovalCount();

  @override
  Future<List<ApprovalRequest>> getApprovalsByStatus(String status) =>
      _mock.getApprovalsByStatus(status);

  @override
  Future<ApprovalRequest> approve(String id, {String? comment}) =>
      _mock.approve(id, comment: comment);

  @override
  Future<ApprovalRequest> reject(String id, {String? comment}) =>
      _mock.reject(id, comment: comment);

  @override
  Future<ApprovalRequest> transfer(String id, String toUser, {String? comment}) =>
      _mock.transfer(id, toUser, comment: comment);
}