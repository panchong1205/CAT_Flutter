// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patrol_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PatrolPoint {
  String get id => throw _privateConstructorUsedError; // 巡检点唯一标识
  String get name => throw _privateConstructorUsedError; // 巡检点名称（如"1号破碎站"）
  String get location => throw _privateConstructorUsedError; // 巡检位置描述
  String get status =>
      throw _privateConstructorUsedError; // 状态：pending / completed / skipped
  String get category =>
      throw _privateConstructorUsedError; // 类别：safety / equipment / environment
  String? get assigneeName => throw _privateConstructorUsedError; // 巡检人姓名
  DateTime? get scheduledAt => throw _privateConstructorUsedError; // 计划巡检时间
  DateTime? get completedAt => throw _privateConstructorUsedError; // 实际完成时间
  String? get photoUrl => throw _privateConstructorUsedError; // 巡检拍照 URL（可选）
  String? get remark => throw _privateConstructorUsedError;

  /// Create a copy of PatrolPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatrolPointCopyWith<PatrolPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatrolPointCopyWith<$Res> {
  factory $PatrolPointCopyWith(
    PatrolPoint value,
    $Res Function(PatrolPoint) then,
  ) = _$PatrolPointCopyWithImpl<$Res, PatrolPoint>;
  @useResult
  $Res call({
    String id,
    String name,
    String location,
    String status,
    String category,
    String? assigneeName,
    DateTime? scheduledAt,
    DateTime? completedAt,
    String? photoUrl,
    String? remark,
  });
}

/// @nodoc
class _$PatrolPointCopyWithImpl<$Res, $Val extends PatrolPoint>
    implements $PatrolPointCopyWith<$Res> {
  _$PatrolPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatrolPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? location = null,
    Object? status = null,
    Object? category = null,
    Object? assigneeName = freezed,
    Object? scheduledAt = freezed,
    Object? completedAt = freezed,
    Object? photoUrl = freezed,
    Object? remark = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            assigneeName: freezed == assigneeName
                ? _value.assigneeName
                : assigneeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            remark: freezed == remark
                ? _value.remark
                : remark // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PatrolPointImplCopyWith<$Res>
    implements $PatrolPointCopyWith<$Res> {
  factory _$$PatrolPointImplCopyWith(
    _$PatrolPointImpl value,
    $Res Function(_$PatrolPointImpl) then,
  ) = __$$PatrolPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String location,
    String status,
    String category,
    String? assigneeName,
    DateTime? scheduledAt,
    DateTime? completedAt,
    String? photoUrl,
    String? remark,
  });
}

/// @nodoc
class __$$PatrolPointImplCopyWithImpl<$Res>
    extends _$PatrolPointCopyWithImpl<$Res, _$PatrolPointImpl>
    implements _$$PatrolPointImplCopyWith<$Res> {
  __$$PatrolPointImplCopyWithImpl(
    _$PatrolPointImpl _value,
    $Res Function(_$PatrolPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatrolPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? location = null,
    Object? status = null,
    Object? category = null,
    Object? assigneeName = freezed,
    Object? scheduledAt = freezed,
    Object? completedAt = freezed,
    Object? photoUrl = freezed,
    Object? remark = freezed,
  }) {
    return _then(
      _$PatrolPointImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        assigneeName: freezed == assigneeName
            ? _value.assigneeName
            : assigneeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        remark: freezed == remark
            ? _value.remark
            : remark // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PatrolPointImpl extends _PatrolPoint {
  const _$PatrolPointImpl({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.category,
    this.assigneeName,
    this.scheduledAt,
    this.completedAt,
    this.photoUrl,
    this.remark,
  }) : super._();

  @override
  final String id;
  // 巡检点唯一标识
  @override
  final String name;
  // 巡检点名称（如"1号破碎站"）
  @override
  final String location;
  // 巡检位置描述
  @override
  final String status;
  // 状态：pending / completed / skipped
  @override
  final String category;
  // 类别：safety / equipment / environment
  @override
  final String? assigneeName;
  // 巡检人姓名
  @override
  final DateTime? scheduledAt;
  // 计划巡检时间
  @override
  final DateTime? completedAt;
  // 实际完成时间
  @override
  final String? photoUrl;
  // 巡检拍照 URL（可选）
  @override
  final String? remark;

  @override
  String toString() {
    return 'PatrolPoint(id: $id, name: $name, location: $location, status: $status, category: $category, assigneeName: $assigneeName, scheduledAt: $scheduledAt, completedAt: $completedAt, photoUrl: $photoUrl, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatrolPointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.assigneeName, assigneeName) ||
                other.assigneeName == assigneeName) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    location,
    status,
    category,
    assigneeName,
    scheduledAt,
    completedAt,
    photoUrl,
    remark,
  );

  /// Create a copy of PatrolPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatrolPointImplCopyWith<_$PatrolPointImpl> get copyWith =>
      __$$PatrolPointImplCopyWithImpl<_$PatrolPointImpl>(this, _$identity);
}

abstract class _PatrolPoint extends PatrolPoint {
  const factory _PatrolPoint({
    required final String id,
    required final String name,
    required final String location,
    required final String status,
    required final String category,
    final String? assigneeName,
    final DateTime? scheduledAt,
    final DateTime? completedAt,
    final String? photoUrl,
    final String? remark,
  }) = _$PatrolPointImpl;
  const _PatrolPoint._() : super._();

  @override
  String get id; // 巡检点唯一标识
  @override
  String get name; // 巡检点名称（如"1号破碎站"）
  @override
  String get location; // 巡检位置描述
  @override
  String get status; // 状态：pending / completed / skipped
  @override
  String get category; // 类别：safety / equipment / environment
  @override
  String? get assigneeName; // 巡检人姓名
  @override
  DateTime? get scheduledAt; // 计划巡检时间
  @override
  DateTime? get completedAt; // 实际完成时间
  @override
  String? get photoUrl; // 巡检拍照 URL（可选）
  @override
  String? get remark;

  /// Create a copy of PatrolPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatrolPointImplCopyWith<_$PatrolPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
