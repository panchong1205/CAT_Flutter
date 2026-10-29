// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AgentCard {
  // 告警 ID
  String get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )
    alertCard,
    required TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )
    confirmCard,
    required TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )
    infoCard,
    required TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )
    actionCard,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult? Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult? Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult? Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertAgentCard value) alertCard,
    required TResult Function(ConfirmAgentCard value) confirmCard,
    required TResult Function(InfoAgentCard value) infoCard,
    required TResult Function(ActionAgentCard value) actionCard,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertAgentCard value)? alertCard,
    TResult? Function(ConfirmAgentCard value)? confirmCard,
    TResult? Function(InfoAgentCard value)? infoCard,
    TResult? Function(ActionAgentCard value)? actionCard,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertAgentCard value)? alertCard,
    TResult Function(ConfirmAgentCard value)? confirmCard,
    TResult Function(InfoAgentCard value)? infoCard,
    TResult Function(ActionAgentCard value)? actionCard,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgentCardCopyWith<AgentCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentCardCopyWith<$Res> {
  factory $AgentCardCopyWith(AgentCard value, $Res Function(AgentCard) then) =
      _$AgentCardCopyWithImpl<$Res, AgentCard>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$AgentCardCopyWithImpl<$Res, $Val extends AgentCard>
    implements $AgentCardCopyWith<$Res> {
  _$AgentCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AlertAgentCardImplCopyWith<$Res>
    implements $AgentCardCopyWith<$Res> {
  factory _$$AlertAgentCardImplCopyWith(
    _$AlertAgentCardImpl value,
    $Res Function(_$AlertAgentCardImpl) then,
  ) = __$$AlertAgentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String alertId,
    String title,
    String level,
    String message,
    String? vehicleName,
    List<String>? actions,
  });
}

/// @nodoc
class __$$AlertAgentCardImplCopyWithImpl<$Res>
    extends _$AgentCardCopyWithImpl<$Res, _$AlertAgentCardImpl>
    implements _$$AlertAgentCardImplCopyWith<$Res> {
  __$$AlertAgentCardImplCopyWithImpl(
    _$AlertAgentCardImpl _value,
    $Res Function(_$AlertAgentCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alertId = null,
    Object? title = null,
    Object? level = null,
    Object? message = null,
    Object? vehicleName = freezed,
    Object? actions = freezed,
  }) {
    return _then(
      _$AlertAgentCardImpl(
        alertId: null == alertId
            ? _value.alertId
            : alertId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleName: freezed == vehicleName
            ? _value.vehicleName
            : vehicleName // ignore: cast_nullable_to_non_nullable
                  as String?,
        actions: freezed == actions
            ? _value._actions
            : actions // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc

class _$AlertAgentCardImpl extends AlertAgentCard {
  const _$AlertAgentCardImpl({
    required this.alertId,
    required this.title,
    required this.level,
    required this.message,
    this.vehicleName,
    final List<String>? actions,
  }) : _actions = actions,
       super._();

  @override
  final String alertId;
  // 告警 ID
  @override
  final String title;
  // 告警标题
  @override
  final String level;
  // 告警级别：critical / warning / info
  @override
  final String message;
  // 告警详情
  @override
  final String? vehicleName;
  // 关联车辆名称
  final List<String>? _actions;
  // 关联车辆名称
  @override
  List<String>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AgentCard.alertCard(alertId: $alertId, title: $title, level: $level, message: $message, vehicleName: $vehicleName, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertAgentCardImpl &&
            (identical(other.alertId, alertId) || other.alertId == alertId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.vehicleName, vehicleName) ||
                other.vehicleName == vehicleName) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    alertId,
    title,
    level,
    message,
    vehicleName,
    const DeepCollectionEquality().hash(_actions),
  );

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertAgentCardImplCopyWith<_$AlertAgentCardImpl> get copyWith =>
      __$$AlertAgentCardImplCopyWithImpl<_$AlertAgentCardImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )
    alertCard,
    required TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )
    confirmCard,
    required TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )
    infoCard,
    required TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )
    actionCard,
  }) {
    return alertCard(alertId, title, level, message, vehicleName, actions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult? Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult? Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult? Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
  }) {
    return alertCard?.call(
      alertId,
      title,
      level,
      message,
      vehicleName,
      actions,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
    required TResult orElse(),
  }) {
    if (alertCard != null) {
      return alertCard(alertId, title, level, message, vehicleName, actions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertAgentCard value) alertCard,
    required TResult Function(ConfirmAgentCard value) confirmCard,
    required TResult Function(InfoAgentCard value) infoCard,
    required TResult Function(ActionAgentCard value) actionCard,
  }) {
    return alertCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertAgentCard value)? alertCard,
    TResult? Function(ConfirmAgentCard value)? confirmCard,
    TResult? Function(InfoAgentCard value)? infoCard,
    TResult? Function(ActionAgentCard value)? actionCard,
  }) {
    return alertCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertAgentCard value)? alertCard,
    TResult Function(ConfirmAgentCard value)? confirmCard,
    TResult Function(InfoAgentCard value)? infoCard,
    TResult Function(ActionAgentCard value)? actionCard,
    required TResult orElse(),
  }) {
    if (alertCard != null) {
      return alertCard(this);
    }
    return orElse();
  }
}

