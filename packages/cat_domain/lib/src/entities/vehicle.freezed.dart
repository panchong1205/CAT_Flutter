// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Vehicle {
  String get id => throw _privateConstructorUsedError; // 车辆唯一标识
  String get name =>
      throw _privateConstructorUsedError; // 车辆编号 / 名称，如 "CUSTOM-001"
  String get type =>
      throw _privateConstructorUsedError; // 车辆类型：mining_truck / excavator / bulldozer
  double get latitude => throw _privateConstructorUsedError; // 当前纬度
  double get longitude => throw _privateConstructorUsedError; // 当前经度
  double get altitude => throw _privateConstructorUsedError; // 当前海拔 (米)
  double get speed => throw _privateConstructorUsedError; // 当前速度 (km/h)
  double get fuel => throw _privateConstructorUsedError; // 剩余油量百分比 (0-100)
  bool get online => throw _privateConstructorUsedError; // 是否在线
  String get status =>
      throw _privateConstructorUsedError; // 运行状态：idle / moving / loading / dumping / charging
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res, Vehicle>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    double latitude,
    double longitude,
    double altitude,
    double speed,
    double fuel,
    bool online,
    String status,
    DateTime lastUpdated,
  });
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res, $Val extends Vehicle>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitude = null,
    Object? speed = null,
    Object? fuel = null,
    Object? online = null,
    Object? status = null,
    Object? lastUpdated = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            altitude: null == altitude
                ? _value.altitude
                : altitude // ignore: cast_nullable_to_non_nullable
                      as double,
            speed: null == speed
                ? _value.speed
                : speed // ignore: cast_nullable_to_non_nullable
                      as double,
            fuel: null == fuel
                ? _value.fuel
                : fuel // ignore: cast_nullable_to_non_nullable
                      as double,
            online: null == online
                ? _value.online
                : online // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            lastUpdated: null == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VehicleImplCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$$VehicleImplCopyWith(
    _$VehicleImpl value,
    $Res Function(_$VehicleImpl) then,
  ) = __$$VehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    double latitude,
    double longitude,
    double altitude,
    double speed,
    double fuel,
    bool online,
    String status,
    DateTime lastUpdated,
  });
}

/// @nodoc
class __$$VehicleImplCopyWithImpl<$Res>
    extends _$VehicleCopyWithImpl<$Res, _$VehicleImpl>
    implements _$$VehicleImplCopyWith<$Res> {
  __$$VehicleImplCopyWithImpl(
    _$VehicleImpl _value,
    $Res Function(_$VehicleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? altitude = null,
    Object? speed = null,
    Object? fuel = null,
    Object? online = null,
    Object? status = null,
    Object? lastUpdated = null,
  }) {
    return _then(
      _$VehicleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        altitude: null == altitude
            ? _value.altitude
            : altitude // ignore: cast_nullable_to_non_nullable
                  as double,
        speed: null == speed
            ? _value.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as double,
        fuel: null == fuel
            ? _value.fuel
            : fuel // ignore: cast_nullable_to_non_nullable
                  as double,
        online: null == online
            ? _value.online
            : online // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        lastUpdated: null == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$VehicleImpl implements _Vehicle {
  const _$VehicleImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.speed,
    required this.fuel,
    required this.online,
    required this.status,
    required this.lastUpdated,
  });

  @override
  final String id;
  // 车辆唯一标识
  @override
  final String name;
  // 车辆编号 / 名称，如 "CUSTOM-001"
  @override
  final String type;
  // 车辆类型：mining_truck / excavator / bulldozer
  @override
  final double latitude;
  // 当前纬度
  @override
  final double longitude;
  // 当前经度
  @override
  final double altitude;
  // 当前海拔 (米)
  @override
  final double speed;
  // 当前速度 (km/h)
  @override
  final double fuel;
  // 剩余油量百分比 (0-100)
  @override
  final bool online;
  // 是否在线
  @override
  final String status;
  // 运行状态：idle / moving / loading / dumping / charging
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'Vehicle(id: $id, name: $name, type: $type, latitude: $latitude, longitude: $longitude, altitude: $altitude, speed: $speed, fuel: $fuel, online: $online, status: $status, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.fuel, fuel) || other.fuel == fuel) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    latitude,
    longitude,
    altitude,
    speed,
    fuel,
    online,
    status,
    lastUpdated,
  );

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      __$$VehicleImplCopyWithImpl<_$VehicleImpl>(this, _$identity);
}

abstract class _Vehicle implements Vehicle {
  const factory _Vehicle({
    required final String id,
    required final String name,
    required final String type,
    required final double latitude,
    required final double longitude,
    required final double altitude,
    required final double speed,
    required final double fuel,
    required final bool online,
    required final String status,
    required final DateTime lastUpdated,
  }) = _$VehicleImpl;

  @override
  String get id; // 车辆唯一标识
  @override
  String get name; // 车辆编号 / 名称，如 "CUSTOM-001"
  @override
  String get type; // 车辆类型：mining_truck / excavator / bulldozer
  @override
  double get latitude; // 当前纬度
  @override
  double get longitude; // 当前经度
  @override
  double get altitude; // 当前海拔 (米)
  @override
  double get speed; // 当前速度 (km/h)
  @override
  double get fuel; // 剩余油量百分比 (0-100)
  @override
  bool get online; // 是否在线
  @override
  String get status; // 运行状态：idle / moving / loading / dumping / charging
  @override
  DateTime get lastUpdated;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
