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
    required TResult Function(String resourceType) fetchRecords,
    required TResult Function(String filter) addFilter,
    required TResult Function(String filter) removeFilter,
    required TResult Function() clearFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String resourceType)? fetchRecords,
    TResult? Function(String filter)? addFilter,
    TResult? Function(String filter)? removeFilter,
    TResult? Function()? clearFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String resourceType)? fetchRecords,
    TResult Function(String filter)? addFilter,
    TResult Function(String filter)? removeFilter,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchRecords value) fetchRecords,
    required TResult Function(_AddFilter value) addFilter,
    required TResult Function(_RemoveFilter value) removeFilter,
    required TResult Function(_ClearFilters value) clearFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchRecords value)? fetchRecords,
    TResult? Function(_AddFilter value)? addFilter,
    TResult? Function(_RemoveFilter value)? removeFilter,
    TResult? Function(_ClearFilters value)? clearFilters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchRecords value)? fetchRecords,
    TResult Function(_AddFilter value)? addFilter,
    TResult Function(_RemoveFilter value)? removeFilter,
    TResult Function(_ClearFilters value)? clearFilters,
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
abstract class _$$FetchRecordsImplCopyWith<$Res> {
  factory _$$FetchRecordsImplCopyWith(
          _$FetchRecordsImpl value, $Res Function(_$FetchRecordsImpl) then) =
      __$$FetchRecordsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String resourceType});
}

/// @nodoc
class __$$FetchRecordsImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$FetchRecordsImpl>
    implements _$$FetchRecordsImplCopyWith<$Res> {
  __$$FetchRecordsImplCopyWithImpl(
      _$FetchRecordsImpl _value, $Res Function(_$FetchRecordsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resourceType = null,
  }) {
    return _then(_$FetchRecordsImpl(
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchRecordsImpl implements _FetchRecords {
  const _$FetchRecordsImpl({required this.resourceType});

  @override
  final String resourceType;

  @override
  String toString() {
    return 'RecordsEvent.fetchRecords(resourceType: $resourceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchRecordsImpl &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resourceType);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchRecordsImplCopyWith<_$FetchRecordsImpl> get copyWith =>
      __$$FetchRecordsImplCopyWithImpl<_$FetchRecordsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String resourceType) fetchRecords,
    required TResult Function(String filter) addFilter,
    required TResult Function(String filter) removeFilter,
    required TResult Function() clearFilters,
  }) {
    return fetchRecords(resourceType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String resourceType)? fetchRecords,
    TResult? Function(String filter)? addFilter,
    TResult? Function(String filter)? removeFilter,
    TResult? Function()? clearFilters,
  }) {
    return fetchRecords?.call(resourceType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String resourceType)? fetchRecords,
    TResult Function(String filter)? addFilter,
    TResult Function(String filter)? removeFilter,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (fetchRecords != null) {
      return fetchRecords(resourceType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchRecords value) fetchRecords,
    required TResult Function(_AddFilter value) addFilter,
    required TResult Function(_RemoveFilter value) removeFilter,
    required TResult Function(_ClearFilters value) clearFilters,
  }) {
    return fetchRecords(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchRecords value)? fetchRecords,
    TResult? Function(_AddFilter value)? addFilter,
    TResult? Function(_RemoveFilter value)? removeFilter,
    TResult? Function(_ClearFilters value)? clearFilters,
  }) {
    return fetchRecords?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchRecords value)? fetchRecords,
    TResult Function(_AddFilter value)? addFilter,
    TResult Function(_RemoveFilter value)? removeFilter,
    TResult Function(_ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (fetchRecords != null) {
      return fetchRecords(this);
    }
    return orElse();
  }
}

abstract class _FetchRecords implements RecordsEvent {
  const factory _FetchRecords({required final String resourceType}) =
      _$FetchRecordsImpl;

  String get resourceType;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchRecordsImplCopyWith<_$FetchRecordsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddFilterImplCopyWith<$Res> {
  factory _$$AddFilterImplCopyWith(
          _$AddFilterImpl value, $Res Function(_$AddFilterImpl) then) =
      __$$AddFilterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String filter});
}

