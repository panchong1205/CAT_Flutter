// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationMessage {
  String get id => throw _privateConstructorUsedError; // 消息唯一标识
  String get title => throw _privateConstructorUsedError; // 消息标题
  String get body => throw _privateConstructorUsedError; // 消息正文
  String get type =>
      throw _privateConstructorUsedError; // 类型：alert / mission / approval / patrol
  String get level =>
      throw _privateConstructorUsedError; // 级别：critical / warning / info
  String? get sourceId => throw _privateConstructorUsedError; // 来源 ID（可跳转到详情）
  String? get sourceRoute => throw _privateConstructorUsedError; // 来源路由（跳转路径）
  DateTime get createdAt => throw _privateConstructorUsedError; // 消息时间
  bool get isRead => throw _privateConstructorUsedError;

  /// Create a copy of NotificationMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationMessageCopyWith<NotificationMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationMessageCopyWith<$Res> {
  factory $NotificationMessageCopyWith(
    NotificationMessage value,
    $Res Function(NotificationMessage) then,
  ) = _$NotificationMessageCopyWithImpl<$Res, NotificationMessage>;
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String type,
    String level,
    String? sourceId,
    String? sourceRoute,
    DateTime createdAt,
    bool isRead,
  });
}

/// @nodoc
class _$NotificationMessageCopyWithImpl<$Res, $Val extends NotificationMessage>
    implements $NotificationMessageCopyWith<$Res> {
  _$NotificationMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? level = null,
    Object? sourceId = freezed,
    Object? sourceRoute = freezed,
    Object? createdAt = null,
    Object? isRead = null,
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
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceId: freezed == sourceId
                ? _value.sourceId
                : sourceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceRoute: freezed == sourceRoute
                ? _value.sourceRoute
                : sourceRoute // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationMessageImplCopyWith<$Res>
    implements $NotificationMessageCopyWith<$Res> {
  factory _$$NotificationMessageImplCopyWith(
    _$NotificationMessageImpl value,
    $Res Function(_$NotificationMessageImpl) then,
  ) = __$$NotificationMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String body,
    String type,
    String level,
    String? sourceId,
    String? sourceRoute,
    DateTime createdAt,
    bool isRead,
  });
}

/// @nodoc
class __$$NotificationMessageImplCopyWithImpl<$Res>
    extends _$NotificationMessageCopyWithImpl<$Res, _$NotificationMessageImpl>
    implements _$$NotificationMessageImplCopyWith<$Res> {
  __$$NotificationMessageImplCopyWithImpl(
    _$NotificationMessageImpl _value,
    $Res Function(_$NotificationMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? level = null,
    Object? sourceId = freezed,
    Object? sourceRoute = freezed,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(
      _$NotificationMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceId: freezed == sourceId
            ? _value.sourceId
            : sourceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceRoute: freezed == sourceRoute
            ? _value.sourceRoute
            : sourceRoute // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$NotificationMessageImpl extends _NotificationMessage {
  const _$NotificationMessageImpl({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.level,
    this.sourceId,
    this.sourceRoute,
    required this.createdAt,
    required this.isRead,
  }) : super._();

  @override
  final String id;
  // 消息唯一标识
  @override
  final String title;
  // 消息标题
  @override
  final String body;
  // 消息正文
  @override
  final String type;
  // 类型：alert / mission / approval / patrol
  @override
  final String level;
  // 级别：critical / warning / info
  @override
  final String? sourceId;
  // 来源 ID（可跳转到详情）
  @override
  final String? sourceRoute;
  // 来源路由（跳转路径）
  @override
  final DateTime createdAt;
  // 消息时间
  @override
  final bool isRead;

  @override
  String toString() {
    return 'NotificationMessage(id: $id, title: $title, body: $body, type: $type, level: $level, sourceId: $sourceId, sourceRoute: $sourceRoute, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.sourceRoute, sourceRoute) ||
                other.sourceRoute == sourceRoute) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    body,
    type,
    level,
    sourceId,
    sourceRoute,
    createdAt,
    isRead,
  );

  /// Create a copy of NotificationMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationMessageImplCopyWith<_$NotificationMessageImpl> get copyWith =>
      __$$NotificationMessageImplCopyWithImpl<_$NotificationMessageImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationMessage extends NotificationMessage {
  const factory _NotificationMessage({
    required final String id,
    required final String title,
    required final String body,
    required final String type,
    required final String level,
    final String? sourceId,
    final String? sourceRoute,
    required final DateTime createdAt,
    required final bool isRead,
  }) = _$NotificationMessageImpl;
  const _NotificationMessage._() : super._();

  @override
  String get id; // 消息唯一标识
  @override
  String get title; // 消息标题
  @override
  String get body; // 消息正文
  @override
  String get type; // 类型：alert / mission / approval / patrol
  @override
  String get level; // 级别：critical / warning / info
  @override
  String? get sourceId; // 来源 ID（可跳转到详情）
  @override
  String? get sourceRoute; // 来源路由（跳转路径）
  @override
  DateTime get createdAt; // 消息时间
  @override
  bool get isRead;

  /// Create a copy of NotificationMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationMessageImplCopyWith<_$NotificationMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
