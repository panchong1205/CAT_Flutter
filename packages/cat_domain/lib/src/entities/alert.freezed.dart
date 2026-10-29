// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Alert {
  String get id => throw _privateConstructorUsedError; // 告警唯一标识
  String get title => throw _privateConstructorUsedError; // 告警标题
  String get message => throw _privateConstructorUsedError; // 告警详情
  String get level =>
      throw _privateConstructorUsedError; // 告警级别：critical / warning / info
  String get source =>
      throw _privateConstructorUsedError; // 告警来源：vehicle / system / safety
  String? get vehicleId => throw _privateConstructorUsedError; // 关联车辆 ID（可选）
  bool get acknowledged => throw _privateConstructorUsedError; // 是否已确认
  DateTime get createdAt => throw _privateConstructorUsedError; // 告警时间
  DateTime? get acknowledgedAt => throw _privateConstructorUsedError; // 确认时间
  String? get acknowledgedBy => throw _privateConstructorUsedError;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call({
    String id,
    String title,
    String message,
    String level,
    String source,
    String? vehicleId,
    bool acknowledged,
    DateTime createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedBy,
  });
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? level = null,
    Object? source = null,
    Object? vehicleId = freezed,
    Object? acknowledged = null,
    Object? createdAt = null,
    Object? acknowledgedAt = freezed,
    Object? acknowledgedBy = freezed,
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
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            vehicleId: freezed == vehicleId
                ? _value.vehicleId
                : vehicleId // ignore: cast_nullable_to_non_nullable
                      as String?,
            acknowledged: null == acknowledged
                ? _value.acknowledged
                : acknowledged // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            acknowledgedAt: freezed == acknowledgedAt
                ? _value.acknowledgedAt
                : acknowledgedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            acknowledgedBy: freezed == acknowledgedBy
                ? _value.acknowledgedBy
                : acknowledgedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AlertImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertImplCopyWith(
    _$AlertImpl value,
    $Res Function(_$AlertImpl) then,
  ) = __$$AlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String message,
    String level,
    String source,
    String? vehicleId,
    bool acknowledged,
    DateTime createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedBy,
  });
}

/// @nodoc
class __$$AlertImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertImpl>
    implements _$$AlertImplCopyWith<$Res> {
  __$$AlertImplCopyWithImpl(
    _$AlertImpl _value,
    $Res Function(_$AlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? level = null,
    Object? source = null,
    Object? vehicleId = freezed,
    Object? acknowledged = null,
    Object? createdAt = null,
    Object? acknowledgedAt = freezed,
    Object? acknowledgedBy = freezed,
  }) {
    return _then(
      _$AlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleId: freezed == vehicleId
            ? _value.vehicleId
            : vehicleId // ignore: cast_nullable_to_non_nullable
                  as String?,
        acknowledged: null == acknowledged
            ? _value.acknowledged
            : acknowledged // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        acknowledgedAt: freezed == acknowledgedAt
            ? _value.acknowledgedAt
            : acknowledgedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        acknowledgedBy: freezed == acknowledgedBy
            ? _value.acknowledgedBy
            : acknowledgedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AlertImpl implements _Alert {
  const _$AlertImpl({
    required this.id,
    required this.title,
    required this.message,
    required this.level,
    required this.source,
    this.vehicleId,
    required this.acknowledged,
    required this.createdAt,
    this.acknowledgedAt,
    this.acknowledgedBy,
  });

  @override
  final String id;
  // 告警唯一标识
  @override
  final String title;
  // 告警标题
  @override
  final String message;
  // 告警详情
  @override
  final String level;
  // 告警级别：critical / warning / info
  @override
  final String source;
  // 告警来源：vehicle / system / safety
  @override
  final String? vehicleId;
  // 关联车辆 ID（可选）
  @override
  final bool acknowledged;
  // 是否已确认
  @override
  final DateTime createdAt;
  // 告警时间
  @override
  final DateTime? acknowledgedAt;
  // 确认时间
  @override
  final String? acknowledgedBy;

  @override
  String toString() {
    return 'Alert(id: $id, title: $title, message: $message, level: $level, source: $source, vehicleId: $vehicleId, acknowledged: $acknowledged, createdAt: $createdAt, acknowledgedAt: $acknowledgedAt, acknowledgedBy: $acknowledgedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt) &&
            (identical(other.acknowledgedBy, acknowledgedBy) ||
                other.acknowledgedBy == acknowledgedBy));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    message,
    level,
    source,
    vehicleId,
    acknowledged,
    createdAt,
    acknowledgedAt,
    acknowledgedBy,
  );

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      __$$AlertImplCopyWithImpl<_$AlertImpl>(this, _$identity);
}

abstract class _Alert implements Alert {
  const factory _Alert({
    required final String id,
    required final String title,
    required final String message,
    required final String level,
    required final String source,
    final String? vehicleId,
    required final bool acknowledged,
    required final DateTime createdAt,
    final DateTime? acknowledgedAt,
    final String? acknowledgedBy,
  }) = _$AlertImpl;

  @override
  String get id; // 告警唯一标识
  @override
  String get title; // 告警标题
  @override
  String get message; // 告警详情
  @override
  String get level; // 告警级别：critical / warning / info
  @override
  String get source; // 告警来源：vehicle / system / safety
  @override
  String? get vehicleId; // 关联车辆 ID（可选）
  @override
  bool get acknowledged; // 是否已确认
  @override
  DateTime get createdAt; // 告警时间
  @override
  DateTime? get acknowledgedAt; // 确认时间
  @override
  String? get acknowledgedBy;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
