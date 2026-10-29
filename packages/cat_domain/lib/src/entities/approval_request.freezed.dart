// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalRequest {
  String get id => throw _privateConstructorUsedError; // 审批单唯一标识
  String get title => throw _privateConstructorUsedError; // 审批标题
  String get description => throw _privateConstructorUsedError; // 审批描述
  String get type =>
      throw _privateConstructorUsedError; // 审批类型：mission_change / device_repair / safety / other
  String get status =>
      throw _privateConstructorUsedError; // 状态：pending / approved / rejected / transferred
  String get applicantName => throw _privateConstructorUsedError; // 申请人
  String? get approverName => throw _privateConstructorUsedError; // 审批人
  DateTime get createdAt => throw _privateConstructorUsedError; // 申请时间
  DateTime? get resolvedAt => throw _privateConstructorUsedError; // 审批时间
  String? get comment => throw _privateConstructorUsedError; // 审批意见
  String? get transferredTo => throw _privateConstructorUsedError;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalRequestCopyWith<ApprovalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestCopyWith(
    ApprovalRequest value,
    $Res Function(ApprovalRequest) then,
  ) = _$ApprovalRequestCopyWithImpl<$Res, ApprovalRequest>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String type,
    String status,
    String applicantName,
    String? approverName,
    DateTime createdAt,
    DateTime? resolvedAt,
    String? comment,
    String? transferredTo,
  });
}

/// @nodoc
class _$ApprovalRequestCopyWithImpl<$Res, $Val extends ApprovalRequest>
    implements $ApprovalRequestCopyWith<$Res> {
  _$ApprovalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? applicantName = null,
    Object? approverName = freezed,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? comment = freezed,
    Object? transferredTo = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            applicantName: null == applicantName
                ? _value.applicantName
                : applicantName // ignore: cast_nullable_to_non_nullable
                      as String,
            approverName: freezed == approverName
                ? _value.approverName
                : approverName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            transferredTo: freezed == transferredTo
                ? _value.transferredTo
                : transferredTo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApprovalRequestImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$ApprovalRequestImplCopyWith(
    _$ApprovalRequestImpl value,
    $Res Function(_$ApprovalRequestImpl) then,
  ) = __$$ApprovalRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String type,
    String status,
    String applicantName,
    String? approverName,
    DateTime createdAt,
    DateTime? resolvedAt,
    String? comment,
    String? transferredTo,
  });
}

/// @nodoc
class __$$ApprovalRequestImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$ApprovalRequestImpl>
    implements _$$ApprovalRequestImplCopyWith<$Res> {
  __$$ApprovalRequestImplCopyWithImpl(
    _$ApprovalRequestImpl _value,
    $Res Function(_$ApprovalRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? applicantName = null,
    Object? approverName = freezed,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? comment = freezed,
    Object? transferredTo = freezed,
  }) {
    return _then(
      _$ApprovalRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        applicantName: null == applicantName
            ? _value.applicantName
            : applicantName // ignore: cast_nullable_to_non_nullable
                  as String,
        approverName: freezed == approverName
            ? _value.approverName
            : approverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        transferredTo: freezed == transferredTo
            ? _value.transferredTo
            : transferredTo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ApprovalRequestImpl extends _ApprovalRequest {
  const _$ApprovalRequestImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.applicantName,
    this.approverName,
    required this.createdAt,
    this.resolvedAt,
    this.comment,
    this.transferredTo,
  }) : super._();

  @override
  final String id;
  // 审批单唯一标识
  @override
  final String title;
  // 审批标题
  @override
  final String description;
  // 审批描述
  @override
  final String type;
  // 审批类型：mission_change / device_repair / safety / other
  @override
  final String status;
  // 状态：pending / approved / rejected / transferred
  @override
  final String applicantName;
  // 申请人
  @override
  final String? approverName;
  // 审批人
  @override
  final DateTime createdAt;
  // 申请时间
  @override
  final DateTime? resolvedAt;
  // 审批时间
  @override
  final String? comment;
  // 审批意见
  @override
  final String? transferredTo;

  @override
  String toString() {
    return 'ApprovalRequest(id: $id, title: $title, description: $description, type: $type, status: $status, applicantName: $applicantName, approverName: $approverName, createdAt: $createdAt, resolvedAt: $resolvedAt, comment: $comment, transferredTo: $transferredTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.applicantName, applicantName) ||
                other.applicantName == applicantName) &&
            (identical(other.approverName, approverName) ||
                other.approverName == approverName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.transferredTo, transferredTo) ||
                other.transferredTo == transferredTo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    type,
    status,
    applicantName,
    approverName,
    createdAt,
    resolvedAt,
    comment,
    transferredTo,
  );

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalRequestImplCopyWith<_$ApprovalRequestImpl> get copyWith =>
      __$$ApprovalRequestImplCopyWithImpl<_$ApprovalRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _ApprovalRequest extends ApprovalRequest {
  const factory _ApprovalRequest({
    required final String id,
    required final String title,
    required final String description,
    required final String type,
    required final String status,
    required final String applicantName,
    final String? approverName,
    required final DateTime createdAt,
    final DateTime? resolvedAt,
    final String? comment,
    final String? transferredTo,
  }) = _$ApprovalRequestImpl;
  const _ApprovalRequest._() : super._();

  @override
  String get id; // 审批单唯一标识
  @override
  String get title; // 审批标题
  @override
  String get description; // 审批描述
  @override
  String get type; // 审批类型：mission_change / device_repair / safety / other
  @override
  String get status; // 状态：pending / approved / rejected / transferred
  @override
  String get applicantName; // 申请人
  @override
  String? get approverName; // 审批人
  @override
  DateTime get createdAt; // 申请时间
  @override
  DateTime? get resolvedAt; // 审批时间
  @override
  String? get comment; // 审批意见
  @override
  String? get transferredTo;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApprovalRequestImplCopyWith<_$ApprovalRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
