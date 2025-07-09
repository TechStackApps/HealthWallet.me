// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecordsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? sourceId, String? filter) loadRecords,
    required TResult Function(List<String> filters) updateFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? sourceId, String? filter)? loadRecords,
    TResult? Function(List<String> filters)? updateFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? sourceId, String? filter)? loadRecords,
    TResult Function(List<String> filters)? updateFilters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRecords value) loadRecords,
    required TResult Function(_UpdateFilters value) updateFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRecords value)? loadRecords,
    TResult? Function(_UpdateFilters value)? updateFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRecords value)? loadRecords,
    TResult Function(_UpdateFilters value)? updateFilters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsEventCopyWith<$Res> {
  factory $RecordsEventCopyWith(
          RecordsEvent value, $Res Function(RecordsEvent) then) =
      _$RecordsEventCopyWithImpl<$Res, RecordsEvent>;
}

/// @nodoc
class _$RecordsEventCopyWithImpl<$Res, $Val extends RecordsEvent>
    implements $RecordsEventCopyWith<$Res> {
  _$RecordsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadRecordsImplCopyWith<$Res> {
  factory _$$LoadRecordsImplCopyWith(
          _$LoadRecordsImpl value, $Res Function(_$LoadRecordsImpl) then) =
      __$$LoadRecordsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? sourceId, String? filter});
}

/// @nodoc
class __$$LoadRecordsImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$LoadRecordsImpl>
    implements _$$LoadRecordsImplCopyWith<$Res> {
  __$$LoadRecordsImplCopyWithImpl(
      _$LoadRecordsImpl _value, $Res Function(_$LoadRecordsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceId = freezed,
    Object? filter = freezed,
  }) {
    return _then(_$LoadRecordsImpl(
      sourceId: freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadRecordsImpl implements _LoadRecords {
  const _$LoadRecordsImpl({this.sourceId, this.filter});

  @override
  final String? sourceId;
  @override
  final String? filter;

  @override
  String toString() {
    return 'RecordsEvent.loadRecords(sourceId: $sourceId, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRecordsImpl &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourceId, filter);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRecordsImplCopyWith<_$LoadRecordsImpl> get copyWith =>
      __$$LoadRecordsImplCopyWithImpl<_$LoadRecordsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? sourceId, String? filter) loadRecords,
    required TResult Function(List<String> filters) updateFilters,
  }) {
    return loadRecords(sourceId, filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? sourceId, String? filter)? loadRecords,
    TResult? Function(List<String> filters)? updateFilters,
  }) {
    return loadRecords?.call(sourceId, filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? sourceId, String? filter)? loadRecords,
    TResult Function(List<String> filters)? updateFilters,
    required TResult orElse(),
  }) {
    if (loadRecords != null) {
      return loadRecords(sourceId, filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRecords value) loadRecords,
    required TResult Function(_UpdateFilters value) updateFilters,
  }) {
    return loadRecords(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRecords value)? loadRecords,
    TResult? Function(_UpdateFilters value)? updateFilters,
  }) {
    return loadRecords?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRecords value)? loadRecords,
    TResult Function(_UpdateFilters value)? updateFilters,
    required TResult orElse(),
  }) {
    if (loadRecords != null) {
      return loadRecords(this);
    }
    return orElse();
  }
}

abstract class _LoadRecords implements RecordsEvent {
  const factory _LoadRecords({final String? sourceId, final String? filter}) =
      _$LoadRecordsImpl;

  String? get sourceId;
  String? get filter;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadRecordsImplCopyWith<_$LoadRecordsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateFiltersImplCopyWith<$Res> {
  factory _$$UpdateFiltersImplCopyWith(
          _$UpdateFiltersImpl value, $Res Function(_$UpdateFiltersImpl) then) =
      __$$UpdateFiltersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> filters});
}

