// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records_filter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecordsFilterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String filter) toggleFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String filter)? toggleFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String filter)? toggleFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_ToggleFilter value) toggleFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_ToggleFilter value)? toggleFilter,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_ToggleFilter value)? toggleFilter,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsFilterEventCopyWith<$Res> {
  factory $RecordsFilterEventCopyWith(
          RecordsFilterEvent value, $Res Function(RecordsFilterEvent) then) =
      _$RecordsFilterEventCopyWithImpl<$Res, RecordsFilterEvent>;
}

/// @nodoc
class _$RecordsFilterEventCopyWithImpl<$Res, $Val extends RecordsFilterEvent>
    implements $RecordsFilterEventCopyWith<$Res> {
  _$RecordsFilterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordsFilterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$RecordsFilterEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsFilterEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'RecordsFilterEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String filter) toggleFilter,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String filter)? toggleFilter,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String filter)? toggleFilter,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_ToggleFilter value) toggleFilter,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_ToggleFilter value)? toggleFilter,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_ToggleFilter value)? toggleFilter,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements RecordsFilterEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$ToggleFilterImplCopyWith<$Res> {
  factory _$$ToggleFilterImplCopyWith(
          _$ToggleFilterImpl value, $Res Function(_$ToggleFilterImpl) then) =
      __$$ToggleFilterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String filter});
}

/// @nodoc
class __$$ToggleFilterImplCopyWithImpl<$Res>
    extends _$RecordsFilterEventCopyWithImpl<$Res, _$ToggleFilterImpl>
    implements _$$ToggleFilterImplCopyWith<$Res> {
  __$$ToggleFilterImplCopyWithImpl(
      _$ToggleFilterImpl _value, $Res Function(_$ToggleFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsFilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$ToggleFilterImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggleFilterImpl implements _ToggleFilter {
  const _$ToggleFilterImpl(this.filter);

  @override
  final String filter;

  @override
  String toString() {
    return 'RecordsFilterEvent.toggleFilter(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleFilterImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of RecordsFilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleFilterImplCopyWith<_$ToggleFilterImpl> get copyWith =>
      __$$ToggleFilterImplCopyWithImpl<_$ToggleFilterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String filter) toggleFilter,
  }) {
    return toggleFilter(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String filter)? toggleFilter,
  }) {
    return toggleFilter?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String filter)? toggleFilter,
    required TResult orElse(),
  }) {
    if (toggleFilter != null) {
      return toggleFilter(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_ToggleFilter value) toggleFilter,
  }) {
    return toggleFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_ToggleFilter value)? toggleFilter,
  }) {
    return toggleFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_ToggleFilter value)? toggleFilter,
    required TResult orElse(),
  }) {
    if (toggleFilter != null) {
      return toggleFilter(this);
    }
    return orElse();
  }
}

abstract class _ToggleFilter implements RecordsFilterEvent {
  const factory _ToggleFilter(final String filter) = _$ToggleFilterImpl;

  String get filter;

  /// Create a copy of RecordsFilterEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleFilterImplCopyWith<_$ToggleFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecordsFilterState {
  Set<String> get activeFilters => throw _privateConstructorUsedError;
  List<String> get availableFilters => throw _privateConstructorUsedError;

  /// Create a copy of RecordsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordsFilterStateCopyWith<RecordsFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsFilterStateCopyWith<$Res> {
  factory $RecordsFilterStateCopyWith(
          RecordsFilterState value, $Res Function(RecordsFilterState) then) =
      _$RecordsFilterStateCopyWithImpl<$Res, RecordsFilterState>;
  @useResult
  $Res call({Set<String> activeFilters, List<String> availableFilters});
}

/// @nodoc
class _$RecordsFilterStateCopyWithImpl<$Res, $Val extends RecordsFilterState>
    implements $RecordsFilterStateCopyWith<$Res> {
  _$RecordsFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeFilters = null,
    Object? availableFilters = null,
  }) {
    return _then(_value.copyWith(
      activeFilters: null == activeFilters
          ? _value.activeFilters
          : activeFilters // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      availableFilters: null == availableFilters
          ? _value.availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordsFilterStateImplCopyWith<$Res>
    implements $RecordsFilterStateCopyWith<$Res> {
  factory _$$RecordsFilterStateImplCopyWith(_$RecordsFilterStateImpl value,
          $Res Function(_$RecordsFilterStateImpl) then) =
      __$$RecordsFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<String> activeFilters, List<String> availableFilters});
}

/// @nodoc
class __$$RecordsFilterStateImplCopyWithImpl<$Res>
    extends _$RecordsFilterStateCopyWithImpl<$Res, _$RecordsFilterStateImpl>
    implements _$$RecordsFilterStateImplCopyWith<$Res> {
  __$$RecordsFilterStateImplCopyWithImpl(_$RecordsFilterStateImpl _value,
      $Res Function(_$RecordsFilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeFilters = null,
    Object? availableFilters = null,
  }) {
    return _then(_$RecordsFilterStateImpl(
      activeFilters: null == activeFilters
          ? _value._activeFilters
          : activeFilters // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      availableFilters: null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$RecordsFilterStateImpl implements _RecordsFilterState {
  const _$RecordsFilterStateImpl(
      {final Set<String> activeFilters = const {},
      final List<String> availableFilters = const []})
      : _activeFilters = activeFilters,
        _availableFilters = availableFilters;

  final Set<String> _activeFilters;
  @override
  @JsonKey()
  Set<String> get activeFilters {
    if (_activeFilters is EqualUnmodifiableSetView) return _activeFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeFilters);
  }

  final List<String> _availableFilters;
  @override
  @JsonKey()
  List<String> get availableFilters {
    if (_availableFilters is EqualUnmodifiableListView)
      return _availableFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableFilters);
  }

  @override
  String toString() {
    return 'RecordsFilterState(activeFilters: $activeFilters, availableFilters: $availableFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordsFilterStateImpl &&
            const DeepCollectionEquality()
                .equals(other._activeFilters, _activeFilters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeFilters),
      const DeepCollectionEquality().hash(_availableFilters));

  /// Create a copy of RecordsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordsFilterStateImplCopyWith<_$RecordsFilterStateImpl> get copyWith =>
      __$$RecordsFilterStateImplCopyWithImpl<_$RecordsFilterStateImpl>(
          this, _$identity);
}

abstract class _RecordsFilterState implements RecordsFilterState {
  const factory _RecordsFilterState(
      {final Set<String> activeFilters,
      final List<String> availableFilters}) = _$RecordsFilterStateImpl;

  @override
  Set<String> get activeFilters;
  @override
  List<String> get availableFilters;

  /// Create a copy of RecordsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordsFilterStateImplCopyWith<_$RecordsFilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
