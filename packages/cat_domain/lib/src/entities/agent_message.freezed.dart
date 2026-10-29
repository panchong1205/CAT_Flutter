// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AgentMessage {
  String get id => throw _privateConstructorUsedError; // 消息唯一标识
  String get content => throw _privateConstructorUsedError; // 消息内容
  String get role =>
      throw _privateConstructorUsedError; // 角色：user / assistant / system
  DateTime get timestamp => throw _privateConstructorUsedError; // 消息时间戳
  String? get commandType =>
      throw _privateConstructorUsedError; // 指令类型（仅 assistant 消息）：query_fleet / start_mission / acknowledge_alert
  Map<String, dynamic>? get data => throw _privateConstructorUsedError; // 附加数据
  List<AgentCard>? get cards =>
      throw _privateConstructorUsedError; // 结构化卡片列表（仅 assistant 消息）
  bool? get isStreaming => throw _privateConstructorUsedError;

  /// Create a copy of AgentMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentMessageCopyWith<AgentMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentMessageCopyWith<$Res> {
  factory $AgentMessageCopyWith(
    AgentMessage value,
    $Res Function(AgentMessage) then,
  ) = _$AgentMessageCopyWithImpl<$Res, AgentMessage>;
  @useResult
  $Res call({
    String id,
    String content,
    String role,
    DateTime timestamp,
    String? commandType,
    Map<String, dynamic>? data,
    List<AgentCard>? cards,
    bool? isStreaming,
  });
}

/// @nodoc
class _$AgentMessageCopyWithImpl<$Res, $Val extends AgentMessage>
    implements $AgentMessageCopyWith<$Res> {
  _$AgentMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgentMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? role = null,
    Object? timestamp = null,
    Object? commandType = freezed,
    Object? data = freezed,
    Object? cards = freezed,
    Object? isStreaming = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            commandType: freezed == commandType
                ? _value.commandType
                : commandType // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            cards: freezed == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<AgentCard>?,
            isStreaming: freezed == isStreaming
                ? _value.isStreaming
                : isStreaming // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgentMessageImplCopyWith<$Res>
    implements $AgentMessageCopyWith<$Res> {
  factory _$$AgentMessageImplCopyWith(
    _$AgentMessageImpl value,
    $Res Function(_$AgentMessageImpl) then,
  ) = __$$AgentMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    String role,
    DateTime timestamp,
    String? commandType,
    Map<String, dynamic>? data,
    List<AgentCard>? cards,
    bool? isStreaming,
  });
}

/// @nodoc
class __$$AgentMessageImplCopyWithImpl<$Res>
    extends _$AgentMessageCopyWithImpl<$Res, _$AgentMessageImpl>
    implements _$$AgentMessageImplCopyWith<$Res> {
  __$$AgentMessageImplCopyWithImpl(
    _$AgentMessageImpl _value,
    $Res Function(_$AgentMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgentMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? role = null,
    Object? timestamp = null,
    Object? commandType = freezed,
    Object? data = freezed,
    Object? cards = freezed,
    Object? isStreaming = freezed,
  }) {
    return _then(
      _$AgentMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        commandType: freezed == commandType
            ? _value.commandType
            : commandType // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        cards: freezed == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<AgentCard>?,
        isStreaming: freezed == isStreaming
            ? _value.isStreaming
            : isStreaming // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$AgentMessageImpl implements _AgentMessage {
  const _$AgentMessageImpl({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.commandType,
    final Map<String, dynamic>? data,
    final List<AgentCard>? cards,
    this.isStreaming,
  }) : _data = data,
       _cards = cards;

  @override
  final String id;
  // 消息唯一标识
  @override
  final String content;
  // 消息内容
  @override
  final String role;
  // 角色：user / assistant / system
  @override
  final DateTime timestamp;
  // 消息时间戳
  @override
  final String? commandType;
  // 指令类型（仅 assistant 消息）：query_fleet / start_mission / acknowledge_alert
  final Map<String, dynamic>? _data;
  // 指令类型（仅 assistant 消息）：query_fleet / start_mission / acknowledge_alert
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // 附加数据
  final List<AgentCard>? _cards;
  // 附加数据
  @override
  List<AgentCard>? get cards {
    final value = _cards;
    if (value == null) return null;
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 结构化卡片列表（仅 assistant 消息）
  @override
  final bool? isStreaming;

  @override
  String toString() {
    return 'AgentMessage(id: $id, content: $content, role: $role, timestamp: $timestamp, commandType: $commandType, data: $data, cards: $cards, isStreaming: $isStreaming)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.commandType, commandType) ||
                other.commandType == commandType) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isStreaming, isStreaming) ||
                other.isStreaming == isStreaming));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    role,
    timestamp,
    commandType,
    const DeepCollectionEquality().hash(_data),
    const DeepCollectionEquality().hash(_cards),
    isStreaming,
  );

  /// Create a copy of AgentMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentMessageImplCopyWith<_$AgentMessageImpl> get copyWith =>
      __$$AgentMessageImplCopyWithImpl<_$AgentMessageImpl>(this, _$identity);
}

abstract class _AgentMessage implements AgentMessage {
  const factory _AgentMessage({
    required final String id,
    required final String content,
    required final String role,
    required final DateTime timestamp,
    final String? commandType,
    final Map<String, dynamic>? data,
    final List<AgentCard>? cards,
    final bool? isStreaming,
  }) = _$AgentMessageImpl;

  @override
  String get id; // 消息唯一标识
  @override
  String get content; // 消息内容
  @override
  String get role; // 角色：user / assistant / system
  @override
  DateTime get timestamp; // 消息时间戳
  @override
  String? get commandType; // 指令类型（仅 assistant 消息）：query_fleet / start_mission / acknowledge_alert
  @override
  Map<String, dynamic>? get data; // 附加数据
  @override
  List<AgentCard>? get cards; // 结构化卡片列表（仅 assistant 消息）
  @override
  bool? get isStreaming;

  /// Create a copy of AgentMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgentMessageImplCopyWith<_$AgentMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