abstract class AlertAgentCard extends AgentCard {
  const factory AlertAgentCard({
    required final String alertId,
    required final String title,
    required final String level,
    required final String message,
    final String? vehicleName,
    final List<String>? actions,
  }) = _$AlertAgentCardImpl;
  const AlertAgentCard._() : super._();

  String get alertId; // 告警 ID
  @override
  String get title; // 告警标题
  String get level; // 告警级别：critical / warning / info
  String get message; // 告警详情
  String? get vehicleName; // 关联车辆名称
  List<String>? get actions;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertAgentCardImplCopyWith<_$AlertAgentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmAgentCardImplCopyWith<$Res>
    implements $AgentCardCopyWith<$Res> {
  factory _$$ConfirmAgentCardImplCopyWith(
    _$ConfirmAgentCardImpl value,
    $Res Function(_$ConfirmAgentCardImpl) then,
  ) = __$$ConfirmAgentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String actionId,
    String title,
    String message,
    String? confirmLabel,
    String? cancelLabel,
    String? severity,
  });
}

/// @nodoc
class __$$ConfirmAgentCardImplCopyWithImpl<$Res>
    extends _$AgentCardCopyWithImpl<$Res, _$ConfirmAgentCardImpl>
    implements _$$ConfirmAgentCardImplCopyWith<$Res> {
  __$$ConfirmAgentCardImplCopyWithImpl(
    _$ConfirmAgentCardImpl _value,
    $Res Function(_$ConfirmAgentCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionId = null,
    Object? title = null,
    Object? message = null,
    Object? confirmLabel = freezed,
    Object? cancelLabel = freezed,
    Object? severity = freezed,
  }) {
    return _then(
      _$ConfirmAgentCardImpl(
        actionId: null == actionId
            ? _value.actionId
            : actionId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmLabel: freezed == confirmLabel
            ? _value.confirmLabel
            : confirmLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelLabel: freezed == cancelLabel
            ? _value.cancelLabel
            : cancelLabel // ignore: cast_nullable_to_non_nullable
                  as String?,
        severity: freezed == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmAgentCardImpl extends ConfirmAgentCard {
  const _$ConfirmAgentCardImpl({
    required this.actionId,
    required this.title,
    required this.message,
    this.confirmLabel,
    this.cancelLabel,
    this.severity,
  }) : super._();

  @override
  final String actionId;
  // 操作 ID，用于确认/取消回调
  @override
  final String title;
  // 确认标题
  @override
  final String message;
  // 确认描述
  @override
  final String? confirmLabel;
  // 确认按钮文字（默认「确认」）
  @override
  final String? cancelLabel;
  // 取消按钮文字（默认「取消」）
  @override
  final String? severity;

  @override
  String toString() {
    return 'AgentCard.confirmCard(actionId: $actionId, title: $title, message: $message, confirmLabel: $confirmLabel, cancelLabel: $cancelLabel, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmAgentCardImpl &&
            (identical(other.actionId, actionId) ||
                other.actionId == actionId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.confirmLabel, confirmLabel) ||
                other.confirmLabel == confirmLabel) &&
            (identical(other.cancelLabel, cancelLabel) ||
                other.cancelLabel == cancelLabel) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    actionId,
    title,
    message,
    confirmLabel,
    cancelLabel,
    severity,
  );

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmAgentCardImplCopyWith<_$ConfirmAgentCardImpl> get copyWith =>
      __$$ConfirmAgentCardImplCopyWithImpl<_$ConfirmAgentCardImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )
    alertCard,
    required TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )
    confirmCard,
    required TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )
    infoCard,
    required TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )
    actionCard,
  }) {
    return confirmCard(
      actionId,
      title,
      message,
      confirmLabel,
      cancelLabel,
      severity,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult? Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult? Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult? Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
  }) {
    return confirmCard?.call(
      actionId,
      title,
      message,
      confirmLabel,
      cancelLabel,
      severity,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
    required TResult orElse(),
  }) {
    if (confirmCard != null) {
      return confirmCard(
        actionId,
        title,
        message,
        confirmLabel,
        cancelLabel,
        severity,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertAgentCard value) alertCard,
    required TResult Function(ConfirmAgentCard value) confirmCard,
    required TResult Function(InfoAgentCard value) infoCard,
    required TResult Function(ActionAgentCard value) actionCard,
  }) {
    return confirmCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertAgentCard value)? alertCard,
    TResult? Function(ConfirmAgentCard value)? confirmCard,
    TResult? Function(InfoAgentCard value)? infoCard,
    TResult? Function(ActionAgentCard value)? actionCard,
  }) {
    return confirmCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertAgentCard value)? alertCard,
    TResult Function(ConfirmAgentCard value)? confirmCard,
    TResult Function(InfoAgentCard value)? infoCard,
    TResult Function(ActionAgentCard value)? actionCard,
    required TResult orElse(),
  }) {
    if (confirmCard != null) {
      return confirmCard(this);
    }
    return orElse();
  }
}

