// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encounter_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EncounterDetailEvent {
  String get encounterId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String encounterId) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String encounterId)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String encounterId)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of EncounterDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterDetailEventCopyWith<EncounterDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterDetailEventCopyWith<$Res> {
  factory $EncounterDetailEventCopyWith(EncounterDetailEvent value,
          $Res Function(EncounterDetailEvent) then) =
      _$EncounterDetailEventCopyWithImpl<$Res, EncounterDetailEvent>;
  @useResult
  $Res call({String encounterId});
}

/// @nodoc
class _$EncounterDetailEventCopyWithImpl<$Res,
        $Val extends EncounterDetailEvent>
    implements $EncounterDetailEventCopyWith<$Res> {
  _$EncounterDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EncounterDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encounterId = null,
  }) {
    return _then(_value.copyWith(
      encounterId: null == encounterId
          ? _value.encounterId
          : encounterId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res>
    implements $EncounterDetailEventCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String encounterId});
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$EncounterDetailEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of EncounterDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encounterId = null,
  }) {
    return _then(_$LoadImpl(
      null == encounterId
          ? _value.encounterId
          : encounterId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl(this.encounterId);

  @override
  final String encounterId;

  @override
  String toString() {
    return 'EncounterDetailEvent.load(encounterId: $encounterId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadImpl &&
            (identical(other.encounterId, encounterId) ||
                other.encounterId == encounterId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, encounterId);

  /// Create a copy of EncounterDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      __$$LoadImplCopyWithImpl<_$LoadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String encounterId) load,
  }) {
    return load(encounterId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String encounterId)? load,
  }) {
    return load?.call(encounterId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String encounterId)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(encounterId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements EncounterDetailEvent {
  const factory _Load(final String encounterId) = _$LoadImpl;

  @override
  String get encounterId;

  /// Create a copy of EncounterDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EncounterDetailState {
  EncounterDetailStatus get status => throw _privateConstructorUsedError;
  Map<String, List<FhirResourceDisplayModel>> get relatedResources =>
      throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  /// Create a copy of EncounterDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterDetailStateCopyWith<EncounterDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterDetailStateCopyWith<$Res> {
  factory $EncounterDetailStateCopyWith(EncounterDetailState value,
          $Res Function(EncounterDetailState) then) =
      _$EncounterDetailStateCopyWithImpl<$Res, EncounterDetailState>;
  @useResult
  $Res call(
      {EncounterDetailStatus status,
      Map<String, List<FhirResourceDisplayModel>> relatedResources,
      String error});
}

/// @nodoc
class _$EncounterDetailStateCopyWithImpl<$Res,
        $Val extends EncounterDetailState>
    implements $EncounterDetailStateCopyWith<$Res> {
  _$EncounterDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EncounterDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? relatedResources = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EncounterDetailStatus,
      relatedResources: null == relatedResources
          ? _value.relatedResources
          : relatedResources // ignore: cast_nullable_to_non_nullable
              as Map<String, List<FhirResourceDisplayModel>>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EncounterDetailStateImplCopyWith<$Res>
    implements $EncounterDetailStateCopyWith<$Res> {
  factory _$$EncounterDetailStateImplCopyWith(_$EncounterDetailStateImpl value,
          $Res Function(_$EncounterDetailStateImpl) then) =
      __$$EncounterDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EncounterDetailStatus status,
      Map<String, List<FhirResourceDisplayModel>> relatedResources,
      String error});
}

/// @nodoc
class __$$EncounterDetailStateImplCopyWithImpl<$Res>
    extends _$EncounterDetailStateCopyWithImpl<$Res, _$EncounterDetailStateImpl>
    implements _$$EncounterDetailStateImplCopyWith<$Res> {
  __$$EncounterDetailStateImplCopyWithImpl(_$EncounterDetailStateImpl _value,
      $Res Function(_$EncounterDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EncounterDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? relatedResources = null,
    Object? error = null,
  }) {
    return _then(_$EncounterDetailStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EncounterDetailStatus,
      relatedResources: null == relatedResources
          ? _value._relatedResources
          : relatedResources // ignore: cast_nullable_to_non_nullable
              as Map<String, List<FhirResourceDisplayModel>>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EncounterDetailStateImpl implements _EncounterDetailState {
  const _$EncounterDetailStateImpl(
      {this.status = EncounterDetailStatus.initial,
      final Map<String, List<FhirResourceDisplayModel>> relatedResources =
          const {},
      this.error = ''})
      : _relatedResources = relatedResources;

  @override
  @JsonKey()
  final EncounterDetailStatus status;
  final Map<String, List<FhirResourceDisplayModel>> _relatedResources;
  @override
  @JsonKey()
  Map<String, List<FhirResourceDisplayModel>> get relatedResources {
    if (_relatedResources is EqualUnmodifiableMapView) return _relatedResources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_relatedResources);
  }

  @override
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'EncounterDetailState(status: $status, relatedResources: $relatedResources, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncounterDetailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._relatedResources, _relatedResources) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_relatedResources), error);

  /// Create a copy of EncounterDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncounterDetailStateImplCopyWith<_$EncounterDetailStateImpl>
      get copyWith =>
          __$$EncounterDetailStateImplCopyWithImpl<_$EncounterDetailStateImpl>(
              this, _$identity);
}

abstract class _EncounterDetailState implements EncounterDetailState {
  const factory _EncounterDetailState(
      {final EncounterDetailStatus status,
      final Map<String, List<FhirResourceDisplayModel>> relatedResources,
      final String error}) = _$EncounterDetailStateImpl;

  @override
  EncounterDetailStatus get status;
  @override
  Map<String, List<FhirResourceDisplayModel>> get relatedResources;
  @override
  String get error;

  /// Create a copy of EncounterDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncounterDetailStateImplCopyWith<_$EncounterDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
