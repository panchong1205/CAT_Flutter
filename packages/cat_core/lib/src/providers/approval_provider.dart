import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_domain/cat_domain.dart';
import '../di/di_container.dart';

/// 审批列表 Provider
final approvalsProvider = FutureProvider<List<ApprovalRequest>>((ref) async {
  final repo = di<ApprovalRepository>();
  return repo.getApprovals();
});

/// 待审批数量 Provider
final pendingApprovalCountProvider = FutureProvider<int>((ref) async {
  final repo = di<ApprovalRepository>();
  return repo.getPendingApprovalCount();
});

/// 审批通过操作
Future<ApprovalRequest> approveRequest(String id, {String? comment}) async {
  final repo = di<ApprovalRepository>();
  return repo.approve(id, comment: comment);
}

/// 审批驳回操作
Future<ApprovalRequest> rejectRequest(String id, {String? comment}) async {
  final repo = di<ApprovalRepository>();
  return repo.reject(id, comment: comment);
}

/// 审批转交操作
Future<ApprovalRequest> transferRequest(String id, String toUser, {String? comment}) async {
  final repo = di<ApprovalRepository>();
  return repo.transfer(id, toUser, comment: comment);
}