/// @nodoc
class __$$AddFilterImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$AddFilterImpl>
    implements _$$AddFilterImplCopyWith<$Res> {
  __$$AddFilterImplCopyWithImpl(
      _$AddFilterImpl _value, $Res Function(_$AddFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$AddFilterImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddFilterImpl implements _AddFilter {
  const _$AddFilterImpl(this.filter);

  @override
  final String filter;

  @override
  String toString() {
    return 'RecordsEvent.addFilter(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFilterImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFilterImplCopyWith<_$AddFilterImpl> get copyWith =>
      __$$AddFilterImplCopyWithImpl<_$AddFilterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String resourceType) fetchRecords,
    required TResult Function(String filter) addFilter,
    required TResult Function(String filter) removeFilter,
    required TResult Function() clearFilters,
  }) {
    return addFilter(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String resourceType)? fetchRecords,
    TResult? Function(String filter)? addFilter,
    TResult? Function(String filter)? removeFilter,
    TResult? Function()? clearFilters,
  }) {
    return addFilter?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String resourceType)? fetchRecords,
    TResult Function(String filter)? addFilter,
    TResult Function(String filter)? removeFilter,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (addFilter != null) {
      return addFilter(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchRecords value) fetchRecords,
    required TResult Function(_AddFilter value) addFilter,
    required TResult Function(_RemoveFilter value) removeFilter,
    required TResult Function(_ClearFilters value) clearFilters,
  }) {
    return addFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchRecords value)? fetchRecords,
    TResult? Function(_AddFilter value)? addFilter,
    TResult? Function(_RemoveFilter value)? removeFilter,
    TResult? Function(_ClearFilters value)? clearFilters,
  }) {
    return addFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchRecords value)? fetchRecords,
    TResult Function(_AddFilter value)? addFilter,
    TResult Function(_RemoveFilter value)? removeFilter,
    TResult Function(_ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (addFilter != null) {
      return addFilter(this);
    }
    return orElse();
  }
}

abstract class _AddFilter implements RecordsEvent {
  const factory _AddFilter(final String filter) = _$AddFilterImpl;

  String get filter;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddFilterImplCopyWith<_$AddFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFilterImplCopyWith<$Res> {
  factory _$$RemoveFilterImplCopyWith(
          _$RemoveFilterImpl value, $Res Function(_$RemoveFilterImpl) then) =
      __$$RemoveFilterImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String filter});
}

/// @nodoc
class __$$RemoveFilterImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$RemoveFilterImpl>
    implements _$$RemoveFilterImplCopyWith<$Res> {
  __$$RemoveFilterImplCopyWithImpl(
      _$RemoveFilterImpl _value, $Res Function(_$RemoveFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$RemoveFilterImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveFilterImpl implements _RemoveFilter {
  const _$RemoveFilterImpl(this.filter);

  @override
  final String filter;

  @override
  String toString() {
    return 'RecordsEvent.removeFilter(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFilterImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFilterImplCopyWith<_$RemoveFilterImpl> get copyWith =>
      __$$RemoveFilterImplCopyWithImpl<_$RemoveFilterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String resourceType) fetchRecords,
    required TResult Function(String filter) addFilter,
    required TResult Function(String filter) removeFilter,
    required TResult Function() clearFilters,
  }) {
    return removeFilter(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String resourceType)? fetchRecords,
    TResult? Function(String filter)? addFilter,
    TResult? Function(String filter)? removeFilter,
    TResult? Function()? clearFilters,
  }) {
    return removeFilter?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String resourceType)? fetchRecords,
    TResult Function(String filter)? addFilter,
    TResult Function(String filter)? removeFilter,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (removeFilter != null) {
      return removeFilter(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchRecords value) fetchRecords,
    required TResult Function(_AddFilter value) addFilter,
    required TResult Function(_RemoveFilter value) removeFilter,
    required TResult Function(_ClearFilters value) clearFilters,
  }) {
    return removeFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchRecords value)? fetchRecords,
    TResult? Function(_AddFilter value)? addFilter,
    TResult? Function(_RemoveFilter value)? removeFilter,
    TResult? Function(_ClearFilters value)? clearFilters,
  }) {
    return removeFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchRecords value)? fetchRecords,
    TResult Function(_AddFilter value)? addFilter,
    TResult Function(_RemoveFilter value)? removeFilter,
    TResult Function(_ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (removeFilter != null) {
      return removeFilter(this);
    }
    return orElse();
  }
}