/// @nodoc
class __$$UpdateFiltersImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$UpdateFiltersImpl>
    implements _$$UpdateFiltersImplCopyWith<$Res> {
  __$$UpdateFiltersImplCopyWithImpl(
      _$UpdateFiltersImpl _value, $Res Function(_$UpdateFiltersImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = null,
  }) {
    return _then(_$UpdateFiltersImpl(
      null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$UpdateFiltersImpl implements _UpdateFilters {
  const _$UpdateFiltersImpl(final List<String> filters) : _filters = filters;

  final List<String> _filters;
  @override
  List<String> get filters {
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filters);
  }

  @override
  String toString() {
    return 'RecordsEvent.updateFilters(filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateFiltersImpl &&
            const DeepCollectionEquality().equals(other._filters, _filters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_filters));

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateFiltersImplCopyWith<_$UpdateFiltersImpl> get copyWith =>
      __$$UpdateFiltersImplCopyWithImpl<_$UpdateFiltersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? sourceId, String? filter) loadRecords,
    required TResult Function(List<String> filters) updateFilters,
  }) {
    return updateFilters(filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? sourceId, String? filter)? loadRecords,
    TResult? Function(List<String> filters)? updateFilters,
  }) {
    return updateFilters?.call(filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? sourceId, String? filter)? loadRecords,
    TResult Function(List<String> filters)? updateFilters,
    required TResult orElse(),
  }) {
    if (updateFilters != null) {
      return updateFilters(filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRecords value) loadRecords,
    required TResult Function(_UpdateFilters value) updateFilters,
  }) {
    return updateFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRecords value)? loadRecords,
    TResult? Function(_UpdateFilters value)? updateFilters,
  }) {
    return updateFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRecords value)? loadRecords,
    TResult Function(_UpdateFilters value)? updateFilters,
    required TResult orElse(),
  }) {
    if (updateFilters != null) {
      return updateFilters(this);
    }
    return orElse();
  }
}

abstract class _UpdateFilters implements RecordsEvent {
  const factory _UpdateFilters(final List<String> filters) =
      _$UpdateFiltersImpl;

  List<String> get filters;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateFiltersImplCopyWith<_$UpdateFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecordsState {
  RecordsStatus get status => throw _privateConstructorUsedError;
  List<FhirResource> get entries => throw _privateConstructorUsedError;
  List<String> get filters => throw _privateConstructorUsedError;
  List<String> get availableFilters => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordsStateCopyWith<RecordsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsStateCopyWith<$Res> {
  factory $RecordsStateCopyWith(
          RecordsState value, $Res Function(RecordsState) then) =
      _$RecordsStateCopyWithImpl<$Res, RecordsState>;
  @useResult
  $Res call(
      {RecordsStatus status,
      List<FhirResource> entries,
      List<String> filters,
      List<String> availableFilters,
      String error});
}

/// @nodoc
class _$RecordsStateCopyWithImpl<$Res, $Val extends RecordsState>
    implements $RecordsStateCopyWith<$Res> {
  _$RecordsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? entries = null,
    Object? filters = null,
    Object? availableFilters = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecordsStatus,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<FhirResource>,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value.availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordsStateImplCopyWith<$Res>
    implements $RecordsStateCopyWith<$Res> {
  factory _$$RecordsStateImplCopyWith(
          _$RecordsStateImpl value, $Res Function(_$RecordsStateImpl) then) =
      __$$RecordsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecordsStatus status,
      List<FhirResource> entries,
      List<String> filters,
      List<String> availableFilters,
      String error});
}

/// @nodoc
class __$$RecordsStateImplCopyWithImpl<$Res>
    extends _$RecordsStateCopyWithImpl<$Res, _$RecordsStateImpl>
    implements _$$RecordsStateImplCopyWith<$Res> {
  __$$RecordsStateImplCopyWithImpl(
      _$RecordsStateImpl _value, $Res Function(_$RecordsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? entries = null,
    Object? filters = null,
    Object? availableFilters = null,
    Object? error = null,
  }) {
    return _then(_$RecordsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecordsStatus,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<FhirResource>,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RecordsStateImpl implements _RecordsState {
  const _$RecordsStateImpl(
      {this.status = RecordsStatus.initial,
      final List<FhirResource> entries = const [],
      final List<String> filters = const [],
      final List<String> availableFilters = const [],
      this.error = ''})
      : _entries = entries,
        _filters = filters,
        _availableFilters = availableFilters;

  @override
  @JsonKey()
  final RecordsStatus status;
  final List<FhirResource> _entries;
  @override
  @JsonKey()
  List<FhirResource> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  final List<String> _filters;
  @override
  @JsonKey()
  List<String> get filters {
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filters);
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
  @JsonKey()
  final String error;

  @override
  String toString() {
    return 'RecordsState(status: $status, entries: $entries, filters: $filters, availableFilters: $availableFilters, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_entries),
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_availableFilters),
      error);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordsStateImplCopyWith<_$RecordsStateImpl> get copyWith =>
      __$$RecordsStateImplCopyWithImpl<_$RecordsStateImpl>(this, _$identity);
}

abstract class _RecordsState implements RecordsState {
  const factory _RecordsState(
      {final RecordsStatus status,
      final List<FhirResource> entries,
      final List<String> filters,
      final List<String> availableFilters,
      final String error}) = _$RecordsStateImpl;

  @override
  RecordsStatus get status;
  @override
  List<FhirResource> get entries;
  @override
  List<String> get filters;
  @override
  List<String> get availableFilters;
  @override
  String get error;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordsStateImplCopyWith<_$RecordsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