abstract class ConfirmAgentCard extends AgentCard {
  const factory ConfirmAgentCard({
    required final String actionId,
    required final String title,
    required final String message,
    final String? confirmLabel,
    final String? cancelLabel,
    final String? severity,
  }) = _$ConfirmAgentCardImpl;
  const ConfirmAgentCard._() : super._();

  String get actionId; // 操作 ID，用于确认/取消回调
  @override
  String get title; // 确认标题
  String get message; // 确认描述
  String? get confirmLabel; // 确认按钮文字（默认「确认」）
  String? get cancelLabel; // 取消按钮文字（默认「取消」）
  String? get severity;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmAgentCardImplCopyWith<_$ConfirmAgentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InfoAgentCardImplCopyWith<$Res>
    implements $AgentCardCopyWith<$Res> {
  factory _$$InfoAgentCardImplCopyWith(
    _$InfoAgentCardImpl value,
    $Res Function(_$InfoAgentCardImpl) then,
  ) = __$$InfoAgentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String content,
    String? iconName,
    List<InfoField>? fields,
  });
}

/// @nodoc
class __$$InfoAgentCardImplCopyWithImpl<$Res>
    extends _$AgentCardCopyWithImpl<$Res, _$InfoAgentCardImpl>
    implements _$$InfoAgentCardImplCopyWith<$Res> {
  __$$InfoAgentCardImplCopyWithImpl(
    _$InfoAgentCardImpl _value,
    $Res Function(_$InfoAgentCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? iconName = freezed,
    Object? fields = freezed,
  }) {
    return _then(
      _$InfoAgentCardImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        iconName: freezed == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fields: freezed == fields
            ? _value._fields
            : fields // ignore: cast_nullable_to_non_nullable
                  as List<InfoField>?,
      ),
    );
  }
}