abstract class _RemoveFilter implements RecordsEvent {
  const factory _RemoveFilter(final String filter) = _$RemoveFilterImpl;

  String get filter;

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFilterImplCopyWith<_$RemoveFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFiltersImplCopyWith<$Res> {
  factory _$$ClearFiltersImplCopyWith(
          _$ClearFiltersImpl value, $Res Function(_$ClearFiltersImpl) then) =
      __$$ClearFiltersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFiltersImplCopyWithImpl<$Res>
    extends _$RecordsEventCopyWithImpl<$Res, _$ClearFiltersImpl>
    implements _$$ClearFiltersImplCopyWith<$Res> {
  __$$ClearFiltersImplCopyWithImpl(
      _$ClearFiltersImpl _value, $Res Function(_$ClearFiltersImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFiltersImpl implements _ClearFilters {
  const _$ClearFiltersImpl();

  @override
  String toString() {
    return 'RecordsEvent.clearFilters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFiltersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String resourceType) fetchRecords,
    required TResult Function(String filter) addFilter,
    required TResult Function(String filter) removeFilter,
    required TResult Function() clearFilters,
  }) {
    return clearFilters();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String resourceType)? fetchRecords,
    TResult? Function(String filter)? addFilter,
    TResult? Function(String filter)? removeFilter,
    TResult? Function()? clearFilters,
  }) {
    return clearFilters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String resourceType)? fetchRecords,
    TResult Function(String filter)? addFilter,
    TResult Function(String filter)? removeFilter,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchRecords value) fetchRecords,
    required TResult Function(_AddFilter value) addFilter,
    required TResult Function(_RemoveFilter value) removeFilter,
    required TResult Function(_ClearFilters value) clearFilters,
  }) {
    return clearFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchRecords value)? fetchRecords,
    TResult? Function(_AddFilter value)? addFilter,
    TResult? Function(_RemoveFilter value)? removeFilter,
    TResult? Function(_ClearFilters value)? clearFilters,
  }) {
    return clearFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchRecords value)? fetchRecords,
    TResult Function(_AddFilter value)? addFilter,
    TResult Function(_RemoveFilter value)? removeFilter,
    TResult Function(_ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters(this);
    }
    return orElse();
  }
}

abstract class _ClearFilters implements RecordsEvent {
  const factory _ClearFilters() = _$ClearFiltersImpl;
}

