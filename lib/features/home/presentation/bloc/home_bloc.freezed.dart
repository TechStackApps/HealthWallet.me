// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeInitialised {}

/// @nodoc
abstract class $HomeInitialisedCopyWith<$Res> {
  factory $HomeInitialisedCopyWith(
          HomeInitialised value, $Res Function(HomeInitialised) then) =
      _$HomeInitialisedCopyWithImpl<$Res, HomeInitialised>;
}

/// @nodoc
class _$HomeInitialisedCopyWithImpl<$Res, $Val extends HomeInitialised>
    implements $HomeInitialisedCopyWith<$Res> {
  _$HomeInitialisedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeInitialised
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HomeInitialisedImplCopyWith<$Res> {
  factory _$$HomeInitialisedImplCopyWith(_$HomeInitialisedImpl value,
          $Res Function(_$HomeInitialisedImpl) then) =
      __$$HomeInitialisedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HomeInitialisedImplCopyWithImpl<$Res>
    extends _$HomeInitialisedCopyWithImpl<$Res, _$HomeInitialisedImpl>
    implements _$$HomeInitialisedImplCopyWith<$Res> {
  __$$HomeInitialisedImplCopyWithImpl(
      _$HomeInitialisedImpl _value, $Res Function(_$HomeInitialisedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeInitialised
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HomeInitialisedImpl implements _HomeInitialised {
  const _$HomeInitialisedImpl();

  @override
  String toString() {
    return 'HomeInitialised()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HomeInitialisedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _HomeInitialised implements HomeInitialised {
  const factory _HomeInitialised() = _$HomeInitialisedImpl;
}

/// @nodoc
mixin _$HomeSourceChanged {
  String get source => throw _privateConstructorUsedError;

  /// Create a copy of HomeSourceChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSourceChangedCopyWith<HomeSourceChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSourceChangedCopyWith<$Res> {
  factory $HomeSourceChangedCopyWith(
          HomeSourceChanged value, $Res Function(HomeSourceChanged) then) =
      _$HomeSourceChangedCopyWithImpl<$Res, HomeSourceChanged>;
  @useResult
  $Res call({String source});
}

/// @nodoc
class _$HomeSourceChangedCopyWithImpl<$Res, $Val extends HomeSourceChanged>
    implements $HomeSourceChangedCopyWith<$Res> {
  _$HomeSourceChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSourceChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeSourceChangedImplCopyWith<$Res>
    implements $HomeSourceChangedCopyWith<$Res> {
  factory _$$HomeSourceChangedImplCopyWith(_$HomeSourceChangedImpl value,
          $Res Function(_$HomeSourceChangedImpl) then) =
      __$$HomeSourceChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String source});
}

/// @nodoc
class __$$HomeSourceChangedImplCopyWithImpl<$Res>
    extends _$HomeSourceChangedCopyWithImpl<$Res, _$HomeSourceChangedImpl>
    implements _$$HomeSourceChangedImplCopyWith<$Res> {
  __$$HomeSourceChangedImplCopyWithImpl(_$HomeSourceChangedImpl _value,
      $Res Function(_$HomeSourceChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeSourceChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
  }) {
    return _then(_$HomeSourceChangedImpl(
      null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeSourceChangedImpl implements _HomeSourceChanged {
  const _$HomeSourceChangedImpl(this.source);

  @override
  final String source;

  @override
  String toString() {
    return 'HomeSourceChanged(source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSourceChangedImpl &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source);

  /// Create a copy of HomeSourceChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSourceChangedImplCopyWith<_$HomeSourceChangedImpl> get copyWith =>
      __$$HomeSourceChangedImplCopyWithImpl<_$HomeSourceChangedImpl>(
          this, _$identity);
}

abstract class _HomeSourceChanged implements HomeSourceChanged {
  const factory _HomeSourceChanged(final String source) =
      _$HomeSourceChangedImpl;

  @override
  String get source;

  /// Create a copy of HomeSourceChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSourceChangedImplCopyWith<_$HomeSourceChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeFiltersChanged {
  Map<String, bool> get filters => throw _privateConstructorUsedError;

  /// Create a copy of HomeFiltersChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeFiltersChangedCopyWith<HomeFiltersChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeFiltersChangedCopyWith<$Res> {
  factory $HomeFiltersChangedCopyWith(
          HomeFiltersChanged value, $Res Function(HomeFiltersChanged) then) =
      _$HomeFiltersChangedCopyWithImpl<$Res, HomeFiltersChanged>;
  @useResult
  $Res call({Map<String, bool> filters});
}

/// @nodoc
class _$HomeFiltersChangedCopyWithImpl<$Res, $Val extends HomeFiltersChanged>
    implements $HomeFiltersChangedCopyWith<$Res> {
  _$HomeFiltersChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeFiltersChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = null,
  }) {
    return _then(_value.copyWith(
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeFiltersChangedImplCopyWith<$Res>
    implements $HomeFiltersChangedCopyWith<$Res> {
  factory _$$HomeFiltersChangedImplCopyWith(_$HomeFiltersChangedImpl value,
          $Res Function(_$HomeFiltersChangedImpl) then) =
      __$$HomeFiltersChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, bool> filters});
}

/// @nodoc
class __$$HomeFiltersChangedImplCopyWithImpl<$Res>
    extends _$HomeFiltersChangedCopyWithImpl<$Res, _$HomeFiltersChangedImpl>
    implements _$$HomeFiltersChangedImplCopyWith<$Res> {
  __$$HomeFiltersChangedImplCopyWithImpl(_$HomeFiltersChangedImpl _value,
      $Res Function(_$HomeFiltersChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeFiltersChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filters = null,
  }) {
    return _then(_$HomeFiltersChangedImpl(
      null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc

class _$HomeFiltersChangedImpl implements _HomeFiltersChanged {
  const _$HomeFiltersChangedImpl(final Map<String, bool> filters)
      : _filters = filters;

  final Map<String, bool> _filters;
  @override
  Map<String, bool> get filters {
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filters);
  }

  @override
  String toString() {
    return 'HomeFiltersChanged(filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeFiltersChangedImpl &&
            const DeepCollectionEquality().equals(other._filters, _filters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_filters));

  /// Create a copy of HomeFiltersChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeFiltersChangedImplCopyWith<_$HomeFiltersChangedImpl> get copyWith =>
      __$$HomeFiltersChangedImplCopyWithImpl<_$HomeFiltersChangedImpl>(
          this, _$identity);
}

abstract class _HomeFiltersChanged implements HomeFiltersChanged {
  const factory _HomeFiltersChanged(final Map<String, bool> filters) =
      _$HomeFiltersChangedImpl;

  @override
  Map<String, bool> get filters;

  /// Create a copy of HomeFiltersChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeFiltersChangedImplCopyWith<_$HomeFiltersChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeEditModeChanged {
  bool get editMode => throw _privateConstructorUsedError;

  /// Create a copy of HomeEditModeChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeEditModeChangedCopyWith<HomeEditModeChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEditModeChangedCopyWith<$Res> {
  factory $HomeEditModeChangedCopyWith(
          HomeEditModeChanged value, $Res Function(HomeEditModeChanged) then) =
      _$HomeEditModeChangedCopyWithImpl<$Res, HomeEditModeChanged>;
  @useResult
  $Res call({bool editMode});
}

/// @nodoc
class _$HomeEditModeChangedCopyWithImpl<$Res, $Val extends HomeEditModeChanged>
    implements $HomeEditModeChangedCopyWith<$Res> {
  _$HomeEditModeChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEditModeChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editMode = null,
  }) {
    return _then(_value.copyWith(
      editMode: null == editMode
          ? _value.editMode
          : editMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeEditModeChangedImplCopyWith<$Res>
    implements $HomeEditModeChangedCopyWith<$Res> {
  factory _$$HomeEditModeChangedImplCopyWith(_$HomeEditModeChangedImpl value,
          $Res Function(_$HomeEditModeChangedImpl) then) =
      __$$HomeEditModeChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool editMode});
}

/// @nodoc
class __$$HomeEditModeChangedImplCopyWithImpl<$Res>
    extends _$HomeEditModeChangedCopyWithImpl<$Res, _$HomeEditModeChangedImpl>
    implements _$$HomeEditModeChangedImplCopyWith<$Res> {
  __$$HomeEditModeChangedImplCopyWithImpl(_$HomeEditModeChangedImpl _value,
      $Res Function(_$HomeEditModeChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEditModeChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? editMode = null,
  }) {
    return _then(_$HomeEditModeChangedImpl(
      null == editMode
          ? _value.editMode
          : editMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeEditModeChangedImpl implements _HomeEditModeChanged {
  const _$HomeEditModeChangedImpl(this.editMode);

  @override
  final bool editMode;

  @override
  String toString() {
    return 'HomeEditModeChanged(editMode: $editMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeEditModeChangedImpl &&
            (identical(other.editMode, editMode) ||
                other.editMode == editMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, editMode);

  /// Create a copy of HomeEditModeChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeEditModeChangedImplCopyWith<_$HomeEditModeChangedImpl> get copyWith =>
      __$$HomeEditModeChangedImplCopyWithImpl<_$HomeEditModeChangedImpl>(
          this, _$identity);
}

abstract class _HomeEditModeChanged implements HomeEditModeChanged {
  const factory _HomeEditModeChanged(final bool editMode) =
      _$HomeEditModeChangedImpl;

  @override
  bool get editMode;

  /// Create a copy of HomeEditModeChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeEditModeChangedImplCopyWith<_$HomeEditModeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeRecordsReordered {
  int get oldIndex => throw _privateConstructorUsedError;
  int get newIndex => throw _privateConstructorUsedError;

  /// Create a copy of HomeRecordsReordered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeRecordsReorderedCopyWith<HomeRecordsReordered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeRecordsReorderedCopyWith<$Res> {
  factory $HomeRecordsReorderedCopyWith(HomeRecordsReordered value,
          $Res Function(HomeRecordsReordered) then) =
      _$HomeRecordsReorderedCopyWithImpl<$Res, HomeRecordsReordered>;
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class _$HomeRecordsReorderedCopyWithImpl<$Res,
        $Val extends HomeRecordsReordered>
    implements $HomeRecordsReorderedCopyWith<$Res> {
  _$HomeRecordsReorderedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeRecordsReordered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_value.copyWith(
      oldIndex: null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeRecordsReorderedImplCopyWith<$Res>
    implements $HomeRecordsReorderedCopyWith<$Res> {
  factory _$$HomeRecordsReorderedImplCopyWith(_$HomeRecordsReorderedImpl value,
          $Res Function(_$HomeRecordsReorderedImpl) then) =
      __$$HomeRecordsReorderedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class __$$HomeRecordsReorderedImplCopyWithImpl<$Res>
    extends _$HomeRecordsReorderedCopyWithImpl<$Res, _$HomeRecordsReorderedImpl>
    implements _$$HomeRecordsReorderedImplCopyWith<$Res> {
  __$$HomeRecordsReorderedImplCopyWithImpl(_$HomeRecordsReorderedImpl _value,
      $Res Function(_$HomeRecordsReorderedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeRecordsReordered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$HomeRecordsReorderedImpl(
      null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomeRecordsReorderedImpl implements _HomeRecordsReordered {
  const _$HomeRecordsReorderedImpl(this.oldIndex, this.newIndex);

  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'HomeRecordsReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeRecordsReorderedImpl &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldIndex, newIndex);

  /// Create a copy of HomeRecordsReordered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeRecordsReorderedImplCopyWith<_$HomeRecordsReorderedImpl>
      get copyWith =>
          __$$HomeRecordsReorderedImplCopyWithImpl<_$HomeRecordsReorderedImpl>(
              this, _$identity);
}

abstract class _HomeRecordsReordered implements HomeRecordsReordered {
  const factory _HomeRecordsReordered(final int oldIndex, final int newIndex) =
      _$HomeRecordsReorderedImpl;

  @override
  int get oldIndex;
  @override
  int get newIndex;

  /// Create a copy of HomeRecordsReordered
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeRecordsReorderedImplCopyWith<_$HomeRecordsReorderedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeVitalsReordered {
  int get oldIndex => throw _privateConstructorUsedError;
  int get newIndex => throw _privateConstructorUsedError;

  /// Create a copy of HomeVitalsReordered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeVitalsReorderedCopyWith<HomeVitalsReordered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeVitalsReorderedCopyWith<$Res> {
  factory $HomeVitalsReorderedCopyWith(
          HomeVitalsReordered value, $Res Function(HomeVitalsReordered) then) =
      _$HomeVitalsReorderedCopyWithImpl<$Res, HomeVitalsReordered>;
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class _$HomeVitalsReorderedCopyWithImpl<$Res, $Val extends HomeVitalsReordered>
    implements $HomeVitalsReorderedCopyWith<$Res> {
  _$HomeVitalsReorderedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeVitalsReordered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_value.copyWith(
      oldIndex: null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      newIndex: null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeVitalsReorderedImplCopyWith<$Res>
    implements $HomeVitalsReorderedCopyWith<$Res> {
  factory _$$HomeVitalsReorderedImplCopyWith(_$HomeVitalsReorderedImpl value,
          $Res Function(_$HomeVitalsReorderedImpl) then) =
      __$$HomeVitalsReorderedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class __$$HomeVitalsReorderedImplCopyWithImpl<$Res>
    extends _$HomeVitalsReorderedCopyWithImpl<$Res, _$HomeVitalsReorderedImpl>
    implements _$$HomeVitalsReorderedImplCopyWith<$Res> {
  __$$HomeVitalsReorderedImplCopyWithImpl(_$HomeVitalsReorderedImpl _value,
      $Res Function(_$HomeVitalsReorderedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeVitalsReordered
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$HomeVitalsReorderedImpl(
      null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomeVitalsReorderedImpl implements _HomeVitalsReordered {
  const _$HomeVitalsReorderedImpl(this.oldIndex, this.newIndex);

  @override
  final int oldIndex;
  @override
  final int newIndex;

  @override
  String toString() {
    return 'HomeVitalsReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeVitalsReorderedImpl &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldIndex, newIndex);

  /// Create a copy of HomeVitalsReordered
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeVitalsReorderedImplCopyWith<_$HomeVitalsReorderedImpl> get copyWith =>
      __$$HomeVitalsReorderedImplCopyWithImpl<_$HomeVitalsReorderedImpl>(
          this, _$identity);
}

abstract class _HomeVitalsReordered implements HomeVitalsReordered {
  const factory _HomeVitalsReordered(final int oldIndex, final int newIndex) =
      _$HomeVitalsReorderedImpl;

  @override
  int get oldIndex;
  @override
  int get newIndex;

  /// Create a copy of HomeVitalsReordered
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeVitalsReorderedImplCopyWith<_$HomeVitalsReorderedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeState {
  HomeStatus get status => throw _privateConstructorUsedError;
  List<VitalSign> get vitalSigns => throw _privateConstructorUsedError;
  List<OverviewCard> get overviewCards => throw _privateConstructorUsedError;
  List<FhirResource> get recentRecords => throw _privateConstructorUsedError;
  List<Source> get sources => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;
  String get selectedSource => throw _privateConstructorUsedError;
  Map<String, bool> get selectedResources => throw _privateConstructorUsedError;
  FhirResource? get patient => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get editMode => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {HomeStatus status,
      List<VitalSign> vitalSigns,
      List<OverviewCard> overviewCards,
      List<FhirResource> recentRecords,
      List<Source> sources,
      int selectedIndex,
      String selectedSource,
      Map<String, bool> selectedResources,
      FhirResource? patient,
      String? errorMessage,
      bool editMode});

  $HomeStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? vitalSigns = null,
    Object? overviewCards = null,
    Object? recentRecords = null,
    Object? sources = null,
    Object? selectedIndex = null,
    Object? selectedSource = null,
    Object? selectedResources = null,
    Object? patient = freezed,
    Object? errorMessage = freezed,
    Object? editMode = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeStatus,
      vitalSigns: null == vitalSigns
          ? _value.vitalSigns
          : vitalSigns // ignore: cast_nullable_to_non_nullable
              as List<VitalSign>,
      overviewCards: null == overviewCards
          ? _value.overviewCards
          : overviewCards // ignore: cast_nullable_to_non_nullable
              as List<OverviewCard>,
      recentRecords: null == recentRecords
          ? _value.recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as List<FhirResource>,
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<Source>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedSource: null == selectedSource
          ? _value.selectedSource
          : selectedSource // ignore: cast_nullable_to_non_nullable
              as String,
      selectedResources: null == selectedResources
          ? _value.selectedResources
          : selectedResources // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as FhirResource?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      editMode: null == editMode
          ? _value.editMode
          : editMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeStatusCopyWith<$Res> get status {
    return $HomeStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HomeStatus status,
      List<VitalSign> vitalSigns,
      List<OverviewCard> overviewCards,
      List<FhirResource> recentRecords,
      List<Source> sources,
      int selectedIndex,
      String selectedSource,
      Map<String, bool> selectedResources,
      FhirResource? patient,
      String? errorMessage,
      bool editMode});

  @override
  $HomeStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? vitalSigns = null,
    Object? overviewCards = null,
    Object? recentRecords = null,
    Object? sources = null,
    Object? selectedIndex = null,
    Object? selectedSource = null,
    Object? selectedResources = null,
    Object? patient = freezed,
    Object? errorMessage = freezed,
    Object? editMode = null,
  }) {
    return _then(_$HomeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeStatus,
      vitalSigns: null == vitalSigns
          ? _value._vitalSigns
          : vitalSigns // ignore: cast_nullable_to_non_nullable
              as List<VitalSign>,
      overviewCards: null == overviewCards
          ? _value._overviewCards
          : overviewCards // ignore: cast_nullable_to_non_nullable
              as List<OverviewCard>,
      recentRecords: null == recentRecords
          ? _value._recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as List<FhirResource>,
      sources: null == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<Source>,
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedSource: null == selectedSource
          ? _value.selectedSource
          : selectedSource // ignore: cast_nullable_to_non_nullable
              as String,
      selectedResources: null == selectedResources
          ? _value._selectedResources
          : selectedResources // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as FhirResource?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      editMode: null == editMode
          ? _value.editMode
          : editMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.status = const HomeStatus.initial(),
      final List<VitalSign> vitalSigns = const [],
      final List<OverviewCard> overviewCards = const [],
      final List<FhirResource> recentRecords = const [],
      final List<Source> sources = const [],
      this.selectedIndex = 0,
      this.selectedSource = 'All',
      final Map<String, bool> selectedResources = const {
        ClinicalDataTags.allergy: true,
        ClinicalDataTags.medication: true,
        ClinicalDataTags.condition: true,
        ClinicalDataTags.immunization: true,
        ClinicalDataTags.labResult: true,
        ClinicalDataTags.procedure: true,
        ClinicalDataTags.goal: true,
        ClinicalDataTags.careTeam: true,
        ClinicalDataTags.clinicalNotes: true,
        ClinicalDataTags.files: true,
        ClinicalDataTags.facilities: true,
        ClinicalDataTags.demographics: true
      },
      this.patient,
      this.errorMessage,
      this.editMode = false})
      : _vitalSigns = vitalSigns,
        _overviewCards = overviewCards,
        _recentRecords = recentRecords,
        _sources = sources,
        _selectedResources = selectedResources;

  @override
  @JsonKey()
  final HomeStatus status;
  final List<VitalSign> _vitalSigns;
  @override
  @JsonKey()
  List<VitalSign> get vitalSigns {
    if (_vitalSigns is EqualUnmodifiableListView) return _vitalSigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vitalSigns);
  }

  final List<OverviewCard> _overviewCards;
  @override
  @JsonKey()
  List<OverviewCard> get overviewCards {
    if (_overviewCards is EqualUnmodifiableListView) return _overviewCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overviewCards);
  }

  final List<FhirResource> _recentRecords;
  @override
  @JsonKey()
  List<FhirResource> get recentRecords {
    if (_recentRecords is EqualUnmodifiableListView) return _recentRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentRecords);
  }

  final List<Source> _sources;
  @override
  @JsonKey()
  List<Source> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  @JsonKey()
  final String selectedSource;
  final Map<String, bool> _selectedResources;
  @override
  @JsonKey()
  Map<String, bool> get selectedResources {
    if (_selectedResources is EqualUnmodifiableMapView)
      return _selectedResources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedResources);
  }

  @override
  final FhirResource? patient;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool editMode;

  @override
  String toString() {
    return 'HomeState(status: $status, vitalSigns: $vitalSigns, overviewCards: $overviewCards, recentRecords: $recentRecords, sources: $sources, selectedIndex: $selectedIndex, selectedSource: $selectedSource, selectedResources: $selectedResources, patient: $patient, errorMessage: $errorMessage, editMode: $editMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._vitalSigns, _vitalSigns) &&
            const DeepCollectionEquality()
                .equals(other._overviewCards, _overviewCards) &&
            const DeepCollectionEquality()
                .equals(other._recentRecords, _recentRecords) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.selectedSource, selectedSource) ||
                other.selectedSource == selectedSource) &&
            const DeepCollectionEquality()
                .equals(other._selectedResources, _selectedResources) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.editMode, editMode) ||
                other.editMode == editMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_vitalSigns),
      const DeepCollectionEquality().hash(_overviewCards),
      const DeepCollectionEquality().hash(_recentRecords),
      const DeepCollectionEquality().hash(_sources),
      selectedIndex,
      selectedSource,
      const DeepCollectionEquality().hash(_selectedResources),
      patient,
      errorMessage,
      editMode);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final HomeStatus status,
      final List<VitalSign> vitalSigns,
      final List<OverviewCard> overviewCards,
      final List<FhirResource> recentRecords,
      final List<Source> sources,
      final int selectedIndex,
      final String selectedSource,
      final Map<String, bool> selectedResources,
      final FhirResource? patient,
      final String? errorMessage,
      final bool editMode}) = _$HomeStateImpl;

  @override
  HomeStatus get status;
  @override
  List<VitalSign> get vitalSigns;
  @override
  List<OverviewCard> get overviewCards;
  @override
  List<FhirResource> get recentRecords;
  @override
  List<Source> get sources;
  @override
  int get selectedIndex;
  @override
  String get selectedSource;
  @override
  Map<String, bool> get selectedResources;
  @override
  FhirResource? get patient;
  @override
  String? get errorMessage;
  @override
  bool get editMode;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStatusCopyWith<$Res> {
  factory $HomeStatusCopyWith(
          HomeStatus value, $Res Function(HomeStatus) then) =
      _$HomeStatusCopyWithImpl<$Res, HomeStatus>;
}

/// @nodoc
class _$HomeStatusCopyWithImpl<$Res, $Val extends HomeStatus>
    implements $HomeStatusCopyWith<$Res> {
  _$HomeStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$HomeStatusCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'HomeStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HomeStatus {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$HomeStatusCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'HomeStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements HomeStatus {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$HomeStatusCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'HomeStatus.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements HomeStatus {
  const factory _Success() = _$SuccessImpl;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$HomeStatusCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FailureImpl(
      null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.error);

  @override
  final Object error;

  @override
  String toString() {
    return 'HomeStatus.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements HomeStatus {
  const factory _Failure(final Object error) = _$FailureImpl;

  Object get error;

  /// Create a copy of HomeStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