/// @nodoc

class _$InfoAgentCardImpl extends InfoAgentCard {
  const _$InfoAgentCardImpl({
    required this.title,
    required this.content,
    this.iconName,
    final List<InfoField>? fields,
  }) : _fields = fields,
       super._();

  @override
  final String title;
  // 信息标题
  @override
  final String content;
  // 信息内容
  @override
  final String? iconName;
  // 图标名称（如 'info', 'success', 'warning'）
  final List<InfoField>? _fields;
  // 图标名称（如 'info', 'success', 'warning'）
  @override
  List<InfoField>? get fields {
    final value = _fields;
    if (value == null) return null;
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AgentCard.infoCard(title: $title, content: $content, iconName: $iconName, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoAgentCardImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    content,
    iconName,
    const DeepCollectionEquality().hash(_fields),
  );

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoAgentCardImplCopyWith<_$InfoAgentCardImpl> get copyWith =>
      __$$InfoAgentCardImplCopyWithImpl<_$InfoAgentCardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )
    alertCard,
    required TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )
    confirmCard,
    required TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )
    infoCard,
    required TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )
    actionCard,
  }) {
    return infoCard(title, content, iconName, fields);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult? Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult? Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult? Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
  }) {
    return infoCard?.call(title, content, iconName, fields);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
    required TResult orElse(),
  }) {
    if (infoCard != null) {
      return infoCard(title, content, iconName, fields);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertAgentCard value) alertCard,
    required TResult Function(ConfirmAgentCard value) confirmCard,
    required TResult Function(InfoAgentCard value) infoCard,
    required TResult Function(ActionAgentCard value) actionCard,
  }) {
    return infoCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertAgentCard value)? alertCard,
    TResult? Function(ConfirmAgentCard value)? confirmCard,
    TResult? Function(InfoAgentCard value)? infoCard,
    TResult? Function(ActionAgentCard value)? actionCard,
  }) {
    return infoCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertAgentCard value)? alertCard,
    TResult Function(ConfirmAgentCard value)? confirmCard,
    TResult Function(InfoAgentCard value)? infoCard,
    TResult Function(ActionAgentCard value)? actionCard,
    required TResult orElse(),
  }) {
    if (infoCard != null) {
      return infoCard(this);
    }
    return orElse();
  }
}

abstract class InfoAgentCard extends AgentCard {
  const factory InfoAgentCard({
    required final String title,
    required final String content,
    final String? iconName,
    final List<InfoField>? fields,
  }) = _$InfoAgentCardImpl;
  const InfoAgentCard._() : super._();

  @override
  String get title; // 信息标题
  String get content; // 信息内容
  String? get iconName; // 图标名称（如 'info', 'success', 'warning'）
  List<InfoField>? get fields;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfoAgentCardImplCopyWith<_$InfoAgentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActionAgentCardImplCopyWith<$Res>
    implements $AgentCardCopyWith<$Res> {
  factory _$$ActionAgentCardImplCopyWith(
    _$ActionAgentCardImpl value,
    $Res Function(_$ActionAgentCardImpl) then,
  ) = __$$ActionAgentCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String? description,
    List<ActionResult>? results,
    List<String>? actions,
    String? status,
  });
}

