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
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get resourceType => throw _privateConstructorUsedError;
  @HiveField(2)
  Map<String, dynamic> get resource => throw _privateConstructorUsedError;

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
      {@HiveField(0) String id,
      @HiveField(1) String resourceType,
      @HiveField(2) Map<String, dynamic> resource});
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
    Object? id = null,
    Object? resourceType = null,
    Object? resource = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      {@HiveField(0) String id,
      @HiveField(1) String resourceType,
      @HiveField(2) Map<String, dynamic> resource});
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
    Object? id = null,
    Object? resourceType = null,
    Object? resource = null,
  }) {
    return _then(_$FhirResourceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      resource: null == resource
          ? _value._resource
          : resource // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FhirResourceImpl implements _FhirResource {
  const _$FhirResourceImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.resourceType,
      @HiveField(2) required final Map<String, dynamic> resource})
      : _resource = resource;

  factory _$FhirResourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$FhirResourceImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String resourceType;
  final Map<String, dynamic> _resource;
  @override
  @HiveField(2)
  Map<String, dynamic> get resource {
    if (_resource is EqualUnmodifiableMapView) return _resource;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_resource);
  }

  @override
  String toString() {
    return 'FhirResource(id: $id, resourceType: $resourceType, resource: $resource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FhirResourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType) &&
            const DeepCollectionEquality().equals(other._resource, _resource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, resourceType,
      const DeepCollectionEquality().hash(_resource));

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
  const factory _FhirResource(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String resourceType,
          @HiveField(2) required final Map<String, dynamic> resource}) =
      _$FhirResourceImpl;

  factory _FhirResource.fromJson(Map<String, dynamic> json) =
      _$FhirResourceImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get resourceType;
  @override
  @HiveField(2)
  Map<String, dynamic> get resource;

  /// Create a copy of FhirResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FhirResourceImplCopyWith<_$FhirResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
