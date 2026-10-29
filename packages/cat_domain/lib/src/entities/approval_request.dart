import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval_request.freezed.dart';

/// 审批请求实体
///
/// 表示一个需要审批的操作请求，如任务变更、设备维修等。
@freezed
class ApprovalRequest with _$ApprovalRequest {
  const factory ApprovalRequest({
    required String id,             // 审批单唯一标识
    required String title,          // 审批标题
    required String description,    // 审批描述
    required String type,           // 审批类型：mission_change / device_repair / safety / other
    required String status,         // 状态：pending / approved / rejected / transferred
    required String applicantName,  // 申请人
    String? approverName,           // 审批人
    required DateTime createdAt,    // 申请时间
    DateTime? resolvedAt,           // 审批时间
    String? comment,                // 审批意见
    String? transferredTo,          // 转交人
  }) = _ApprovalRequest;

  const ApprovalRequest._();
}