/// @nodoc
class __$$ActionAgentCardImplCopyWithImpl<$Res>
    extends _$AgentCardCopyWithImpl<$Res, _$ActionAgentCardImpl>
    implements _$$ActionAgentCardImplCopyWith<$Res> {
  __$$ActionAgentCardImplCopyWithImpl(
    _$ActionAgentCardImpl _value,
    $Res Function(_$ActionAgentCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? results = freezed,
    Object? actions = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$ActionAgentCardImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        results: freezed == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<ActionResult>?,
        actions: freezed == actions
            ? _value._actions
            : actions // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ActionAgentCardImpl extends ActionAgentCard {
  const _$ActionAgentCardImpl({
    required this.title,
    this.description,
    final List<ActionResult>? results,
    final List<String>? actions,
    this.status,
  }) : _results = results,
       _actions = actions,
       super._();

  @override
  final String title;
  // 动作标题
  @override
  final String? description;
  // 动作描述
  final List<ActionResult>? _results;
  // 动作描述
  @override
  List<ActionResult>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 动作结果列表（用于展示操作后的反馈）
  final List<String>? _actions;
  // 动作结果列表（用于展示操作后的反馈）
  @override
  List<String>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 可用操作列表
  @override
  final String? status;

  @override
  String toString() {
    return 'AgentCard.actionCard(title: $title, description: $description, results: $results, actions: $actions, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionAgentCardImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    const DeepCollectionEquality().hash(_results),
    const DeepCollectionEquality().hash(_actions),
    status,
  );

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionAgentCardImplCopyWith<_$ActionAgentCardImpl> get copyWith =>
      __$$ActionAgentCardImplCopyWithImpl<_$ActionAgentCardImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )
    alertCard,
    required TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )
    confirmCard,
    required TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )
    infoCard,
    required TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )
    actionCard,
  }) {
    return actionCard(title, description, results, actions, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult? Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult? Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult? Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
  }) {
    return actionCard?.call(title, description, results, actions, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String alertId,
      String title,
      String level,
      String message,
      String? vehicleName,
      List<String>? actions,
    )?
    alertCard,
    TResult Function(
      String actionId,
      String title,
      String message,
      String? confirmLabel,
      String? cancelLabel,
      String? severity,
    )?
    confirmCard,
    TResult Function(
      String title,
      String content,
      String? iconName,
      List<InfoField>? fields,
    )?
    infoCard,
    TResult Function(
      String title,
      String? description,
      List<ActionResult>? results,
      List<String>? actions,
      String? status,
    )?
    actionCard,
    required TResult orElse(),
  }) {
    if (actionCard != null) {
      return actionCard(title, description, results, actions, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertAgentCard value) alertCard,
    required TResult Function(ConfirmAgentCard value) confirmCard,
    required TResult Function(InfoAgentCard value) infoCard,
    required TResult Function(ActionAgentCard value) actionCard,
  }) {
    return actionCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertAgentCard value)? alertCard,
    TResult? Function(ConfirmAgentCard value)? confirmCard,
    TResult? Function(InfoAgentCard value)? infoCard,
    TResult? Function(ActionAgentCard value)? actionCard,
  }) {
    return actionCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertAgentCard value)? alertCard,
    TResult Function(ConfirmAgentCard value)? confirmCard,
    TResult Function(InfoAgentCard value)? infoCard,
    TResult Function(ActionAgentCard value)? actionCard,
    required TResult orElse(),
  }) {
    if (actionCard != null) {
      return actionCard(this);
    }
    return orElse();
  }
}

abstract class ActionAgentCard extends AgentCard {
  const factory ActionAgentCard({
    required final String title,
    final String? description,
    final List<ActionResult>? results,
    final List<String>? actions,
    final String? status,
  }) = _$ActionAgentCardImpl;
  const ActionAgentCard._() : super._();

  @override
  String get title; // 动作标题
  String? get description; // 动作描述
  List<ActionResult>? get results; // 动作结果列表（用于展示操作后的反馈）
  List<String>? get actions; // 可用操作列表
  String? get status;