/// @nodoc
mixin _$RecordsState {
  List<String> get filters => throw _privateConstructorUsedError;
  List<String> get availableFilters => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        initial,
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        loading,
    required TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)
        loaded,
    required TResult Function(
            String message, List<String> filters, List<String> availableFilters)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult? Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult? Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult? Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

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
  $Res call({List<String> filters, List<String> availableFilters});
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
    Object? filters = null,
    Object? availableFilters = null,
  }) {
    return _then(_value.copyWith(
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value.availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $RecordsStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> filters, List<String> availableFilters});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$RecordsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = null,
    Object? availableFilters = null,
  }) {
    return _then(_$InitialImpl(
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {final List<String> filters = const [],
      final List<String> availableFilters = const []})
      : _filters = filters,
        _availableFilters = availableFilters;

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
  String toString() {
    return 'RecordsState.initial(filters: $filters, availableFilters: $availableFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_availableFilters));

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        initial,
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        loading,
    required TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)
        loaded,
    required TResult Function(
            String message, List<String> filters, List<String> availableFilters)
        error,
  }) {
    return initial(filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult? Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult? Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult? Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
  }) {
    return initial?.call(filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(filters, availableFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RecordsState {
  const factory _Initial(
      {final List<String> filters,
      final List<String> availableFilters}) = _$InitialImpl;

  @override
  List<String> get filters;
  @override
  List<String> get availableFilters;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $RecordsStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> filters, List<String> availableFilters});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$RecordsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = null,
    Object? availableFilters = null,
  }) {
    return _then(_$LoadingImpl(
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(
      {final List<String> filters = const [],
      final List<String> availableFilters = const []})
      : _filters = filters,
        _availableFilters = availableFilters;

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
  String toString() {
    return 'RecordsState.loading(filters: $filters, availableFilters: $availableFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_availableFilters));

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        initial,
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        loading,
    required TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)
        loaded,
    required TResult Function(
            String message, List<String> filters, List<String> availableFilters)
        error,
  }) {
    return loading(filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult? Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult? Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult? Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
  }) {
    return loading?.call(filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(filters, availableFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements RecordsState {
  const factory _Loading(
      {final List<String> filters,
      final List<String> availableFilters}) = _$LoadingImpl;

  @override
  List<String> get filters;
  @override
  List<String> get availableFilters;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res>
    implements $RecordsStateCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FhirResource> entries,
      List<String> filters,
      List<String> availableFilters});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$RecordsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? filters = null,
    Object? availableFilters = null,
  }) {
    return _then(_$LoadedImpl(
      null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<FhirResource>,
      null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<FhirResource> entries,
      final List<String> filters, final List<String> availableFilters)
      : _entries = entries,
        _filters = filters,
        _availableFilters = availableFilters;

  final List<FhirResource> _entries;
  @override
  List<FhirResource> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  final List<String> _filters;
  @override
  List<String> get filters {
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filters);
  }

  final List<String> _availableFilters;
  @override
  List<String> get availableFilters {
    if (_availableFilters is EqualUnmodifiableListView)
      return _availableFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableFilters);
  }

  @override
  String toString() {
    return 'RecordsState.loaded(entries: $entries, filters: $filters, availableFilters: $availableFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_availableFilters));

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        initial,
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        loading,
    required TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)
        loaded,
    required TResult Function(
            String message, List<String> filters, List<String> availableFilters)
        error,
  }) {
    return loaded(entries, filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult? Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult? Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult? Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
  }) {
    return loaded?.call(entries, filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entries, filters, availableFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements RecordsState {
  const factory _Loaded(
      final List<FhirResource> entries,
      final List<String> filters,
      final List<String> availableFilters) = _$LoadedImpl;

  List<FhirResource> get entries;
  @override
  List<String> get filters;
  @override
  List<String> get availableFilters;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $RecordsStateCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, List<String> filters, List<String> availableFilters});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$RecordsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? filters = null,
    Object? availableFilters = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      availableFilters: null == availableFilters
          ? _value._availableFilters
          : availableFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message,
      {final List<String> filters = const [],
      final List<String> availableFilters = const []})
      : _filters = filters,
        _availableFilters = availableFilters;

  @override
  final String message;
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
  String toString() {
    return 'RecordsState.error(message: $message, filters: $filters, availableFilters: $availableFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._availableFilters, _availableFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_availableFilters));

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        initial,
    required TResult Function(
            List<String> filters, List<String> availableFilters)
        loading,
    required TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)
        loaded,
    required TResult Function(
            String message, List<String> filters, List<String> availableFilters)
        error,
  }) {
    return error(message, filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult? Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult? Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult? Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
  }) {
    return error?.call(message, filters, availableFilters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> filters, List<String> availableFilters)?
        initial,
    TResult Function(List<String> filters, List<String> availableFilters)?
        loading,
    TResult Function(List<FhirResource> entries, List<String> filters,
            List<String> availableFilters)?
        loaded,
    TResult Function(String message, List<String> filters,
            List<String> availableFilters)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, filters, availableFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements RecordsState {
  const factory _Error(final String message,
      {final List<String> filters,
      final List<String> availableFilters}) = _$ErrorImpl;

  String get message;
  @override
  List<String> get filters;
  @override
  List<String> get availableFilters;

  /// Create a copy of RecordsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
