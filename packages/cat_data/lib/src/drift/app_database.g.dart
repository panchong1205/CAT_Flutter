// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VehiclesTable extends Vehicles
    with TableInfo<$VehiclesTable, DriftVehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _altitudeMeta =
      const VerificationMeta('altitude');
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
      'altitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fuelMeta = const VerificationMeta('fuel');
  @override
  late final GeneratedColumn<double> fuel = GeneratedColumn<double>(
      'fuel', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _onlineMeta = const VerificationMeta('online');
  @override
  late final GeneratedColumn<bool> online = GeneratedColumn<bool>(
      'online', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("online" IN (0, 1))'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<int> lastUpdated = GeneratedColumn<int>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
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
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<DriftVehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    } else if (isInserting) {
      context.missing(_altitudeMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('fuel')) {
      context.handle(
          _fuelMeta, fuel.isAcceptableOrUnknown(data['fuel']!, _fuelMeta));
    } else if (isInserting) {
      context.missing(_fuelMeta);
    }
    if (data.containsKey('online')) {
      context.handle(_onlineMeta,
          online.isAcceptableOrUnknown(data['online']!, _onlineMeta));
    } else if (isInserting) {
      context.missing(_onlineMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftVehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftVehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      altitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}altitude'])!,
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed'])!,
      fuel: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fuel'])!,
      online: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}online'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class DriftVehicle extends DataClass implements Insertable<DriftVehicle> {
  final String id;
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final double altitude;
  final double speed;
  final double fuel;
  final bool online;
  final String status;
  final int lastUpdated;
  const DriftVehicle(
      {required this.id,
      required this.name,
      required this.type,
      required this.latitude,
      required this.longitude,
      required this.altitude,
      required this.speed,
      required this.fuel,
      required this.online,
      required this.status,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['altitude'] = Variable<double>(altitude);
    map['speed'] = Variable<double>(speed);
    map['fuel'] = Variable<double>(fuel);
    map['online'] = Variable<bool>(online);
    map['status'] = Variable<String>(status);
    map['last_updated'] = Variable<int>(lastUpdated);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitude: Value(altitude),
      speed: Value(speed),
      fuel: Value(fuel),
      online: Value(online),
      status: Value(status),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory DriftVehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftVehicle(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      altitude: serializer.fromJson<double>(json['altitude']),
      speed: serializer.fromJson<double>(json['speed']),
      fuel: serializer.fromJson<double>(json['fuel']),
      online: serializer.fromJson<bool>(json['online']),
      status: serializer.fromJson<String>(json['status']),
      lastUpdated: serializer.fromJson<int>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'altitude': serializer.toJson<double>(altitude),
      'speed': serializer.toJson<double>(speed),
      'fuel': serializer.toJson<double>(fuel),
      'online': serializer.toJson<bool>(online),
      'status': serializer.toJson<String>(status),
      'lastUpdated': serializer.toJson<int>(lastUpdated),
    };
  }

  DriftVehicle copyWith(
          {String? id,
          String? name,
          String? type,
          double? latitude,
          double? longitude,
          double? altitude,
          double? speed,
          double? fuel,
          bool? online,
          String? status,
          int? lastUpdated}) =>
      DriftVehicle(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        altitude: altitude ?? this.altitude,
        speed: speed ?? this.speed,
        fuel: fuel ?? this.fuel,
        online: online ?? this.online,
        status: status ?? this.status,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  DriftVehicle copyWithCompanion(VehiclesCompanion data) {
    return DriftVehicle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      speed: data.speed.present ? data.speed.value : this.speed,
      fuel: data.fuel.present ? data.fuel.value : this.fuel,
      online: data.online.present ? data.online.value : this.online,
      status: data.status.present ? data.status.value : this.status,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftVehicle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speed: $speed, ')
          ..write('fuel: $fuel, ')
          ..write('online: $online, ')
          ..write('status: $status, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, latitude, longitude, altitude,
      speed, fuel, online, status, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftVehicle &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitude == this.altitude &&
          other.speed == this.speed &&
          other.fuel == this.fuel &&
          other.online == this.online &&
          other.status == this.status &&
          other.lastUpdated == this.lastUpdated);
}

class VehiclesCompanion extends UpdateCompanion<DriftVehicle> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> altitude;
  final Value<double> speed;
  final Value<double> fuel;
  final Value<bool> online;
  final Value<String> status;
  final Value<int> lastUpdated;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitude = const Value.absent(),
    this.speed = const Value.absent(),
    this.fuel = const Value.absent(),
    this.online = const Value.absent(),
    this.status = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String name,
    required String type,
    required double latitude,
    required double longitude,
    required double altitude,
    required double speed,
    required double fuel,
    required bool online,
    required String status,
    required int lastUpdated,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        latitude = Value(latitude),
        longitude = Value(longitude),
        altitude = Value(altitude),
        speed = Value(speed),
        fuel = Value(fuel),
        online = Value(online),
        status = Value(status),
        lastUpdated = Value(lastUpdated);
  static Insertable<DriftVehicle> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitude,
    Expression<double>? speed,
    Expression<double>? fuel,
    Expression<bool>? online,
    Expression<String>? status,
    Expression<int>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitude != null) 'altitude': altitude,
      if (speed != null) 'speed': speed,
      if (fuel != null) 'fuel': fuel,
      if (online != null) 'online': online,
      if (status != null) 'status': status,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double>? altitude,
      Value<double>? speed,
      Value<double>? fuel,
      Value<bool>? online,
      Value<String>? status,
      Value<int>? lastUpdated,
      Value<int>? rowid}) {
    return VehiclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      speed: speed ?? this.speed,
      fuel: fuel ?? this.fuel,
      online: online ?? this.online,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (fuel.present) {
      map['fuel'] = Variable<double>(fuel.value);
    }
    if (online.present) {
      map['online'] = Variable<bool>(online.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<int>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitude: $altitude, ')
          ..write('speed: $speed, ')
          ..write('fuel: $fuel, ')
          ..write('online: $online, ')
          ..write('status: $status, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissionsTable extends Missions
    with TableInfo<$MissionsTable, DriftMission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
      'vehicle_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loadPointMeta =
      const VerificationMeta('loadPoint');
  @override
  late final GeneratedColumn<String> loadPoint = GeneratedColumn<String>(
      'load_point', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unloadPointMeta =
      const VerificationMeta('unloadPoint');
  @override
  late final GeneratedColumn<String> unloadPoint = GeneratedColumn<String>(
      'unload_point', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetLoadMeta =
      const VerificationMeta('targetLoad');
  @override
  late final GeneratedColumn<double> targetLoad = GeneratedColumn<double>(
      'target_load', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentLoadMeta =
      const VerificationMeta('currentLoad');
  @override
  late final GeneratedColumn<double> currentLoad = GeneratedColumn<double>(
      'current_load', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
      'started_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
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
        priority
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'missions';
  @override
  VerificationContext validateIntegrity(Insertable<DriftMission> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('load_point')) {
      context.handle(_loadPointMeta,
          loadPoint.isAcceptableOrUnknown(data['load_point']!, _loadPointMeta));
    } else if (isInserting) {
      context.missing(_loadPointMeta);
    }
    if (data.containsKey('unload_point')) {
      context.handle(
          _unloadPointMeta,
          unloadPoint.isAcceptableOrUnknown(
              data['unload_point']!, _unloadPointMeta));
    } else if (isInserting) {
      context.missing(_unloadPointMeta);
    }
    if (data.containsKey('target_load')) {
      context.handle(
          _targetLoadMeta,
          targetLoad.isAcceptableOrUnknown(
              data['target_load']!, _targetLoadMeta));
    } else if (isInserting) {
      context.missing(_targetLoadMeta);
    }
    if (data.containsKey('current_load')) {
      context.handle(
          _currentLoadMeta,
          currentLoad.isAcceptableOrUnknown(
              data['current_load']!, _currentLoadMeta));
    } else if (isInserting) {
      context.missing(_currentLoadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftMission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftMission(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      loadPoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}load_point'])!,
      unloadPoint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unload_point'])!,
      targetLoad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_load'])!,
      currentLoad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_load'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}started_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_at']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority']),
    );
  }

  @override
  $MissionsTable createAlias(String alias) {
    return $MissionsTable(attachedDatabase, alias);
  }
}

class DriftMission extends DataClass implements Insertable<DriftMission> {
  final String id;
  final String name;
  final String vehicleId;
  final String status;
  final String loadPoint;
  final String unloadPoint;
  final double targetLoad;
  final double currentLoad;
  final int createdAt;
  final int? startedAt;
  final int? completedAt;
  final String? priority;
  const DriftMission(
      {required this.id,
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
      this.priority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['status'] = Variable<String>(status);
    map['load_point'] = Variable<String>(loadPoint);
    map['unload_point'] = Variable<String>(unloadPoint);
    map['target_load'] = Variable<double>(targetLoad);
    map['current_load'] = Variable<double>(currentLoad);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<int>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<String>(priority);
    }
    return map;
  }

  MissionsCompanion toCompanion(bool nullToAbsent) {
    return MissionsCompanion(
      id: Value(id),
      name: Value(name),
      vehicleId: Value(vehicleId),
      status: Value(status),
      loadPoint: Value(loadPoint),
      unloadPoint: Value(unloadPoint),
      targetLoad: Value(targetLoad),
      currentLoad: Value(currentLoad),
      createdAt: Value(createdAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
    );
  }

  factory DriftMission.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftMission(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      status: serializer.fromJson<String>(json['status']),
      loadPoint: serializer.fromJson<String>(json['loadPoint']),
      unloadPoint: serializer.fromJson<String>(json['unloadPoint']),
      targetLoad: serializer.fromJson<double>(json['targetLoad']),
      currentLoad: serializer.fromJson<double>(json['currentLoad']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      startedAt: serializer.fromJson<int?>(json['startedAt']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      priority: serializer.fromJson<String?>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'status': serializer.toJson<String>(status),
      'loadPoint': serializer.toJson<String>(loadPoint),
      'unloadPoint': serializer.toJson<String>(unloadPoint),
      'targetLoad': serializer.toJson<double>(targetLoad),
      'currentLoad': serializer.toJson<double>(currentLoad),
      'createdAt': serializer.toJson<int>(createdAt),
      'startedAt': serializer.toJson<int?>(startedAt),
      'completedAt': serializer.toJson<int?>(completedAt),
      'priority': serializer.toJson<String?>(priority),
    };
  }

  DriftMission copyWith(
          {String? id,
          String? name,
          String? vehicleId,
          String? status,
          String? loadPoint,
          String? unloadPoint,
          double? targetLoad,
          double? currentLoad,
          int? createdAt,
          Value<int?> startedAt = const Value.absent(),
          Value<int?> completedAt = const Value.absent(),
          Value<String?> priority = const Value.absent()}) =>
      DriftMission(
        id: id ?? this.id,
        name: name ?? this.name,
        vehicleId: vehicleId ?? this.vehicleId,
        status: status ?? this.status,
        loadPoint: loadPoint ?? this.loadPoint,
        unloadPoint: unloadPoint ?? this.unloadPoint,
        targetLoad: targetLoad ?? this.targetLoad,
        currentLoad: currentLoad ?? this.currentLoad,
        createdAt: createdAt ?? this.createdAt,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        priority: priority.present ? priority.value : this.priority,
      );
  DriftMission copyWithCompanion(MissionsCompanion data) {
    return DriftMission(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      status: data.status.present ? data.status.value : this.status,
      loadPoint: data.loadPoint.present ? data.loadPoint.value : this.loadPoint,
      unloadPoint:
          data.unloadPoint.present ? data.unloadPoint.value : this.unloadPoint,
      targetLoad:
          data.targetLoad.present ? data.targetLoad.value : this.targetLoad,
      currentLoad:
          data.currentLoad.present ? data.currentLoad.value : this.currentLoad,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftMission(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('status: $status, ')
          ..write('loadPoint: $loadPoint, ')
          ..write('unloadPoint: $unloadPoint, ')
          ..write('targetLoad: $targetLoad, ')
          ..write('currentLoad: $currentLoad, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
      priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftMission &&
          other.id == this.id &&
          other.name == this.name &&
          other.vehicleId == this.vehicleId &&
          other.status == this.status &&
          other.loadPoint == this.loadPoint &&
          other.unloadPoint == this.unloadPoint &&
          other.targetLoad == this.targetLoad &&
          other.currentLoad == this.currentLoad &&
          other.createdAt == this.createdAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.priority == this.priority);
}

class MissionsCompanion extends UpdateCompanion<DriftMission> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> vehicleId;
  final Value<String> status;
  final Value<String> loadPoint;
  final Value<String> unloadPoint;
  final Value<double> targetLoad;
  final Value<double> currentLoad;
  final Value<int> createdAt;
  final Value<int?> startedAt;
  final Value<int?> completedAt;
  final Value<String?> priority;
  final Value<int> rowid;
  const MissionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.status = const Value.absent(),
    this.loadPoint = const Value.absent(),
    this.unloadPoint = const Value.absent(),
    this.targetLoad = const Value.absent(),
    this.currentLoad = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MissionsCompanion.insert({
    required String id,
    required String name,
    required String vehicleId,
    required String status,
    required String loadPoint,
    required String unloadPoint,
    required double targetLoad,
    required double currentLoad,
    required int createdAt,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        vehicleId = Value(vehicleId),
        status = Value(status),
        loadPoint = Value(loadPoint),
        unloadPoint = Value(unloadPoint),
        targetLoad = Value(targetLoad),
        currentLoad = Value(currentLoad),
        createdAt = Value(createdAt);
  static Insertable<DriftMission> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? vehicleId,
    Expression<String>? status,
    Expression<String>? loadPoint,
    Expression<String>? unloadPoint,
    Expression<double>? targetLoad,
    Expression<double>? currentLoad,
    Expression<int>? createdAt,
    Expression<int>? startedAt,
    Expression<int>? completedAt,
    Expression<String>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (status != null) 'status': status,
      if (loadPoint != null) 'load_point': loadPoint,
      if (unloadPoint != null) 'unload_point': unloadPoint,
      if (targetLoad != null) 'target_load': targetLoad,
      if (currentLoad != null) 'current_load': currentLoad,
      if (createdAt != null) 'created_at': createdAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MissionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? vehicleId,
      Value<String>? status,
      Value<String>? loadPoint,
      Value<String>? unloadPoint,
      Value<double>? targetLoad,
      Value<double>? currentLoad,
      Value<int>? createdAt,
      Value<int?>? startedAt,
      Value<int?>? completedAt,
      Value<String?>? priority,
      Value<int>? rowid}) {
    return MissionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      vehicleId: vehicleId ?? this.vehicleId,
      status: status ?? this.status,
      loadPoint: loadPoint ?? this.loadPoint,
      unloadPoint: unloadPoint ?? this.unloadPoint,
      targetLoad: targetLoad ?? this.targetLoad,
      currentLoad: currentLoad ?? this.currentLoad,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (loadPoint.present) {
      map['load_point'] = Variable<String>(loadPoint.value);
    }
    if (unloadPoint.present) {
      map['unload_point'] = Variable<String>(unloadPoint.value);
    }
    if (targetLoad.present) {
      map['target_load'] = Variable<double>(targetLoad.value);
    }
    if (currentLoad.present) {
      map['current_load'] = Variable<double>(currentLoad.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('status: $status, ')
          ..write('loadPoint: $loadPoint, ')
          ..write('unloadPoint: $unloadPoint, ')
          ..write('targetLoad: $targetLoad, ')
          ..write('currentLoad: $currentLoad, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlertsTable extends Alerts with TableInfo<$AlertsTable, DriftAlert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
      'vehicle_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _acknowledgedMeta =
      const VerificationMeta('acknowledged');
  @override
  late final GeneratedColumn<bool> acknowledged = GeneratedColumn<bool>(
      'acknowledged', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("acknowledged" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _acknowledgedAtMeta =
      const VerificationMeta('acknowledgedAt');
  @override
  late final GeneratedColumn<int> acknowledgedAt = GeneratedColumn<int>(
      'acknowledged_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _acknowledgedByMeta =
      const VerificationMeta('acknowledgedBy');
  @override
  late final GeneratedColumn<String> acknowledgedBy = GeneratedColumn<String>(
      'acknowledged_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        message,
        level,
        source,
        vehicleId,
        acknowledged,
        createdAt,
        acknowledgedAt,
        acknowledgedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alerts';
  @override
  VerificationContext validateIntegrity(Insertable<DriftAlert> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    }
    if (data.containsKey('acknowledged')) {
      context.handle(
          _acknowledgedMeta,
          acknowledged.isAcceptableOrUnknown(
              data['acknowledged']!, _acknowledgedMeta));
    } else if (isInserting) {
      context.missing(_acknowledgedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('acknowledged_at')) {
      context.handle(
          _acknowledgedAtMeta,
          acknowledgedAt.isAcceptableOrUnknown(
              data['acknowledged_at']!, _acknowledgedAtMeta));
    }
    if (data.containsKey('acknowledged_by')) {
      context.handle(
          _acknowledgedByMeta,
          acknowledgedBy.isAcceptableOrUnknown(
              data['acknowledged_by']!, _acknowledgedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftAlert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftAlert(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_id']),
      acknowledged: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}acknowledged'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      acknowledgedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acknowledged_at']),
      acknowledgedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}acknowledged_by']),
    );
  }

  @override
  $AlertsTable createAlias(String alias) {
    return $AlertsTable(attachedDatabase, alias);
  }
}

class DriftAlert extends DataClass implements Insertable<DriftAlert> {
  final String id;
  final String title;
  final String message;
  final String level;
  final String source;
  final String? vehicleId;
  final bool acknowledged;
  final int createdAt;
  final int? acknowledgedAt;
  final String? acknowledgedBy;
  const DriftAlert(
      {required this.id,
      required this.title,
      required this.message,
      required this.level,
      required this.source,
      this.vehicleId,
      required this.acknowledged,
      required this.createdAt,
      this.acknowledgedAt,
      this.acknowledgedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['level'] = Variable<String>(level);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || vehicleId != null) {
      map['vehicle_id'] = Variable<String>(vehicleId);
    }
    map['acknowledged'] = Variable<bool>(acknowledged);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || acknowledgedAt != null) {
      map['acknowledged_at'] = Variable<int>(acknowledgedAt);
    }
    if (!nullToAbsent || acknowledgedBy != null) {
      map['acknowledged_by'] = Variable<String>(acknowledgedBy);
    }
    return map;
  }

  AlertsCompanion toCompanion(bool nullToAbsent) {
    return AlertsCompanion(
      id: Value(id),
      title: Value(title),
      message: Value(message),
      level: Value(level),
      source: Value(source),
      vehicleId: vehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleId),
      acknowledged: Value(acknowledged),
      createdAt: Value(createdAt),
      acknowledgedAt: acknowledgedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedAt),
      acknowledgedBy: acknowledgedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedBy),
    );
  }

  factory DriftAlert.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftAlert(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      level: serializer.fromJson<String>(json['level']),
      source: serializer.fromJson<String>(json['source']),
      vehicleId: serializer.fromJson<String?>(json['vehicleId']),
      acknowledged: serializer.fromJson<bool>(json['acknowledged']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      acknowledgedAt: serializer.fromJson<int?>(json['acknowledgedAt']),
      acknowledgedBy: serializer.fromJson<String?>(json['acknowledgedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'level': serializer.toJson<String>(level),
      'source': serializer.toJson<String>(source),
      'vehicleId': serializer.toJson<String?>(vehicleId),
      'acknowledged': serializer.toJson<bool>(acknowledged),
      'createdAt': serializer.toJson<int>(createdAt),
      'acknowledgedAt': serializer.toJson<int?>(acknowledgedAt),
      'acknowledgedBy': serializer.toJson<String?>(acknowledgedBy),
    };
  }

  DriftAlert copyWith(
          {String? id,
          String? title,
          String? message,
          String? level,
          String? source,
          Value<String?> vehicleId = const Value.absent(),
          bool? acknowledged,
          int? createdAt,
          Value<int?> acknowledgedAt = const Value.absent(),
          Value<String?> acknowledgedBy = const Value.absent()}) =>
      DriftAlert(
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
        level: level ?? this.level,
        source: source ?? this.source,
        vehicleId: vehicleId.present ? vehicleId.value : this.vehicleId,
        acknowledged: acknowledged ?? this.acknowledged,
        createdAt: createdAt ?? this.createdAt,
        acknowledgedAt:
            acknowledgedAt.present ? acknowledgedAt.value : this.acknowledgedAt,
        acknowledgedBy:
            acknowledgedBy.present ? acknowledgedBy.value : this.acknowledgedBy,
      );
  DriftAlert copyWithCompanion(AlertsCompanion data) {
    return DriftAlert(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      level: data.level.present ? data.level.value : this.level,
      source: data.source.present ? data.source.value : this.source,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      acknowledged: data.acknowledged.present
          ? data.acknowledged.value
          : this.acknowledged,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      acknowledgedAt: data.acknowledgedAt.present
          ? data.acknowledgedAt.value
          : this.acknowledgedAt,
      acknowledgedBy: data.acknowledgedBy.present
          ? data.acknowledgedBy.value
          : this.acknowledgedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftAlert(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('level: $level, ')
          ..write('source: $source, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('acknowledged: $acknowledged, ')
          ..write('createdAt: $createdAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('acknowledgedBy: $acknowledgedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, message, level, source, vehicleId,
      acknowledged, createdAt, acknowledgedAt, acknowledgedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftAlert &&
          other.id == this.id &&
          other.title == this.title &&
          other.message == this.message &&
          other.level == this.level &&
          other.source == this.source &&
          other.vehicleId == this.vehicleId &&
          other.acknowledged == this.acknowledged &&
          other.createdAt == this.createdAt &&
          other.acknowledgedAt == this.acknowledgedAt &&
          other.acknowledgedBy == this.acknowledgedBy);
}

class AlertsCompanion extends UpdateCompanion<DriftAlert> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> message;
  final Value<String> level;
  final Value<String> source;
  final Value<String?> vehicleId;
  final Value<bool> acknowledged;
  final Value<int> createdAt;
  final Value<int?> acknowledgedAt;
  final Value<String?> acknowledgedBy;
  final Value<int> rowid;
  const AlertsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.level = const Value.absent(),
    this.source = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.acknowledged = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.acknowledgedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlertsCompanion.insert({
    required String id,
    required String title,
    required String message,
    required String level,
    required String source,
    this.vehicleId = const Value.absent(),
    required bool acknowledged,
    required int createdAt,
    this.acknowledgedAt = const Value.absent(),
    this.acknowledgedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        message = Value(message),
        level = Value(level),
        source = Value(source),
        acknowledged = Value(acknowledged),
        createdAt = Value(createdAt);
  static Insertable<DriftAlert> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? level,
    Expression<String>? source,
    Expression<String>? vehicleId,
    Expression<bool>? acknowledged,
    Expression<int>? createdAt,
    Expression<int>? acknowledgedAt,
    Expression<String>? acknowledgedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (level != null) 'level': level,
      if (source != null) 'source': source,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (acknowledged != null) 'acknowledged': acknowledged,
      if (createdAt != null) 'created_at': createdAt,
      if (acknowledgedAt != null) 'acknowledged_at': acknowledgedAt,
      if (acknowledgedBy != null) 'acknowledged_by': acknowledgedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlertsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? message,
      Value<String>? level,
      Value<String>? source,
      Value<String?>? vehicleId,
      Value<bool>? acknowledged,
      Value<int>? createdAt,
      Value<int?>? acknowledgedAt,
      Value<String?>? acknowledgedBy,
      Value<int>? rowid}) {
    return AlertsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      level: level ?? this.level,
      source: source ?? this.source,
      vehicleId: vehicleId ?? this.vehicleId,
      acknowledged: acknowledged ?? this.acknowledged,
      createdAt: createdAt ?? this.createdAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      acknowledgedBy: acknowledgedBy ?? this.acknowledgedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (acknowledged.present) {
      map['acknowledged'] = Variable<bool>(acknowledged.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (acknowledgedAt.present) {
      map['acknowledged_at'] = Variable<int>(acknowledgedAt.value);
    }
    if (acknowledgedBy.present) {
      map['acknowledged_by'] = Variable<String>(acknowledgedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('level: $level, ')
          ..write('source: $source, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('acknowledged: $acknowledged, ')
          ..write('createdAt: $createdAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('acknowledgedBy: $acknowledgedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, DriftDevice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _onlineMeta = const VerificationMeta('online');
  @override
  late final GeneratedColumn<bool> online = GeneratedColumn<bool>(
      'online', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("online" IN (0, 1))'));
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lastSeenMeta =
      const VerificationMeta('lastSeen');
  @override
  late final GeneratedColumn<int> lastSeen = GeneratedColumn<int>(
      'last_seen', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _batteryMeta =
      const VerificationMeta('battery');
  @override
  late final GeneratedColumn<double> battery = GeneratedColumn<double>(
      'battery', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        online,
        latitude,
        longitude,
        lastSeen,
        battery,
        location
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(Insertable<DriftDevice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('online')) {
      context.handle(_onlineMeta,
          online.isAcceptableOrUnknown(data['online']!, _onlineMeta));
    } else if (isInserting) {
      context.missing(_onlineMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('last_seen')) {
      context.handle(_lastSeenMeta,
          lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta));
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    if (data.containsKey('battery')) {
      context.handle(_batteryMeta,
          battery.isAcceptableOrUnknown(data['battery']!, _batteryMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftDevice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftDevice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      online: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}online'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      lastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_seen'])!,
      battery: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}battery']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class DriftDevice extends DataClass implements Insertable<DriftDevice> {
  final String id;
  final String name;
  final String type;
  final bool online;
  final double latitude;
  final double longitude;
  final int lastSeen;
  final double? battery;
  final String? location;
  const DriftDevice(
      {required this.id,
      required this.name,
      required this.type,
      required this.online,
      required this.latitude,
      required this.longitude,
      required this.lastSeen,
      this.battery,
      this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['online'] = Variable<bool>(online);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['last_seen'] = Variable<int>(lastSeen);
    if (!nullToAbsent || battery != null) {
      map['battery'] = Variable<double>(battery);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      online: Value(online),
      latitude: Value(latitude),
      longitude: Value(longitude),
      lastSeen: Value(lastSeen),
      battery: battery == null && nullToAbsent
          ? const Value.absent()
          : Value(battery),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
    );
  }

  factory DriftDevice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftDevice(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      online: serializer.fromJson<bool>(json['online']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      lastSeen: serializer.fromJson<int>(json['lastSeen']),
      battery: serializer.fromJson<double?>(json['battery']),
      location: serializer.fromJson<String?>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'online': serializer.toJson<bool>(online),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'lastSeen': serializer.toJson<int>(lastSeen),
      'battery': serializer.toJson<double?>(battery),
      'location': serializer.toJson<String?>(location),
    };
  }

  DriftDevice copyWith(
          {String? id,
          String? name,
          String? type,
          bool? online,
          double? latitude,
          double? longitude,
          int? lastSeen,
          Value<double?> battery = const Value.absent(),
          Value<String?> location = const Value.absent()}) =>
      DriftDevice(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        online: online ?? this.online,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        lastSeen: lastSeen ?? this.lastSeen,
        battery: battery.present ? battery.value : this.battery,
        location: location.present ? location.value : this.location,
      );
  DriftDevice copyWithCompanion(DevicesCompanion data) {
    return DriftDevice(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      online: data.online.present ? data.online.value : this.online,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      battery: data.battery.present ? data.battery.value : this.battery,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftDevice(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('online: $online, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('battery: $battery, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, type, online, latitude, longitude, lastSeen, battery, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftDevice &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.online == this.online &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.lastSeen == this.lastSeen &&
          other.battery == this.battery &&
          other.location == this.location);
}

class DevicesCompanion extends UpdateCompanion<DriftDevice> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> online;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<int> lastSeen;
  final Value<double?> battery;
  final Value<String?> location;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.online = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.battery = const Value.absent(),
    this.location = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String name,
    required String type,
    required bool online,
    required double latitude,
    required double longitude,
    required int lastSeen,
    this.battery = const Value.absent(),
    this.location = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        online = Value(online),
        latitude = Value(latitude),
        longitude = Value(longitude),
        lastSeen = Value(lastSeen);
  static Insertable<DriftDevice> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? online,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? lastSeen,
    Expression<double>? battery,
    Expression<String>? location,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (online != null) 'online': online,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (battery != null) 'battery': battery,
      if (location != null) 'location': location,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<bool>? online,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<int>? lastSeen,
      Value<double?>? battery,
      Value<String?>? location,
      Value<int>? rowid}) {
    return DevicesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      online: online ?? this.online,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastSeen: lastSeen ?? this.lastSeen,
      battery: battery ?? this.battery,
      location: location ?? this.location,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (online.present) {
      map['online'] = Variable<bool>(online.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<int>(lastSeen.value);
    }
    if (battery.present) {
      map['battery'] = Variable<double>(battery.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('online: $online, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('battery: $battery, ')
          ..write('location: $location, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, DriftSyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _operationTypeMeta =
      const VerificationMeta('operationType');
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
      'operation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _retriesMeta =
      const VerificationMeta('retries');
  @override
  late final GeneratedColumn<int> retries = GeneratedColumn<int>(
      'retries', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, operationType, payload, createdAt, retries, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(Insertable<DriftSyncQueueItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
          _operationTypeMeta,
          operationType.isAcceptableOrUnknown(
              data['operation_type']!, _operationTypeMeta));
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retries')) {
      context.handle(_retriesMeta,
          retries.isAcceptableOrUnknown(data['retries']!, _retriesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftSyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftSyncQueueItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      operationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_type'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      retries: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retries'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }
}

class DriftSyncQueueItem extends DataClass
    implements Insertable<DriftSyncQueueItem> {
  /// 自增主键
  final int id;

  /// 操作类型：acknowledge_alert / start_mission / complete_mission
  final String operationType;

  /// 操作参数 JSON 字符串
  final String payload;

  /// 创建时间戳
  final DateTime createdAt;

  /// 重试次数
  final int retries;

  /// 状态：pending / processing / done / failed
  final String status;
  const DriftSyncQueueItem(
      {required this.id,
      required this.operationType,
      required this.payload,
      required this.createdAt,
      required this.retries,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retries'] = Variable<int>(retries);
    map['status'] = Variable<String>(status);
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      operationType: Value(operationType),
      payload: Value(payload),
      createdAt: Value(createdAt),
      retries: Value(retries),
      status: Value(status),
    );
  }

  factory DriftSyncQueueItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftSyncQueueItem(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retries: serializer.fromJson<int>(json['retries']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retries': serializer.toJson<int>(retries),
      'status': serializer.toJson<String>(status),
    };
  }

  DriftSyncQueueItem copyWith(
          {int? id,
          String? operationType,
          String? payload,
          DateTime? createdAt,
          int? retries,
          String? status}) =>
      DriftSyncQueueItem(
        id: id ?? this.id,
        operationType: operationType ?? this.operationType,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
        retries: retries ?? this.retries,
        status: status ?? this.status,
      );
  DriftSyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return DriftSyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retries: data.retries.present ? data.retries.value : this.retries,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftSyncQueueItem(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retries: $retries, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, operationType, payload, createdAt, retries, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftSyncQueueItem &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.retries == this.retries &&
          other.status == this.status);
}

class SyncQueueItemsCompanion extends UpdateCompanion<DriftSyncQueueItem> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<int> retries;
  final Value<String> status;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retries = const Value.absent(),
    this.status = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    this.id = const Value.absent(),
    required String operationType,
    required String payload,
    required DateTime createdAt,
    this.retries = const Value.absent(),
    this.status = const Value.absent(),
  })  : operationType = Value(operationType),
        payload = Value(payload),
        createdAt = Value(createdAt);
  static Insertable<DriftSyncQueueItem> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? retries,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (retries != null) 'retries': retries,
      if (status != null) 'status': status,
    });
  }

  SyncQueueItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? operationType,
      Value<String>? payload,
      Value<DateTime>? createdAt,
      Value<int>? retries,
      Value<String>? status}) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      retries: retries ?? this.retries,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retries.present) {
      map['retries'] = Variable<int>(retries.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retries: $retries, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $MissionsTable missions = $MissionsTable(this);
  late final $AlertsTable alerts = $AlertsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vehicles, missions, alerts, devices, syncQueueItems];
}

typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  required String id,
  required String name,
  required String type,
  required double latitude,
  required double longitude,
  required double altitude,
  required double speed,
  required double fuel,
  required bool online,
  required String status,
  required int lastUpdated,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<double> latitude,
  Value<double> longitude,
  Value<double> altitude,
  Value<double> speed,
  Value<double> fuel,
  Value<bool> online,
  Value<String> status,
  Value<int> lastUpdated,
  Value<int> rowid,
});

class $$VehiclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTable,
    DriftVehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder> {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$VehiclesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$VehiclesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double> altitude = const Value.absent(),
            Value<double> speed = const Value.absent(),
            Value<double> fuel = const Value.absent(),
            Value<bool> online = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion(
            id: id,
            name: name,
            type: type,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speed: speed,
            fuel: fuel,
            online: online,
            status: status,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required double latitude,
            required double longitude,
            required double altitude,
            required double speed,
            required double fuel,
            required bool online,
            required String status,
            required int lastUpdated,
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion.insert(
            id: id,
            name: name,
            type: type,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            speed: speed,
            fuel: fuel,
            online: online,
            status: status,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
        ));
}

class $$VehiclesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get altitude => $state.composableBuilder(
      column: $state.table.altitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get speed => $state.composableBuilder(
      column: $state.table.speed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get fuel => $state.composableBuilder(
      column: $state.table.fuel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get online => $state.composableBuilder(
      column: $state.table.online,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lastUpdated => $state.composableBuilder(
      column: $state.table.lastUpdated,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$VehiclesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get altitude => $state.composableBuilder(
      column: $state.table.altitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get speed => $state.composableBuilder(
      column: $state.table.speed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get fuel => $state.composableBuilder(
      column: $state.table.fuel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get online => $state.composableBuilder(
      column: $state.table.online,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lastUpdated => $state.composableBuilder(
      column: $state.table.lastUpdated,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MissionsTableCreateCompanionBuilder = MissionsCompanion Function({
  required String id,
  required String name,
  required String vehicleId,
  required String status,
  required String loadPoint,
  required String unloadPoint,
  required double targetLoad,
  required double currentLoad,
  required int createdAt,
  Value<int?> startedAt,
  Value<int?> completedAt,
  Value<String?> priority,
  Value<int> rowid,
});
typedef $$MissionsTableUpdateCompanionBuilder = MissionsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> vehicleId,
  Value<String> status,
  Value<String> loadPoint,
  Value<String> unloadPoint,
  Value<double> targetLoad,
  Value<double> currentLoad,
  Value<int> createdAt,
  Value<int?> startedAt,
  Value<int?> completedAt,
  Value<String?> priority,
  Value<int> rowid,
});

class $$MissionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MissionsTable,
    DriftMission,
    $$MissionsTableFilterComposer,
    $$MissionsTableOrderingComposer,
    $$MissionsTableCreateCompanionBuilder,
    $$MissionsTableUpdateCompanionBuilder> {
  $$MissionsTableTableManager(_$AppDatabase db, $MissionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MissionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MissionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> vehicleId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> loadPoint = const Value.absent(),
            Value<String> unloadPoint = const Value.absent(),
            Value<double> targetLoad = const Value.absent(),
            Value<double> currentLoad = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<String?> priority = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissionsCompanion(
            id: id,
            name: name,
            vehicleId: vehicleId,
            status: status,
            loadPoint: loadPoint,
            unloadPoint: unloadPoint,
            targetLoad: targetLoad,
            currentLoad: currentLoad,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            priority: priority,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String vehicleId,
            required String status,
            required String loadPoint,
            required String unloadPoint,
            required double targetLoad,
            required double currentLoad,
            required int createdAt,
            Value<int?> startedAt = const Value.absent(),
            Value<int?> completedAt = const Value.absent(),
            Value<String?> priority = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MissionsCompanion.insert(
            id: id,
            name: name,
            vehicleId: vehicleId,
            status: status,
            loadPoint: loadPoint,
            unloadPoint: unloadPoint,
            targetLoad: targetLoad,
            currentLoad: currentLoad,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            priority: priority,
            rowid: rowid,
          ),
        ));
}

class $$MissionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MissionsTable> {
  $$MissionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get vehicleId => $state.composableBuilder(
      column: $state.table.vehicleId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get loadPoint => $state.composableBuilder(
      column: $state.table.loadPoint,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get unloadPoint => $state.composableBuilder(
      column: $state.table.unloadPoint,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get targetLoad => $state.composableBuilder(
      column: $state.table.targetLoad,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get currentLoad => $state.composableBuilder(
      column: $state.table.currentLoad,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MissionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MissionsTable> {
  $$MissionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get vehicleId => $state.composableBuilder(
      column: $state.table.vehicleId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get loadPoint => $state.composableBuilder(
      column: $state.table.loadPoint,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get unloadPoint => $state.composableBuilder(
      column: $state.table.unloadPoint,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get targetLoad => $state.composableBuilder(
      column: $state.table.targetLoad,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get currentLoad => $state.composableBuilder(
      column: $state.table.currentLoad,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AlertsTableCreateCompanionBuilder = AlertsCompanion Function({
  required String id,
  required String title,
  required String message,
  required String level,
  required String source,
  Value<String?> vehicleId,
  required bool acknowledged,
  required int createdAt,
  Value<int?> acknowledgedAt,
  Value<String?> acknowledgedBy,
  Value<int> rowid,
});
typedef $$AlertsTableUpdateCompanionBuilder = AlertsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> message,
  Value<String> level,
  Value<String> source,
  Value<String?> vehicleId,
  Value<bool> acknowledged,
  Value<int> createdAt,
  Value<int?> acknowledgedAt,
  Value<String?> acknowledgedBy,
  Value<int> rowid,
});

class $$AlertsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlertsTable,
    DriftAlert,
    $$AlertsTableFilterComposer,
    $$AlertsTableOrderingComposer,
    $$AlertsTableCreateCompanionBuilder,
    $$AlertsTableUpdateCompanionBuilder> {
  $$AlertsTableTableManager(_$AppDatabase db, $AlertsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AlertsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AlertsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> vehicleId = const Value.absent(),
            Value<bool> acknowledged = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> acknowledgedAt = const Value.absent(),
            Value<String?> acknowledgedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlertsCompanion(
            id: id,
            title: title,
            message: message,
            level: level,
            source: source,
            vehicleId: vehicleId,
            acknowledged: acknowledged,
            createdAt: createdAt,
            acknowledgedAt: acknowledgedAt,
            acknowledgedBy: acknowledgedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String message,
            required String level,
            required String source,
            Value<String?> vehicleId = const Value.absent(),
            required bool acknowledged,
            required int createdAt,
            Value<int?> acknowledgedAt = const Value.absent(),
            Value<String?> acknowledgedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlertsCompanion.insert(
            id: id,
            title: title,
            message: message,
            level: level,
            source: source,
            vehicleId: vehicleId,
            acknowledged: acknowledged,
            createdAt: createdAt,
            acknowledgedAt: acknowledgedAt,
            acknowledgedBy: acknowledgedBy,
            rowid: rowid,
          ),
        ));
}

class $$AlertsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AlertsTable> {
  $$AlertsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get vehicleId => $state.composableBuilder(
      column: $state.table.vehicleId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get acknowledged => $state.composableBuilder(
      column: $state.table.acknowledged,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get acknowledgedAt => $state.composableBuilder(
      column: $state.table.acknowledgedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get acknowledgedBy => $state.composableBuilder(
      column: $state.table.acknowledgedBy,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AlertsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AlertsTable> {
  $$AlertsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get source => $state.composableBuilder(
      column: $state.table.source,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get vehicleId => $state.composableBuilder(
      column: $state.table.vehicleId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get acknowledged => $state.composableBuilder(
      column: $state.table.acknowledged,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get acknowledgedAt => $state.composableBuilder(
      column: $state.table.acknowledgedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get acknowledgedBy => $state.composableBuilder(
      column: $state.table.acknowledgedBy,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DevicesTableCreateCompanionBuilder = DevicesCompanion Function({
  required String id,
  required String name,
  required String type,
  required bool online,
  required double latitude,
  required double longitude,
  required int lastSeen,
  Value<double?> battery,
  Value<String?> location,
  Value<int> rowid,
});
typedef $$DevicesTableUpdateCompanionBuilder = DevicesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<bool> online,
  Value<double> latitude,
  Value<double> longitude,
  Value<int> lastSeen,
  Value<double?> battery,
  Value<String?> location,
  Value<int> rowid,
});

class $$DevicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DevicesTable,
    DriftDevice,
    $$DevicesTableFilterComposer,
    $$DevicesTableOrderingComposer,
    $$DevicesTableCreateCompanionBuilder,
    $$DevicesTableUpdateCompanionBuilder> {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DevicesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DevicesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> online = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<int> lastSeen = const Value.absent(),
            Value<double?> battery = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion(
            id: id,
            name: name,
            type: type,
            online: online,
            latitude: latitude,
            longitude: longitude,
            lastSeen: lastSeen,
            battery: battery,
            location: location,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required bool online,
            required double latitude,
            required double longitude,
            required int lastSeen,
            Value<double?> battery = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion.insert(
            id: id,
            name: name,
            type: type,
            online: online,
            latitude: latitude,
            longitude: longitude,
            lastSeen: lastSeen,
            battery: battery,
            location: location,
            rowid: rowid,
          ),
        ));
}

class $$DevicesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get online => $state.composableBuilder(
      column: $state.table.online,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lastSeen => $state.composableBuilder(
      column: $state.table.lastSeen,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get battery => $state.composableBuilder(
      column: $state.table.battery,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DevicesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get online => $state.composableBuilder(
      column: $state.table.online,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lastSeen => $state.composableBuilder(
      column: $state.table.lastSeen,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get battery => $state.composableBuilder(
      column: $state.table.battery,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SyncQueueItemsTableCreateCompanionBuilder = SyncQueueItemsCompanion
    Function({
  Value<int> id,
  required String operationType,
  required String payload,
  required DateTime createdAt,
  Value<int> retries,
  Value<String> status,
});
typedef $$SyncQueueItemsTableUpdateCompanionBuilder = SyncQueueItemsCompanion
    Function({
  Value<int> id,
  Value<String> operationType,
  Value<String> payload,
  Value<DateTime> createdAt,
  Value<int> retries,
  Value<String> status,
});

class $$SyncQueueItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueItemsTable,
    DriftSyncQueueItem,
    $$SyncQueueItemsTableFilterComposer,
    $$SyncQueueItemsTableOrderingComposer,
    $$SyncQueueItemsTableCreateCompanionBuilder,
    $$SyncQueueItemsTableUpdateCompanionBuilder> {
  $$SyncQueueItemsTableTableManager(
      _$AppDatabase db, $SyncQueueItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SyncQueueItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SyncQueueItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> operationType = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> retries = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              SyncQueueItemsCompanion(
            id: id,
            operationType: operationType,
            payload: payload,
            createdAt: createdAt,
            retries: retries,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String operationType,
            required String payload,
            required DateTime createdAt,
            Value<int> retries = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              SyncQueueItemsCompanion.insert(
            id: id,
            operationType: operationType,
            payload: payload,
            createdAt: createdAt,
            retries: retries,
            status: status,
          ),
        ));
}

class $$SyncQueueItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get operationType => $state.composableBuilder(
      column: $state.table.operationType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get payload => $state.composableBuilder(
      column: $state.table.payload,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get retries => $state.composableBuilder(
      column: $state.table.retries,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SyncQueueItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get operationType => $state.composableBuilder(
      column: $state.table.operationType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get payload => $state.composableBuilder(
      column: $state.table.payload,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get retries => $state.composableBuilder(
      column: $state.table.retries,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$MissionsTableTableManager get missions =>
      $$MissionsTableTableManager(_db, _db.missions);
  $$AlertsTableTableManager get alerts =>
      $$AlertsTableTableManager(_db, _db.alerts);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
}