  /// Create a copy of AgentCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionAgentCardImplCopyWith<_$ActionAgentCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InfoField {
  String get label => throw _privateConstructorUsedError; // 字段标签
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of InfoField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfoFieldCopyWith<InfoField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoFieldCopyWith<$Res> {
  factory $InfoFieldCopyWith(InfoField value, $Res Function(InfoField) then) =
      _$InfoFieldCopyWithImpl<$Res, InfoField>;
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class _$InfoFieldCopyWithImpl<$Res, $Val extends InfoField>
    implements $InfoFieldCopyWith<$Res> {
  _$InfoFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InfoField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InfoFieldImplCopyWith<$Res>
    implements $InfoFieldCopyWith<$Res> {
  factory _$$InfoFieldImplCopyWith(
    _$InfoFieldImpl value,
    $Res Function(_$InfoFieldImpl) then,
  ) = __$$InfoFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class __$$InfoFieldImplCopyWithImpl<$Res>
    extends _$InfoFieldCopyWithImpl<$Res, _$InfoFieldImpl>
    implements _$$InfoFieldImplCopyWith<$Res> {
  __$$InfoFieldImplCopyWithImpl(
    _$InfoFieldImpl _value,
    $Res Function(_$InfoFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InfoField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? value = null}) {
    return _then(
      _$InfoFieldImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InfoFieldImpl implements _InfoField {
  const _$InfoFieldImpl({required this.label, required this.value});

  @override
  final String label;
  // 字段标签
  @override
  final String value;

  @override
  String toString() {
    return 'InfoField(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoFieldImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of InfoField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoFieldImplCopyWith<_$InfoFieldImpl> get copyWith =>
      __$$InfoFieldImplCopyWithImpl<_$InfoFieldImpl>(this, _$identity);
}

abstract class _InfoField implements InfoField {
  const factory _InfoField({
    required final String label,
    required final String value,
  }) = _$InfoFieldImpl;

  @override
  String get label; // 字段标签
  @override
  String get value;

  /// Create a copy of InfoField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfoFieldImplCopyWith<_$InfoFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActionResult {
  String get label => throw _privateConstructorUsedError; // 结果标签
  String get value => throw _privateConstructorUsedError; // 结果值
  String? get status => throw _privateConstructorUsedError;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionResultCopyWith<ActionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionResultCopyWith<$Res> {
  factory $ActionResultCopyWith(
    ActionResult value,
    $Res Function(ActionResult) then,
  ) = _$ActionResultCopyWithImpl<$Res, ActionResult>;
  @useResult
  $Res call({String label, String value, String? status});
}

/// @nodoc
class _$ActionResultCopyWithImpl<$Res, $Val extends ActionResult>
    implements $ActionResultCopyWith<$Res> {
  _$ActionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionResultImplCopyWith<$Res>
    implements $ActionResultCopyWith<$Res> {
  factory _$$ActionResultImplCopyWith(
    _$ActionResultImpl value,
    $Res Function(_$ActionResultImpl) then,
  ) = __$$ActionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value, String? status});
}

/// @nodoc
class __$$ActionResultImplCopyWithImpl<$Res>
    extends _$ActionResultCopyWithImpl<$Res, _$ActionResultImpl>
    implements _$$ActionResultImplCopyWith<$Res> {
  __$$ActionResultImplCopyWithImpl(
    _$ActionResultImpl _value,
    $Res Function(_$ActionResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? status = freezed,
  }) {
    return _then(
      _$ActionResultImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ActionResultImpl implements _ActionResult {
  const _$ActionResultImpl({
    required this.label,
    required this.value,
    this.status,
  });

  @override
  final String label;
  // 结果标签
  @override
  final String value;
  // 结果值
  @override
  final String? status;

  @override
  String toString() {
    return 'ActionResult(label: $label, value: $value, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionResultImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value, status);

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      __$$ActionResultImplCopyWithImpl<_$ActionResultImpl>(this, _$identity);
}

abstract class _ActionResult implements ActionResult {
  const factory _ActionResult({
    required final String label,
    required final String value,
    final String? status,
  }) = _$ActionResultImpl;

  @override
  String get label; // 结果标签
  @override
  String get value; // 结果值
  @override
  String? get status;

  /// Create a copy of ActionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
