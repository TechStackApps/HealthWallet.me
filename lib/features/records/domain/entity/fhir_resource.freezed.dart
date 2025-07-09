// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fhir_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FhirResource _$FhirResourceFromJson(Map<String, dynamic> json) {
  return _FhirResource.fromJson(json);
}

/// @nodoc
mixin _$FhirResource {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_resource_type')
  String get resourceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'resource_raw')
  Map<String, dynamic> get resourceJson => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_id')
  String? get sourceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FhirResource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FhirResourceCopyWith<FhirResource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FhirResourceCopyWith<$Res> {
  factory $FhirResourceCopyWith(
          FhirResource value, $Res Function(FhirResource) then) =
      _$FhirResourceCopyWithImpl<$Res, FhirResource>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'source_resource_type') String resourceType,
      @JsonKey(name: 'resource_raw') Map<String, dynamic> resourceJson,
      @JsonKey(name: 'source_id') String? sourceId,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$FhirResourceCopyWithImpl<$Res, $Val extends FhirResource>
    implements $FhirResourceCopyWith<$Res> {
  _$FhirResourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resourceType = null,
    Object? resourceJson = null,
    Object? sourceId = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      resourceJson: null == resourceJson
          ? _value.resourceJson
          : resourceJson // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceId: freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FhirResourceImplCopyWith<$Res>
    implements $FhirResourceCopyWith<$Res> {
  factory _$$FhirResourceImplCopyWith(
          _$FhirResourceImpl value, $Res Function(_$FhirResourceImpl) then) =
      __$$FhirResourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'source_resource_type') String resourceType,
      @JsonKey(name: 'resource_raw') Map<String, dynamic> resourceJson,
      @JsonKey(name: 'source_id') String? sourceId,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$FhirResourceImplCopyWithImpl<$Res>
    extends _$FhirResourceCopyWithImpl<$Res, _$FhirResourceImpl>
    implements _$$FhirResourceImplCopyWith<$Res> {
  __$$FhirResourceImplCopyWithImpl(
      _$FhirResourceImpl _value, $Res Function(_$FhirResourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resourceType = null,
    Object? resourceJson = null,
    Object? sourceId = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_$FhirResourceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      resourceJson: null == resourceJson
          ? _value._resourceJson
          : resourceJson // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sourceId: freezed == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FhirResourceImpl implements _FhirResource {
  _$FhirResourceImpl(
      {this.id,
      @JsonKey(name: 'source_resource_type') required this.resourceType,
      @JsonKey(name: 'resource_raw')
      required final Map<String, dynamic> resourceJson,
      @JsonKey(name: 'source_id') this.sourceId,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : _resourceJson = resourceJson;

  factory _$FhirResourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$FhirResourceImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'source_resource_type')
  final String resourceType;
  final Map<String, dynamic> _resourceJson;
  @override
  @JsonKey(name: 'resource_raw')
  Map<String, dynamic> get resourceJson {
    if (_resourceJson is EqualUnmodifiableMapView) return _resourceJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_resourceJson);
  }

  @override
  @JsonKey(name: 'source_id')
  final String? sourceId;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'FhirResource(id: $id, resourceType: $resourceType, resourceJson: $resourceJson, sourceId: $sourceId, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FhirResourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType) &&
            const DeepCollectionEquality()
                .equals(other._resourceJson, _resourceJson) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, resourceType,
      const DeepCollectionEquality().hash(_resourceJson), sourceId, updatedAt);

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FhirResourceImplCopyWith<_$FhirResourceImpl> get copyWith =>
      __$$FhirResourceImplCopyWithImpl<_$FhirResourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FhirResourceImplToJson(
      this,
    );
  }
}

abstract class _FhirResource implements FhirResource {
  factory _FhirResource(
      {final String? id,
      @JsonKey(name: 'source_resource_type') required final String resourceType,
      @JsonKey(name: 'resource_raw')
      required final Map<String, dynamic> resourceJson,
      @JsonKey(name: 'source_id') final String? sourceId,
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt}) = _$FhirResourceImpl;

  factory _FhirResource.fromJson(Map<String, dynamic> json) =
      _$FhirResourceImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'source_resource_type')
  String get resourceType;
  @override
  @JsonKey(name: 'resource_raw')
  Map<String, dynamic> get resourceJson;
  @override
  @JsonKey(name: 'source_id')
  String? get sourceId;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FhirResourceImplCopyWith<_$FhirResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
