// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncEventCopyWith<$Res> {
  factory $SyncEventCopyWith(SyncEvent value, $Res Function(SyncEvent) then) =
      _$SyncEventCopyWithImpl<$Res, SyncEvent>;
}

/// @nodoc
class _$SyncEventCopyWithImpl<$Res, $Val extends SyncEvent>
    implements $SyncEventCopyWith<$Res> {
  _$SyncEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SyncDataImplCopyWith<$Res> {
  factory _$$SyncDataImplCopyWith(
          _$SyncDataImpl value, $Res Function(_$SyncDataImpl) then) =
      __$$SyncDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncDataImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncDataImpl>
    implements _$$SyncDataImplCopyWith<$Res> {
  __$$SyncDataImplCopyWithImpl(
      _$SyncDataImpl _value, $Res Function(_$SyncDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncDataImpl implements _SyncData {
  const _$SyncDataImpl();

  @override
  String toString() {
    return 'SyncEvent.syncData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return syncData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return syncData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (syncData != null) {
      return syncData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return syncData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return syncData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (syncData != null) {
      return syncData(this);
    }
    return orElse();
  }
}

abstract class _SyncData implements SyncEvent {
  const factory _SyncData() = _$SyncDataImpl;
}

/// @nodoc
abstract class _$$SyncDataWithJsonImplCopyWith<$Res> {
  factory _$$SyncDataWithJsonImplCopyWith(_$SyncDataWithJsonImpl value,
          $Res Function(_$SyncDataWithJsonImpl) then) =
      __$$SyncDataWithJsonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String jsonData});
}

/// @nodoc
class __$$SyncDataWithJsonImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncDataWithJsonImpl>
    implements _$$SyncDataWithJsonImplCopyWith<$Res> {
  __$$SyncDataWithJsonImplCopyWithImpl(_$SyncDataWithJsonImpl _value,
      $Res Function(_$SyncDataWithJsonImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonData = null,
  }) {
    return _then(_$SyncDataWithJsonImpl(
      null == jsonData
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncDataWithJsonImpl implements _SyncDataWithJson {
  const _$SyncDataWithJsonImpl(this.jsonData);

  @override
  final String jsonData;

  @override
  String toString() {
    return 'SyncEvent.syncDataWithJson(jsonData: $jsonData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncDataWithJsonImpl &&
            (identical(other.jsonData, jsonData) ||
                other.jsonData == jsonData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, jsonData);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncDataWithJsonImplCopyWith<_$SyncDataWithJsonImpl> get copyWith =>
      __$$SyncDataWithJsonImplCopyWithImpl<_$SyncDataWithJsonImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return syncDataWithJson(jsonData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return syncDataWithJson?.call(jsonData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (syncDataWithJson != null) {
      return syncDataWithJson(jsonData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return syncDataWithJson(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return syncDataWithJson?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (syncDataWithJson != null) {
      return syncDataWithJson(this);
    }
    return orElse();
  }
}

abstract class _SyncDataWithJson implements SyncEvent {
  const factory _SyncDataWithJson(final String jsonData) =
      _$SyncDataWithJsonImpl;

  String get jsonData;

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncDataWithJsonImplCopyWith<_$SyncDataWithJsonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryLoadedImplCopyWith<$Res> {
  factory _$$HistoryLoadedImplCopyWith(
          _$HistoryLoadedImpl value, $Res Function(_$HistoryLoadedImpl) then) =
      __$$HistoryLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryLoadedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$HistoryLoadedImpl>
    implements _$$HistoryLoadedImplCopyWith<$Res> {
  __$$HistoryLoadedImplCopyWithImpl(
      _$HistoryLoadedImpl _value, $Res Function(_$HistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryLoadedImpl implements _HistoryLoaded {
  const _$HistoryLoadedImpl();

  @override
  String toString() {
    return 'SyncEvent.historyLoaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return historyLoaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return historyLoaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return historyLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return historyLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(this);
    }
    return orElse();
  }
}

abstract class _HistoryLoaded implements SyncEvent {
  const factory _HistoryLoaded() = _$HistoryLoadedImpl;
}

/// @nodoc
abstract class _$$TokenStatusLoadedImplCopyWith<$Res> {
  factory _$$TokenStatusLoadedImplCopyWith(_$TokenStatusLoadedImpl value,
          $Res Function(_$TokenStatusLoadedImpl) then) =
      __$$TokenStatusLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TokenStatusLoadedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$TokenStatusLoadedImpl>
    implements _$$TokenStatusLoadedImplCopyWith<$Res> {
  __$$TokenStatusLoadedImplCopyWithImpl(_$TokenStatusLoadedImpl _value,
      $Res Function(_$TokenStatusLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TokenStatusLoadedImpl implements _TokenStatusLoaded {
  const _$TokenStatusLoadedImpl();

  @override
  String toString() {
    return 'SyncEvent.tokenStatusLoaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TokenStatusLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return tokenStatusLoaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return tokenStatusLoaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (tokenStatusLoaded != null) {
      return tokenStatusLoaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return tokenStatusLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return tokenStatusLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (tokenStatusLoaded != null) {
      return tokenStatusLoaded(this);
    }
    return orElse();
  }
}

abstract class _TokenStatusLoaded implements SyncEvent {
  const factory _TokenStatusLoaded() = _$TokenStatusLoadedImpl;
}

/// @nodoc
abstract class _$$TokenRevokedImplCopyWith<$Res> {
  factory _$$TokenRevokedImplCopyWith(
          _$TokenRevokedImpl value, $Res Function(_$TokenRevokedImpl) then) =
      __$$TokenRevokedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TokenRevokedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$TokenRevokedImpl>
    implements _$$TokenRevokedImplCopyWith<$Res> {
  __$$TokenRevokedImplCopyWithImpl(
      _$TokenRevokedImpl _value, $Res Function(_$TokenRevokedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TokenRevokedImpl implements _TokenRevoked {
  const _$TokenRevokedImpl();

  @override
  String toString() {
    return 'SyncEvent.tokenRevoked()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TokenRevokedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return tokenRevoked();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return tokenRevoked?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (tokenRevoked != null) {
      return tokenRevoked();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return tokenRevoked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return tokenRevoked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (tokenRevoked != null) {
      return tokenRevoked(this);
    }
    return orElse();
  }
}

abstract class _TokenRevoked implements SyncEvent {
  const factory _TokenRevoked() = _$TokenRevokedImpl;
}

/// @nodoc
abstract class _$$CheckTokenStatusImplCopyWith<$Res> {
  factory _$$CheckTokenStatusImplCopyWith(_$CheckTokenStatusImpl value,
          $Res Function(_$CheckTokenStatusImpl) then) =
      __$$CheckTokenStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckTokenStatusImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$CheckTokenStatusImpl>
    implements _$$CheckTokenStatusImplCopyWith<$Res> {
  __$$CheckTokenStatusImplCopyWithImpl(_$CheckTokenStatusImpl _value,
      $Res Function(_$CheckTokenStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckTokenStatusImpl implements _CheckTokenStatus {
  const _$CheckTokenStatusImpl();

  @override
  String toString() {
    return 'SyncEvent.checkTokenStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckTokenStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() syncData,
    required TResult Function(String jsonData) syncDataWithJson,
    required TResult Function() historyLoaded,
    required TResult Function() tokenStatusLoaded,
    required TResult Function() tokenRevoked,
    required TResult Function() checkTokenStatus,
  }) {
    return checkTokenStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? syncData,
    TResult? Function(String jsonData)? syncDataWithJson,
    TResult? Function()? historyLoaded,
    TResult? Function()? tokenStatusLoaded,
    TResult? Function()? tokenRevoked,
    TResult? Function()? checkTokenStatus,
  }) {
    return checkTokenStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? syncData,
    TResult Function(String jsonData)? syncDataWithJson,
    TResult Function()? historyLoaded,
    TResult Function()? tokenStatusLoaded,
    TResult Function()? tokenRevoked,
    TResult Function()? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (checkTokenStatus != null) {
      return checkTokenStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncData value) syncData,
    required TResult Function(_SyncDataWithJson value) syncDataWithJson,
    required TResult Function(_HistoryLoaded value) historyLoaded,
    required TResult Function(_TokenStatusLoaded value) tokenStatusLoaded,
    required TResult Function(_TokenRevoked value) tokenRevoked,
    required TResult Function(_CheckTokenStatus value) checkTokenStatus,
  }) {
    return checkTokenStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncData value)? syncData,
    TResult? Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult? Function(_HistoryLoaded value)? historyLoaded,
    TResult? Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult? Function(_TokenRevoked value)? tokenRevoked,
    TResult? Function(_CheckTokenStatus value)? checkTokenStatus,
  }) {
    return checkTokenStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncData value)? syncData,
    TResult Function(_SyncDataWithJson value)? syncDataWithJson,
    TResult Function(_HistoryLoaded value)? historyLoaded,
    TResult Function(_TokenStatusLoaded value)? tokenStatusLoaded,
    TResult Function(_TokenRevoked value)? tokenRevoked,
    TResult Function(_CheckTokenStatus value)? checkTokenStatus,
    required TResult orElse(),
  }) {
    if (checkTokenStatus != null) {
      return checkTokenStatus(this);
    }
    return orElse();
  }
}

abstract class _CheckTokenStatus implements SyncEvent {
  const factory _CheckTokenStatus() = _$CheckTokenStatusImpl;
}

/// @nodoc
mixin _$SyncStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialStatus value) initial,
    required TResult Function(_LoadingStatus value) loading,
    required TResult Function(_SuccessStatus value) success,
    required TResult Function(_FailureStatus value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialStatus value)? initial,
    TResult? Function(_LoadingStatus value)? loading,
    TResult? Function(_SuccessStatus value)? success,
    TResult? Function(_FailureStatus value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialStatus value)? initial,
    TResult Function(_LoadingStatus value)? loading,
    TResult Function(_SuccessStatus value)? success,
    TResult Function(_FailureStatus value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialStatusImplCopyWith<$Res> {
  factory _$$InitialStatusImplCopyWith(
          _$InitialStatusImpl value, $Res Function(_$InitialStatusImpl) then) =
      __$$InitialStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$InitialStatusImpl>
    implements _$$InitialStatusImplCopyWith<$Res> {
  __$$InitialStatusImplCopyWithImpl(
      _$InitialStatusImpl _value, $Res Function(_$InitialStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialStatusImpl implements _InitialStatus {
  const _$InitialStatusImpl();

  @override
  String toString() {
    return 'SyncStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialStatus value) initial,
    required TResult Function(_LoadingStatus value) loading,
    required TResult Function(_SuccessStatus value) success,
    required TResult Function(_FailureStatus value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialStatus value)? initial,
    TResult? Function(_LoadingStatus value)? loading,
    TResult? Function(_SuccessStatus value)? success,
    TResult? Function(_FailureStatus value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialStatus value)? initial,
    TResult Function(_LoadingStatus value)? loading,
    TResult Function(_SuccessStatus value)? success,
    TResult Function(_FailureStatus value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialStatus implements SyncStatus {
  const factory _InitialStatus() = _$InitialStatusImpl;
}

/// @nodoc
abstract class _$$LoadingStatusImplCopyWith<$Res> {
  factory _$$LoadingStatusImplCopyWith(
          _$LoadingStatusImpl value, $Res Function(_$LoadingStatusImpl) then) =
      __$$LoadingStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$LoadingStatusImpl>
    implements _$$LoadingStatusImplCopyWith<$Res> {
  __$$LoadingStatusImplCopyWithImpl(
      _$LoadingStatusImpl _value, $Res Function(_$LoadingStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingStatusImpl implements _LoadingStatus {
  const _$LoadingStatusImpl();

  @override
  String toString() {
    return 'SyncStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialStatus value) initial,
    required TResult Function(_LoadingStatus value) loading,
    required TResult Function(_SuccessStatus value) success,
    required TResult Function(_FailureStatus value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialStatus value)? initial,
    TResult? Function(_LoadingStatus value)? loading,
    TResult? Function(_SuccessStatus value)? success,
    TResult? Function(_FailureStatus value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialStatus value)? initial,
    TResult Function(_LoadingStatus value)? loading,
    TResult Function(_SuccessStatus value)? success,
    TResult Function(_FailureStatus value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingStatus implements SyncStatus {
  const factory _LoadingStatus() = _$LoadingStatusImpl;
}

/// @nodoc
abstract class _$$SuccessStatusImplCopyWith<$Res> {
  factory _$$SuccessStatusImplCopyWith(
          _$SuccessStatusImpl value, $Res Function(_$SuccessStatusImpl) then) =
      __$$SuccessStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SuccessStatusImpl>
    implements _$$SuccessStatusImplCopyWith<$Res> {
  __$$SuccessStatusImplCopyWithImpl(
      _$SuccessStatusImpl _value, $Res Function(_$SuccessStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessStatusImpl implements _SuccessStatus {
  const _$SuccessStatusImpl();

  @override
  String toString() {
    return 'SyncStatus.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String error) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String error)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialStatus value) initial,
    required TResult Function(_LoadingStatus value) loading,
    required TResult Function(_SuccessStatus value) success,
    required TResult Function(_FailureStatus value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialStatus value)? initial,
    TResult? Function(_LoadingStatus value)? loading,
    TResult? Function(_SuccessStatus value)? success,
    TResult? Function(_FailureStatus value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialStatus value)? initial,
    TResult Function(_LoadingStatus value)? loading,
    TResult Function(_SuccessStatus value)? success,
    TResult Function(_FailureStatus value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessStatus implements SyncStatus {
  const factory _SuccessStatus() = _$SuccessStatusImpl;
}

/// @nodoc
abstract class _$$FailureStatusImplCopyWith<$Res> {
  factory _$$FailureStatusImplCopyWith(
          _$FailureStatusImpl value, $Res Function(_$FailureStatusImpl) then) =
      __$$FailureStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$FailureStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$FailureStatusImpl>
    implements _$$FailureStatusImplCopyWith<$Res> {
  __$$FailureStatusImplCopyWithImpl(
      _$FailureStatusImpl _value, $Res Function(_$FailureStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FailureStatusImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureStatusImpl implements _FailureStatus {
  const _$FailureStatusImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'SyncStatus.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureStatusImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureStatusImplCopyWith<_$FailureStatusImpl> get copyWith =>
      __$$FailureStatusImplCopyWithImpl<_$FailureStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialStatus value) initial,
    required TResult Function(_LoadingStatus value) loading,
    required TResult Function(_SuccessStatus value) success,
    required TResult Function(_FailureStatus value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialStatus value)? initial,
    TResult? Function(_LoadingStatus value)? loading,
    TResult? Function(_SuccessStatus value)? success,
    TResult? Function(_FailureStatus value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialStatus value)? initial,
    TResult Function(_LoadingStatus value)? loading,
    TResult Function(_SuccessStatus value)? success,
    TResult Function(_FailureStatus value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _FailureStatus implements SyncStatus {
  const factory _FailureStatus(final String error) = _$FailureStatusImpl;

  String get error;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureStatusImplCopyWith<_$FailureStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncTokenStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() active,
    required TResult Function() expired,
    required TResult Function() expiringSoon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? active,
    TResult? Function()? expired,
    TResult? Function()? expiringSoon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? active,
    TResult Function()? expired,
    TResult Function()? expiringSoon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoneTokenStatus value) none,
    required TResult Function(_ActiveTokenStatus value) active,
    required TResult Function(_ExpiredTokenStatus value) expired,
    required TResult Function(_ExpiringSoonTokenStatus value) expiringSoon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoneTokenStatus value)? none,
    TResult? Function(_ActiveTokenStatus value)? active,
    TResult? Function(_ExpiredTokenStatus value)? expired,
    TResult? Function(_ExpiringSoonTokenStatus value)? expiringSoon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoneTokenStatus value)? none,
    TResult Function(_ActiveTokenStatus value)? active,
    TResult Function(_ExpiredTokenStatus value)? expired,
    TResult Function(_ExpiringSoonTokenStatus value)? expiringSoon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncTokenStatusCopyWith<$Res> {
  factory $SyncTokenStatusCopyWith(
          SyncTokenStatus value, $Res Function(SyncTokenStatus) then) =
      _$SyncTokenStatusCopyWithImpl<$Res, SyncTokenStatus>;
}

/// @nodoc
class _$SyncTokenStatusCopyWithImpl<$Res, $Val extends SyncTokenStatus>
    implements $SyncTokenStatusCopyWith<$Res> {
  _$SyncTokenStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NoneTokenStatusImplCopyWith<$Res> {
  factory _$$NoneTokenStatusImplCopyWith(_$NoneTokenStatusImpl value,
          $Res Function(_$NoneTokenStatusImpl) then) =
      __$$NoneTokenStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoneTokenStatusImplCopyWithImpl<$Res>
    extends _$SyncTokenStatusCopyWithImpl<$Res, _$NoneTokenStatusImpl>
    implements _$$NoneTokenStatusImplCopyWith<$Res> {
  __$$NoneTokenStatusImplCopyWithImpl(
      _$NoneTokenStatusImpl _value, $Res Function(_$NoneTokenStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoneTokenStatusImpl implements _NoneTokenStatus {
  const _$NoneTokenStatusImpl();

  @override
  String toString() {
    return 'SyncTokenStatus.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoneTokenStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() active,
    required TResult Function() expired,
    required TResult Function() expiringSoon,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? active,
    TResult? Function()? expired,
    TResult? Function()? expiringSoon,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? active,
    TResult Function()? expired,
    TResult Function()? expiringSoon,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoneTokenStatus value) none,
    required TResult Function(_ActiveTokenStatus value) active,
    required TResult Function(_ExpiredTokenStatus value) expired,
    required TResult Function(_ExpiringSoonTokenStatus value) expiringSoon,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoneTokenStatus value)? none,
    TResult? Function(_ActiveTokenStatus value)? active,
    TResult? Function(_ExpiredTokenStatus value)? expired,
    TResult? Function(_ExpiringSoonTokenStatus value)? expiringSoon,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoneTokenStatus value)? none,
    TResult Function(_ActiveTokenStatus value)? active,
    TResult Function(_ExpiredTokenStatus value)? expired,
    TResult Function(_ExpiringSoonTokenStatus value)? expiringSoon,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _NoneTokenStatus implements SyncTokenStatus {
  const factory _NoneTokenStatus() = _$NoneTokenStatusImpl;
}

/// @nodoc
abstract class _$$ActiveTokenStatusImplCopyWith<$Res> {
  factory _$$ActiveTokenStatusImplCopyWith(_$ActiveTokenStatusImpl value,
          $Res Function(_$ActiveTokenStatusImpl) then) =
      __$$ActiveTokenStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveTokenStatusImplCopyWithImpl<$Res>
    extends _$SyncTokenStatusCopyWithImpl<$Res, _$ActiveTokenStatusImpl>
    implements _$$ActiveTokenStatusImplCopyWith<$Res> {
  __$$ActiveTokenStatusImplCopyWithImpl(_$ActiveTokenStatusImpl _value,
      $Res Function(_$ActiveTokenStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActiveTokenStatusImpl implements _ActiveTokenStatus {
  const _$ActiveTokenStatusImpl();

  @override
  String toString() {
    return 'SyncTokenStatus.active()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActiveTokenStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() active,
    required TResult Function() expired,
    required TResult Function() expiringSoon,
  }) {
    return active();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? active,
    TResult? Function()? expired,
    TResult? Function()? expiringSoon,
  }) {
    return active?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? active,
    TResult Function()? expired,
    TResult Function()? expiringSoon,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoneTokenStatus value) none,
    required TResult Function(_ActiveTokenStatus value) active,
    required TResult Function(_ExpiredTokenStatus value) expired,
    required TResult Function(_ExpiringSoonTokenStatus value) expiringSoon,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoneTokenStatus value)? none,
    TResult? Function(_ActiveTokenStatus value)? active,
    TResult? Function(_ExpiredTokenStatus value)? expired,
    TResult? Function(_ExpiringSoonTokenStatus value)? expiringSoon,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoneTokenStatus value)? none,
    TResult Function(_ActiveTokenStatus value)? active,
    TResult Function(_ExpiredTokenStatus value)? expired,
    TResult Function(_ExpiringSoonTokenStatus value)? expiringSoon,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class _ActiveTokenStatus implements SyncTokenStatus {
  const factory _ActiveTokenStatus() = _$ActiveTokenStatusImpl;
}

/// @nodoc
abstract class _$$ExpiredTokenStatusImplCopyWith<$Res> {
  factory _$$ExpiredTokenStatusImplCopyWith(_$ExpiredTokenStatusImpl value,
          $Res Function(_$ExpiredTokenStatusImpl) then) =
      __$$ExpiredTokenStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExpiredTokenStatusImplCopyWithImpl<$Res>
    extends _$SyncTokenStatusCopyWithImpl<$Res, _$ExpiredTokenStatusImpl>
    implements _$$ExpiredTokenStatusImplCopyWith<$Res> {
  __$$ExpiredTokenStatusImplCopyWithImpl(_$ExpiredTokenStatusImpl _value,
      $Res Function(_$ExpiredTokenStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExpiredTokenStatusImpl implements _ExpiredTokenStatus {
  const _$ExpiredTokenStatusImpl();

  @override
  String toString() {
    return 'SyncTokenStatus.expired()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExpiredTokenStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() active,
    required TResult Function() expired,
    required TResult Function() expiringSoon,
  }) {
    return expired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? active,
    TResult? Function()? expired,
    TResult? Function()? expiringSoon,
  }) {
    return expired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? active,
    TResult Function()? expired,
    TResult Function()? expiringSoon,
    required TResult orElse(),
  }) {
    if (expired != null) {
      return expired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoneTokenStatus value) none,
    required TResult Function(_ActiveTokenStatus value) active,
    required TResult Function(_ExpiredTokenStatus value) expired,
    required TResult Function(_ExpiringSoonTokenStatus value) expiringSoon,
  }) {
    return expired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoneTokenStatus value)? none,
    TResult? Function(_ActiveTokenStatus value)? active,
    TResult? Function(_ExpiredTokenStatus value)? expired,
    TResult? Function(_ExpiringSoonTokenStatus value)? expiringSoon,
  }) {
    return expired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoneTokenStatus value)? none,
    TResult Function(_ActiveTokenStatus value)? active,
    TResult Function(_ExpiredTokenStatus value)? expired,
    TResult Function(_ExpiringSoonTokenStatus value)? expiringSoon,
    required TResult orElse(),
  }) {
    if (expired != null) {
      return expired(this);
    }
    return orElse();
  }
}

abstract class _ExpiredTokenStatus implements SyncTokenStatus {
  const factory _ExpiredTokenStatus() = _$ExpiredTokenStatusImpl;
}

/// @nodoc
abstract class _$$ExpiringSoonTokenStatusImplCopyWith<$Res> {
  factory _$$ExpiringSoonTokenStatusImplCopyWith(
          _$ExpiringSoonTokenStatusImpl value,
          $Res Function(_$ExpiringSoonTokenStatusImpl) then) =
      __$$ExpiringSoonTokenStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExpiringSoonTokenStatusImplCopyWithImpl<$Res>
    extends _$SyncTokenStatusCopyWithImpl<$Res, _$ExpiringSoonTokenStatusImpl>
    implements _$$ExpiringSoonTokenStatusImplCopyWith<$Res> {
  __$$ExpiringSoonTokenStatusImplCopyWithImpl(
      _$ExpiringSoonTokenStatusImpl _value,
      $Res Function(_$ExpiringSoonTokenStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncTokenStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExpiringSoonTokenStatusImpl implements _ExpiringSoonTokenStatus {
  const _$ExpiringSoonTokenStatusImpl();

  @override
  String toString() {
    return 'SyncTokenStatus.expiringSoon()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpiringSoonTokenStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function() active,
    required TResult Function() expired,
    required TResult Function() expiringSoon,
  }) {
    return expiringSoon();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function()? active,
    TResult? Function()? expired,
    TResult? Function()? expiringSoon,
  }) {
    return expiringSoon?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function()? active,
    TResult Function()? expired,
    TResult Function()? expiringSoon,
    required TResult orElse(),
  }) {
    if (expiringSoon != null) {
      return expiringSoon();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NoneTokenStatus value) none,
    required TResult Function(_ActiveTokenStatus value) active,
    required TResult Function(_ExpiredTokenStatus value) expired,
    required TResult Function(_ExpiringSoonTokenStatus value) expiringSoon,
  }) {
    return expiringSoon(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NoneTokenStatus value)? none,
    TResult? Function(_ActiveTokenStatus value)? active,
    TResult? Function(_ExpiredTokenStatus value)? expired,
    TResult? Function(_ExpiringSoonTokenStatus value)? expiringSoon,
  }) {
    return expiringSoon?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NoneTokenStatus value)? none,
    TResult Function(_ActiveTokenStatus value)? active,
    TResult Function(_ExpiredTokenStatus value)? expired,
    TResult Function(_ExpiringSoonTokenStatus value)? expiringSoon,
    required TResult orElse(),
  }) {
    if (expiringSoon != null) {
      return expiringSoon(this);
    }
    return orElse();
  }
}

abstract class _ExpiringSoonTokenStatus implements SyncTokenStatus {
  const factory _ExpiringSoonTokenStatus() = _$ExpiringSoonTokenStatusImpl;
}

/// @nodoc
mixin _$SyncState {
  SyncStatus get status => throw _privateConstructorUsedError;
  List<DateTime> get history => throw _privateConstructorUsedError;
  SyncTokenStatus get tokenStatus => throw _privateConstructorUsedError;
  SyncToken? get currentToken => throw _privateConstructorUsedError;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncStateCopyWith<SyncState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStateCopyWith<$Res> {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) then) =
      _$SyncStateCopyWithImpl<$Res, SyncState>;
  @useResult
  $Res call(
      {SyncStatus status,
      List<DateTime> history,
      SyncTokenStatus tokenStatus,
      SyncToken? currentToken});

  $SyncStatusCopyWith<$Res> get status;
  $SyncTokenStatusCopyWith<$Res> get tokenStatus;
  $SyncTokenCopyWith<$Res>? get currentToken;
}

/// @nodoc
class _$SyncStateCopyWithImpl<$Res, $Val extends SyncState>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? history = null,
    Object? tokenStatus = null,
    Object? currentToken = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      tokenStatus: null == tokenStatus
          ? _value.tokenStatus
          : tokenStatus // ignore: cast_nullable_to_non_nullable
              as SyncTokenStatus,
      currentToken: freezed == currentToken
          ? _value.currentToken
          : currentToken // ignore: cast_nullable_to_non_nullable
              as SyncToken?,
    ) as $Val);
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncStatusCopyWith<$Res> get status {
    return $SyncStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncTokenStatusCopyWith<$Res> get tokenStatus {
    return $SyncTokenStatusCopyWith<$Res>(_value.tokenStatus, (value) {
      return _then(_value.copyWith(tokenStatus: value) as $Val);
    });
  }

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SyncTokenCopyWith<$Res>? get currentToken {
    if (_value.currentToken == null) {
      return null;
    }

    return $SyncTokenCopyWith<$Res>(_value.currentToken!, (value) {
      return _then(_value.copyWith(currentToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncStateImplCopyWith<$Res>
    implements $SyncStateCopyWith<$Res> {
  factory _$$SyncStateImplCopyWith(
          _$SyncStateImpl value, $Res Function(_$SyncStateImpl) then) =
      __$$SyncStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncStatus status,
      List<DateTime> history,
      SyncTokenStatus tokenStatus,
      SyncToken? currentToken});

  @override
  $SyncStatusCopyWith<$Res> get status;
  @override
  $SyncTokenStatusCopyWith<$Res> get tokenStatus;
  @override
  $SyncTokenCopyWith<$Res>? get currentToken;
}

/// @nodoc
class __$$SyncStateImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncStateImpl>
    implements _$$SyncStateImplCopyWith<$Res> {
  __$$SyncStateImplCopyWithImpl(
      _$SyncStateImpl _value, $Res Function(_$SyncStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? history = null,
    Object? tokenStatus = null,
    Object? currentToken = freezed,
  }) {
    return _then(_$SyncStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      tokenStatus: null == tokenStatus
          ? _value.tokenStatus
          : tokenStatus // ignore: cast_nullable_to_non_nullable
              as SyncTokenStatus,
      currentToken: freezed == currentToken
          ? _value.currentToken
          : currentToken // ignore: cast_nullable_to_non_nullable
              as SyncToken?,
    ));
  }
}

/// @nodoc

class _$SyncStateImpl implements _SyncState {
  const _$SyncStateImpl(
      {this.status = const SyncStatus.initial(),
      final List<DateTime> history = const [],
      this.tokenStatus = const SyncTokenStatus.none(),
      this.currentToken})
      : _history = history;

  @override
  @JsonKey()
  final SyncStatus status;
  final List<DateTime> _history;
  @override
  @JsonKey()
  List<DateTime> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final SyncTokenStatus tokenStatus;
  @override
  final SyncToken? currentToken;

  @override
  String toString() {
    return 'SyncState(status: $status, history: $history, tokenStatus: $tokenStatus, currentToken: $currentToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.tokenStatus, tokenStatus) ||
                other.tokenStatus == tokenStatus) &&
            (identical(other.currentToken, currentToken) ||
                other.currentToken == currentToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_history), tokenStatus, currentToken);

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStateImplCopyWith<_$SyncStateImpl> get copyWith =>
      __$$SyncStateImplCopyWithImpl<_$SyncStateImpl>(this, _$identity);
}

abstract class _SyncState implements SyncState {
  const factory _SyncState(
      {final SyncStatus status,
      final List<DateTime> history,
      final SyncTokenStatus tokenStatus,
      final SyncToken? currentToken}) = _$SyncStateImpl;

  @override
  SyncStatus get status;
  @override
  List<DateTime> get history;
  @override
  SyncTokenStatus get tokenStatus;
  @override
  SyncToken? get currentToken;

  /// Create a copy of SyncState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncStateImplCopyWith<_$SyncStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
