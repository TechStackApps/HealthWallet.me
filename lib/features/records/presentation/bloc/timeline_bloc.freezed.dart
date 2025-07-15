// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(Set<String> newFilters) filterChanged,
    required TResult Function(String? sourceId) sourceChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(Set<String> newFilters)? filterChanged,
    TResult? Function(String? sourceId)? sourceChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(Set<String> newFilters)? filterChanged,
    TResult Function(String? sourceId)? sourceChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_SourceChanged value) sourceChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_SourceChanged value)? sourceChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_SourceChanged value)? sourceChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineEvent
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
    extends _$TimelineEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'TimelineEvent.load()';
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
    required TResult Function() loadMore,
    required TResult Function(Set<String> newFilters) filterChanged,
    required TResult Function(String? sourceId) sourceChanged,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(Set<String> newFilters)? filterChanged,
    TResult? Function(String? sourceId)? sourceChanged,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(Set<String> newFilters)? filterChanged,
    TResult Function(String? sourceId)? sourceChanged,
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
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_SourceChanged value) sourceChanged,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_SourceChanged value)? sourceChanged,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_SourceChanged value)? sourceChanged,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements TimelineEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
          _$LoadMoreImpl value, $Res Function(_$LoadMoreImpl) then) =
      __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
      _$LoadMoreImpl _value, $Res Function(_$LoadMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'TimelineEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(Set<String> newFilters) filterChanged,
    required TResult Function(String? sourceId) sourceChanged,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(Set<String> newFilters)? filterChanged,
    TResult? Function(String? sourceId)? sourceChanged,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(Set<String> newFilters)? filterChanged,
    TResult Function(String? sourceId)? sourceChanged,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_SourceChanged value) sourceChanged,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_SourceChanged value)? sourceChanged,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_SourceChanged value)? sourceChanged,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements TimelineEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$FilterChangedImplCopyWith<$Res> {
  factory _$$FilterChangedImplCopyWith(
          _$FilterChangedImpl value, $Res Function(_$FilterChangedImpl) then) =
      __$$FilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Set<String> newFilters});
}

/// @nodoc
class __$$FilterChangedImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$FilterChangedImpl>
    implements _$$FilterChangedImplCopyWith<$Res> {
  __$$FilterChangedImplCopyWithImpl(
      _$FilterChangedImpl _value, $Res Function(_$FilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newFilters = null,
  }) {
    return _then(_$FilterChangedImpl(
      null == newFilters
          ? _value._newFilters
          : newFilters // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$FilterChangedImpl implements _FilterChanged {
  const _$FilterChangedImpl(final Set<String> newFilters)
      : _newFilters = newFilters;

  final Set<String> _newFilters;
  @override
  Set<String> get newFilters {
    if (_newFilters is EqualUnmodifiableSetView) return _newFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_newFilters);
  }

  @override
  String toString() {
    return 'TimelineEvent.filterChanged(newFilters: $newFilters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterChangedImpl &&
            const DeepCollectionEquality()
                .equals(other._newFilters, _newFilters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_newFilters));

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      __$$FilterChangedImplCopyWithImpl<_$FilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(Set<String> newFilters) filterChanged,
    required TResult Function(String? sourceId) sourceChanged,
  }) {
    return filterChanged(newFilters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(Set<String> newFilters)? filterChanged,
    TResult? Function(String? sourceId)? sourceChanged,
  }) {
    return filterChanged?.call(newFilters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(Set<String> newFilters)? filterChanged,
    TResult Function(String? sourceId)? sourceChanged,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(newFilters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_SourceChanged value) sourceChanged,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_SourceChanged value)? sourceChanged,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_SourceChanged value)? sourceChanged,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }
}

abstract class _FilterChanged implements TimelineEvent {
  const factory _FilterChanged(final Set<String> newFilters) =
      _$FilterChangedImpl;

  Set<String> get newFilters;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SourceChangedImplCopyWith<$Res> {
  factory _$$SourceChangedImplCopyWith(
          _$SourceChangedImpl value, $Res Function(_$SourceChangedImpl) then) =
      __$$SourceChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? sourceId});
}

/// @nodoc
class __$$SourceChangedImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$SourceChangedImpl>
    implements _$$SourceChangedImplCopyWith<$Res> {
  __$$SourceChangedImplCopyWithImpl(
      _$SourceChangedImpl _value, $Res Function(_$SourceChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceId = freezed,
  }) {
    return _then(_$SourceChangedImpl(
      freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SourceChangedImpl implements _SourceChanged {
  const _$SourceChangedImpl(this.sourceId);

  @override
  final String? sourceId;

  @override
  String toString() {
    return 'TimelineEvent.sourceChanged(sourceId: $sourceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceChangedImpl &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourceId);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceChangedImplCopyWith<_$SourceChangedImpl> get copyWith =>
      __$$SourceChangedImplCopyWithImpl<_$SourceChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(Set<String> newFilters) filterChanged,
    required TResult Function(String? sourceId) sourceChanged,
  }) {
    return sourceChanged(sourceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(Set<String> newFilters)? filterChanged,
    TResult? Function(String? sourceId)? sourceChanged,
  }) {
    return sourceChanged?.call(sourceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(Set<String> newFilters)? filterChanged,
    TResult Function(String? sourceId)? sourceChanged,
    required TResult orElse(),
  }) {
    if (sourceChanged != null) {
      return sourceChanged(sourceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_FilterChanged value) filterChanged,
    required TResult Function(_SourceChanged value) sourceChanged,
  }) {
    return sourceChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_FilterChanged value)? filterChanged,
    TResult? Function(_SourceChanged value)? sourceChanged,
  }) {
    return sourceChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_FilterChanged value)? filterChanged,
    TResult Function(_SourceChanged value)? sourceChanged,
    required TResult orElse(),
  }) {
    if (sourceChanged != null) {
      return sourceChanged(this);
    }
    return orElse();
  }
}

