// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Device {
  String get id => throw _privateConstructorUsedError; // 设备唯一标识
  String get name => throw _privateConstructorUsedError; // 设备名称
  String get type =>
      throw _privateConstructorUsedError; // 设备类型：sensor / camera / base_station / gateway
  String get status =>
      throw _privateConstructorUsedError; // 设备状态：online / offline / maintenance
  double get latitude => throw _privateConstructorUsedError; // 部署纬度（可选地图定位）
  double get longitude => throw _privateConstructorUsedError; // 部署经度
  DateTime get lastSeen => throw _privateConstructorUsedError; // 最后在线时间
  double? get battery =>
      throw _privateConstructorUsedError; // 电池电量百分比 (0-100)，有电池的设备
  String? get location => throw _privateConstructorUsedError;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceCopyWith<Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceCopyWith<$Res> {
  factory $DeviceCopyWith(Device value, $Res Function(Device) then) =
      _$DeviceCopyWithImpl<$Res, Device>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String status,
    double latitude,
    double longitude,
    DateTime lastSeen,
    double? battery,
    String? location,
  });
}

/// @nodoc
class _$DeviceCopyWithImpl<$Res, $Val extends Device>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? lastSeen = null,
    Object? battery = freezed,
    Object? location = freezed,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            lastSeen: null == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            battery: freezed == battery
                ? _value.battery
                : battery // ignore: cast_nullable_to_non_nullable
                      as double?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceImplCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$$DeviceImplCopyWith(
    _$DeviceImpl value,
    $Res Function(_$DeviceImpl) then,
  ) = __$$DeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String status,
    double latitude,
    double longitude,
    DateTime lastSeen,
    double? battery,
    String? location,
  });
}

/// @nodoc
class __$$DeviceImplCopyWithImpl<$Res>
    extends _$DeviceCopyWithImpl<$Res, _$DeviceImpl>
    implements _$$DeviceImplCopyWith<$Res> {
  __$$DeviceImplCopyWithImpl(
    _$DeviceImpl _value,
    $Res Function(_$DeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? lastSeen = null,
    Object? battery = freezed,
    Object? location = freezed,
  }) {
    return _then(
      _$DeviceImpl(
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
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        lastSeen: null == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        battery: freezed == battery
            ? _value.battery
            : battery // ignore: cast_nullable_to_non_nullable
                  as double?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DeviceImpl implements _Device {
  const _$DeviceImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.lastSeen,
    this.battery,
    this.location,
  });

  @override
  final String id;
  // 设备唯一标识
  @override
  final String name;
  // 设备名称
  @override
  final String type;
  // 设备类型：sensor / camera / base_station / gateway
  @override
  final String status;
  // 设备状态：online / offline / maintenance
  @override
  final double latitude;
  // 部署纬度（可选地图定位）
  @override
  final double longitude;
  // 部署经度
  @override
  final DateTime lastSeen;
  // 最后在线时间
  @override
  final double? battery;
  // 电池电量百分比 (0-100)，有电池的设备
  @override
  final String? location;

  @override
  String toString() {
    return 'Device(id: $id, name: $name, type: $type, status: $status, latitude: $latitude, longitude: $longitude, lastSeen: $lastSeen, battery: $battery, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.battery, battery) || other.battery == battery) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    status,
    latitude,
    longitude,
    lastSeen,
    battery,
    location,
  );

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      __$$DeviceImplCopyWithImpl<_$DeviceImpl>(this, _$identity);
}

abstract class _Device implements Device {
  const factory _Device({
    required final String id,
    required final String name,
    required final String type,
    required final String status,
    required final double latitude,
    required final double longitude,
    required final DateTime lastSeen,
    final double? battery,
    final String? location,
  }) = _$DeviceImpl;

  @override
  String get id; // 设备唯一标识
  @override
  String get name; // 设备名称
  @override
  String get type; // 设备类型：sensor / camera / base_station / gateway
  @override
  String get status; // 设备状态：online / offline / maintenance
  @override
  double get latitude; // 部署纬度（可选地图定位）
  @override
  double get longitude; // 部署经度
  @override
  DateTime get lastSeen; // 最后在线时间
  @override
  double? get battery; // 电池电量百分比 (0-100)，有电池的设备
  @override
  String? get location;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
