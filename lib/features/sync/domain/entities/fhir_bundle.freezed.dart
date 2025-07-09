// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fhir_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FhirBundle _$FhirBundleFromJson(Map<String, dynamic> json) {
  return _FhirBundle.fromJson(json);
}

/// @nodoc
mixin _$FhirBundle {
  String get resourceType => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  List<BundleEntry> get entry => throw _privateConstructorUsedError;

  /// Serializes this FhirBundle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FhirBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FhirBundleCopyWith<FhirBundle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FhirBundleCopyWith<$Res> {
  factory $FhirBundleCopyWith(
          FhirBundle value, $Res Function(FhirBundle) then) =
      _$FhirBundleCopyWithImpl<$Res, FhirBundle>;
  @useResult
  $Res call(
      {String resourceType, String type, int total, List<BundleEntry> entry});
}

/// @nodoc
class _$FhirBundleCopyWithImpl<$Res, $Val extends FhirBundle>
    implements $FhirBundleCopyWith<$Res> {
  _$FhirBundleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FhirBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resourceType = null,
    Object? type = null,
    Object? total = null,
    Object? entry = null,
  }) {
    return _then(_value.copyWith(
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as List<BundleEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FhirBundleImplCopyWith<$Res>
    implements $FhirBundleCopyWith<$Res> {
  factory _$$FhirBundleImplCopyWith(
          _$FhirBundleImpl value, $Res Function(_$FhirBundleImpl) then) =
      __$$FhirBundleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String resourceType, String type, int total, List<BundleEntry> entry});
}

/// @nodoc
class __$$FhirBundleImplCopyWithImpl<$Res>
    extends _$FhirBundleCopyWithImpl<$Res, _$FhirBundleImpl>
    implements _$$FhirBundleImplCopyWith<$Res> {
  __$$FhirBundleImplCopyWithImpl(
      _$FhirBundleImpl _value, $Res Function(_$FhirBundleImpl) _then)
      : super(_value, _then);

  /// Create a copy of FhirBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resourceType = null,
    Object? type = null,
    Object? total = null,
    Object? entry = null,
  }) {
    return _then(_$FhirBundleImpl(
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      entry: null == entry
          ? _value._entry
          : entry // ignore: cast_nullable_to_non_nullable
              as List<BundleEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FhirBundleImpl implements _FhirBundle {
  const _$FhirBundleImpl(
      {required this.resourceType,
      required this.type,
      required this.total,
      required final List<BundleEntry> entry})
      : _entry = entry;

  factory _$FhirBundleImpl.fromJson(Map<String, dynamic> json) =>
      _$$FhirBundleImplFromJson(json);

  @override
  final String resourceType;
  @override
  final String type;
  @override
  final int total;
  final List<BundleEntry> _entry;
  @override
  List<BundleEntry> get entry {
    if (_entry is EqualUnmodifiableListView) return _entry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entry);
  }

  @override
  String toString() {
    return 'FhirBundle(resourceType: $resourceType, type: $type, total: $total, entry: $entry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FhirBundleImpl &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._entry, _entry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resourceType, type, total,
      const DeepCollectionEquality().hash(_entry));

  /// Create a copy of FhirBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FhirBundleImplCopyWith<_$FhirBundleImpl> get copyWith =>
      __$$FhirBundleImplCopyWithImpl<_$FhirBundleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FhirBundleImplToJson(
      this,
    );
  }
}

abstract class _FhirBundle implements FhirBundle {
  const factory _FhirBundle(
      {required final String resourceType,
      required final String type,
      required final int total,
      required final List<BundleEntry> entry}) = _$FhirBundleImpl;

  factory _FhirBundle.fromJson(Map<String, dynamic> json) =
      _$FhirBundleImpl.fromJson;

  @override
  String get resourceType;
  @override
  String get type;
  @override
  int get total;
  @override
  List<BundleEntry> get entry;

  /// Create a copy of FhirBundle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FhirBundleImplCopyWith<_$FhirBundleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BundleEntry _$BundleEntryFromJson(Map<String, dynamic> json) {
  return _BundleEntry.fromJson(json);
}

/// @nodoc
mixin _$BundleEntry {
  FhirResource get resource => throw _privateConstructorUsedError;

  /// Serializes this BundleEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BundleEntryCopyWith<BundleEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BundleEntryCopyWith<$Res> {
  factory $BundleEntryCopyWith(
          BundleEntry value, $Res Function(BundleEntry) then) =
      _$BundleEntryCopyWithImpl<$Res, BundleEntry>;
  @useResult
  $Res call({FhirResource resource});

  $FhirResourceCopyWith<$Res> get resource;
}

/// @nodoc
class _$BundleEntryCopyWithImpl<$Res, $Val extends BundleEntry>
    implements $BundleEntryCopyWith<$Res> {
  _$BundleEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = null,
  }) {
    return _then(_value.copyWith(
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as FhirResource,
    ) as $Val);
  }

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FhirResourceCopyWith<$Res> get resource {
    return $FhirResourceCopyWith<$Res>(_value.resource, (value) {
      return _then(_value.copyWith(resource: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BundleEntryImplCopyWith<$Res>
    implements $BundleEntryCopyWith<$Res> {
  factory _$$BundleEntryImplCopyWith(
          _$BundleEntryImpl value, $Res Function(_$BundleEntryImpl) then) =
      __$$BundleEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FhirResource resource});

  @override
  $FhirResourceCopyWith<$Res> get resource;
}

/// @nodoc
class __$$BundleEntryImplCopyWithImpl<$Res>
    extends _$BundleEntryCopyWithImpl<$Res, _$BundleEntryImpl>
    implements _$$BundleEntryImplCopyWith<$Res> {
  __$$BundleEntryImplCopyWithImpl(
      _$BundleEntryImpl _value, $Res Function(_$BundleEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = null,
  }) {
    return _then(_$BundleEntryImpl(
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as FhirResource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BundleEntryImpl implements _BundleEntry {
  const _$BundleEntryImpl({required this.resource});

  factory _$BundleEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BundleEntryImplFromJson(json);

  @override
  final FhirResource resource;

  @override
  String toString() {
    return 'BundleEntry(resource: $resource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BundleEntryImpl &&
            (identical(other.resource, resource) ||
                other.resource == resource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resource);

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BundleEntryImplCopyWith<_$BundleEntryImpl> get copyWith =>
      __$$BundleEntryImplCopyWithImpl<_$BundleEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BundleEntryImplToJson(
      this,
    );
  }
}

abstract class _BundleEntry implements BundleEntry {
  const factory _BundleEntry({required final FhirResource resource}) =
      _$BundleEntryImpl;

  factory _BundleEntry.fromJson(Map<String, dynamic> json) =
      _$BundleEntryImpl.fromJson;

  @override
  FhirResource get resource;

  /// Create a copy of BundleEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BundleEntryImplCopyWith<_$BundleEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