abstract class _SourceChanged implements TimelineEvent {
  const factory _SourceChanged(final String? sourceId) = _$SourceChangedImpl;

  String? get sourceId;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceChangedImplCopyWith<_$SourceChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TimelineState {
  TimelineStatus get status => throw _privateConstructorUsedError;
  List<TimelineResourceModel> get resources =>
      throw _privateConstructorUsedError;
  bool get hasMorePages => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  Set<String> get filters => throw _privateConstructorUsedError;
  String? get sourceId => throw _privateConstructorUsedError;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineStateCopyWith<TimelineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStateCopyWith<$Res> {
  factory $TimelineStateCopyWith(
          TimelineState value, $Res Function(TimelineState) then) =
      _$TimelineStateCopyWithImpl<$Res, TimelineState>;
  @useResult
  $Res call(
      {TimelineStatus status,
      List<TimelineResourceModel> resources,
      bool hasMorePages,
      int page,
      String error,
      Set<String> filters,
      String? sourceId});
}

/// @nodoc
class _$TimelineStateCopyWithImpl<$Res, $Val extends TimelineState>
    implements $TimelineStateCopyWith<$Res> {
  _$TimelineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resources = null,
    Object? hasMorePages = null,
    Object? page = null,
    Object? error = null,
    Object? filters = null,
    Object? sourceId = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimelineStatus,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<TimelineResourceModel>,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      sourceId: freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineStateImplCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$TimelineStateImplCopyWith(
          _$TimelineStateImpl value, $Res Function(_$TimelineStateImpl) then) =
      __$$TimelineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TimelineStatus status,
      List<TimelineResourceModel> resources,
      bool hasMorePages,
      int page,
      String error,
      Set<String> filters,
      String? sourceId});
}

/// @nodoc
class __$$TimelineStateImplCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$TimelineStateImpl>
    implements _$$TimelineStateImplCopyWith<$Res> {
  __$$TimelineStateImplCopyWithImpl(
      _$TimelineStateImpl _value, $Res Function(_$TimelineStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resources = null,
    Object? hasMorePages = null,
    Object? page = null,
    Object? error = null,
    Object? filters = null,
    Object? sourceId = freezed,
  }) {
    return _then(_$TimelineStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimelineStatus,
      resources: null == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<TimelineResourceModel>,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      sourceId: freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TimelineStateImpl implements _TimelineState {
  const _$TimelineStateImpl(
      {this.status = TimelineStatus.initial,
      final List<TimelineResourceModel> resources = const [],
      this.hasMorePages = true,
      this.page = 0,
      this.error = '',
      final Set<String> filters = const {},
      this.sourceId})
      : _resources = resources,
        _filters = filters;

  @override
  @JsonKey()
  final TimelineStatus status;
  final List<TimelineResourceModel> _resources;
  @override
  @JsonKey()
  List<TimelineResourceModel> get resources {
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resources);
  }

  @override
  @JsonKey()
  final bool hasMorePages;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final String error;
  final Set<String> _filters;
  @override
  @JsonKey()
  Set<String> get filters {
    if (_filters is EqualUnmodifiableSetView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_filters);
  }

  @override
  final String? sourceId;

  @override
  String toString() {
    return 'TimelineState(status: $status, resources: $resources, hasMorePages: $hasMorePages, page: $page, error: $error, filters: $filters, sourceId: $sourceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            (identical(other.hasMorePages, hasMorePages) ||
                other.hasMorePages == hasMorePages) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_resources),
      hasMorePages,
      page,
      error,
      const DeepCollectionEquality().hash(_filters),
      sourceId);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      __$$TimelineStateImplCopyWithImpl<_$TimelineStateImpl>(this, _$identity);
}

abstract class _TimelineState implements TimelineState {
  const factory _TimelineState(
      {final TimelineStatus status,
      final List<TimelineResourceModel> resources,
      final bool hasMorePages,
      final int page,
      final String error,
      final Set<String> filters,
      final String? sourceId}) = _$TimelineStateImpl;

  @override
  TimelineStatus get status;
  @override
  List<TimelineResourceModel> get resources;
  @override
  bool get hasMorePages;
  @override
  int get page;
  @override
  String get error;
  @override
  Set<String> get filters;
  @override
  String? get sourceId;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
