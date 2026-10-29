// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Mission {
  String get id => throw _privateConstructorUsedError; // 任务唯一标识
  String get name => throw _privateConstructorUsedError; // 任务名称
  String get vehicleId => throw _privateConstructorUsedError; // 分配的车辆 ID
  String get status =>
      throw _privateConstructorUsedError; // 任务状态：pending / in_progress / completed / cancelled
  String get loadPoint => throw _privateConstructorUsedError; // 装载点名称
  String get unloadPoint => throw _privateConstructorUsedError; // 卸载点名称
  double get targetLoad => throw _privateConstructorUsedError; // 目标装载量 (吨)
  double get currentLoad => throw _privateConstructorUsedError; // 当前装载量 (吨)
  DateTime get createdAt => throw _privateConstructorUsedError; // 任务创建时间
  DateTime? get startedAt => throw _privateConstructorUsedError; // 开始时间
  DateTime? get completedAt => throw _privateConstructorUsedError; // 完成时间
  String? get priority => throw _privateConstructorUsedError;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call({
    String id,
    String name,
    String vehicleId,
    String status,
    String loadPoint,
    String unloadPoint,
    double targetLoad,
    double currentLoad,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? priority,
  });
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? vehicleId = null,
    Object? status = null,
    Object? loadPoint = null,
    Object? unloadPoint = null,
    Object? targetLoad = null,
    Object? currentLoad = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? priority = freezed,
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
            vehicleId: null == vehicleId
                ? _value.vehicleId
                : vehicleId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            loadPoint: null == loadPoint
                ? _value.loadPoint
                : loadPoint // ignore: cast_nullable_to_non_nullable
                      as String,
            unloadPoint: null == unloadPoint
                ? _value.unloadPoint
                : unloadPoint // ignore: cast_nullable_to_non_nullable
                      as String,
            targetLoad: null == targetLoad
                ? _value.targetLoad
                : targetLoad // ignore: cast_nullable_to_non_nullable
                      as double,
            currentLoad: null == currentLoad
                ? _value.currentLoad
                : currentLoad // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            priority: freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
    _$MissionImpl value,
    $Res Function(_$MissionImpl) then,
  ) = __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String vehicleId,
    String status,
    String loadPoint,
    String unloadPoint,
    double targetLoad,
    double currentLoad,
    DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? priority,
  });
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
    _$MissionImpl _value,
    $Res Function(_$MissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? vehicleId = null,
    Object? status = null,
    Object? loadPoint = null,
    Object? unloadPoint = null,
    Object? targetLoad = null,
    Object? currentLoad = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? priority = freezed,
  }) {
    return _then(
      _$MissionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleId: null == vehicleId
            ? _value.vehicleId
            : vehicleId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        loadPoint: null == loadPoint
            ? _value.loadPoint
            : loadPoint // ignore: cast_nullable_to_non_nullable
                  as String,
        unloadPoint: null == unloadPoint
            ? _value.unloadPoint
            : unloadPoint // ignore: cast_nullable_to_non_nullable
                  as String,
        targetLoad: null == targetLoad
            ? _value.targetLoad
            : targetLoad // ignore: cast_nullable_to_non_nullable
                  as double,
        currentLoad: null == currentLoad
            ? _value.currentLoad
            : currentLoad // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        priority: freezed == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MissionImpl implements _Mission {
  const _$MissionImpl({
    required this.id,
    required this.name,
    required this.vehicleId,
    required this.status,
    required this.loadPoint,
    required this.unloadPoint,
    required this.targetLoad,
    required this.currentLoad,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.priority,
  });

  @override
  final String id;
  // 任务唯一标识
  @override
  final String name;
  // 任务名称
  @override
  final String vehicleId;
  // 分配的车辆 ID
  @override
  final String status;
  // 任务状态：pending / in_progress / completed / cancelled
  @override
  final String loadPoint;
  // 装载点名称
  @override
  final String unloadPoint;
  // 卸载点名称
  @override
  final double targetLoad;
  // 目标装载量 (吨)
  @override
  final double currentLoad;
  // 当前装载量 (吨)
  @override
  final DateTime createdAt;
  // 任务创建时间
  @override
  final DateTime? startedAt;
  // 开始时间
  @override
  final DateTime? completedAt;
  // 完成时间
  @override
  final String? priority;

  @override
  String toString() {
    return 'Mission(id: $id, name: $name, vehicleId: $vehicleId, status: $status, loadPoint: $loadPoint, unloadPoint: $unloadPoint, targetLoad: $targetLoad, currentLoad: $currentLoad, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.loadPoint, loadPoint) ||
                other.loadPoint == loadPoint) &&
            (identical(other.unloadPoint, unloadPoint) ||
                other.unloadPoint == unloadPoint) &&
            (identical(other.targetLoad, targetLoad) ||
                other.targetLoad == targetLoad) &&
            (identical(other.currentLoad, currentLoad) ||
                other.currentLoad == currentLoad) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    vehicleId,
    status,
    loadPoint,
    unloadPoint,
    targetLoad,
    currentLoad,
    createdAt,
    startedAt,
    completedAt,
    priority,
  );

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);
}

abstract class _Mission implements Mission {
  const factory _Mission({
    required final String id,
    required final String name,
    required final String vehicleId,
    required final String status,
    required final String loadPoint,
    required final String unloadPoint,
    required final double targetLoad,
    required final double currentLoad,
    required final DateTime createdAt,
    final DateTime? startedAt,
    final DateTime? completedAt,
    final String? priority,
  }) = _$MissionImpl;

  @override
  String get id; // 任务唯一标识
  @override
  String get name; // 任务名称
  @override
  String get vehicleId; // 分配的车辆 ID
  @override
  String get status; // 任务状态：pending / in_progress / completed / cancelled
  @override
  String get loadPoint; // 装载点名称
  @override
  String get unloadPoint; // 卸载点名称
  @override
  double get targetLoad; // 目标装载量 (吨)
  @override
  double get currentLoad; // 当前装载量 (吨)
  @override
  DateTime get createdAt; // 任务创建时间
  @override
  DateTime? get startedAt; // 开始时间
  @override
  DateTime? get completedAt; // 完成时间
  @override
  String? get priority;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
