// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practitioner_role.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PractitionerRole _$PractitionerRoleFromJson(Map<String, dynamic> json) {
  return _PractitionerRole.fromJson(json);
}

/// @nodoc
mixin _$PractitionerRole {
  String? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  List<CodeableConcept>? get codes => throw _privateConstructorUsedError;
  List<CodeableConcept>? get specialties => throw _privateConstructorUsedError;
  Reference? get organization => throw _privateConstructorUsedError;
  Reference? get practitioner => throw _privateConstructorUsedError;

  /// Serializes this PractitionerRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PractitionerRoleCopyWith<PractitionerRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PractitionerRoleCopyWith<$Res> {
  factory $PractitionerRoleCopyWith(
          PractitionerRole value, $Res Function(PractitionerRole) then) =
      _$PractitionerRoleCopyWithImpl<$Res, PractitionerRole>;
  @useResult
  $Res call(
      {String? id,
      String? status,
      List<CodeableConcept>? codes,
      List<CodeableConcept>? specialties,
      Reference? organization,
      Reference? practitioner});

  $ReferenceCopyWith<$Res>? get organization;
  $ReferenceCopyWith<$Res>? get practitioner;
}

/// @nodoc
class _$PractitionerRoleCopyWithImpl<$Res, $Val extends PractitionerRole>
    implements $PractitionerRoleCopyWith<$Res> {
  _$PractitionerRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? codes = freezed,
    Object? specialties = freezed,
    Object? organization = freezed,
    Object? practitioner = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      codes: freezed == codes
          ? _value.codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      specialties: freezed == specialties
          ? _value.specialties
          : specialties // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Reference?,
      practitioner: freezed == practitioner
          ? _value.practitioner
          : practitioner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get organization {
    if (_value.organization == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.organization!, (value) {
      return _then(_value.copyWith(organization: value) as $Val);
    });
  }

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get practitioner {
    if (_value.practitioner == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.practitioner!, (value) {
      return _then(_value.copyWith(practitioner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PractitionerRoleImplCopyWith<$Res>
    implements $PractitionerRoleCopyWith<$Res> {
  factory _$$PractitionerRoleImplCopyWith(_$PractitionerRoleImpl value,
          $Res Function(_$PractitionerRoleImpl) then) =
      __$$PractitionerRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? status,
      List<CodeableConcept>? codes,
      List<CodeableConcept>? specialties,
      Reference? organization,
      Reference? practitioner});

  @override
  $ReferenceCopyWith<$Res>? get organization;
  @override
  $ReferenceCopyWith<$Res>? get practitioner;
}

/// @nodoc
class __$$PractitionerRoleImplCopyWithImpl<$Res>
    extends _$PractitionerRoleCopyWithImpl<$Res, _$PractitionerRoleImpl>
    implements _$$PractitionerRoleImplCopyWith<$Res> {
  __$$PractitionerRoleImplCopyWithImpl(_$PractitionerRoleImpl _value,
      $Res Function(_$PractitionerRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? codes = freezed,
    Object? specialties = freezed,
    Object? organization = freezed,
    Object? practitioner = freezed,
  }) {
    return _then(_$PractitionerRoleImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      codes: freezed == codes
          ? _value._codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      specialties: freezed == specialties
          ? _value._specialties
          : specialties // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Reference?,
      practitioner: freezed == practitioner
          ? _value.practitioner
          : practitioner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PractitionerRoleImpl implements _PractitionerRole {
  _$PractitionerRoleImpl(
      {this.id,
      this.status,
      final List<CodeableConcept>? codes,
      final List<CodeableConcept>? specialties,
      this.organization,
      this.practitioner})
      : _codes = codes,
        _specialties = specialties;

  factory _$PractitionerRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PractitionerRoleImplFromJson(json);

  @override
  final String? id;
  @override
  final String? status;
  final List<CodeableConcept>? _codes;
  @override
  List<CodeableConcept>? get codes {
    final value = _codes;
    if (value == null) return null;
    if (_codes is EqualUnmodifiableListView) return _codes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _specialties;
  @override
  List<CodeableConcept>? get specialties {
    final value = _specialties;
    if (value == null) return null;
    if (_specialties is EqualUnmodifiableListView) return _specialties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Reference? organization;
  @override
  final Reference? practitioner;

  @override
  String toString() {
    return 'PractitionerRole(id: $id, status: $status, codes: $codes, specialties: $specialties, organization: $organization, practitioner: $practitioner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PractitionerRoleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._codes, _codes) &&
            const DeepCollectionEquality()
                .equals(other._specialties, _specialties) &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.practitioner, practitioner) ||
                other.practitioner == practitioner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      const DeepCollectionEquality().hash(_codes),
      const DeepCollectionEquality().hash(_specialties),
      organization,
      practitioner);

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PractitionerRoleImplCopyWith<_$PractitionerRoleImpl> get copyWith =>
      __$$PractitionerRoleImplCopyWithImpl<_$PractitionerRoleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PractitionerRoleImplToJson(
      this,
    );
  }
}

abstract class _PractitionerRole implements PractitionerRole {
  factory _PractitionerRole(
      {final String? id,
      final String? status,
      final List<CodeableConcept>? codes,
      final List<CodeableConcept>? specialties,
      final Reference? organization,
      final Reference? practitioner}) = _$PractitionerRoleImpl;

  factory _PractitionerRole.fromJson(Map<String, dynamic> json) =
      _$PractitionerRoleImpl.fromJson;

  @override
  String? get id;
  @override
  String? get status;
  @override
  List<CodeableConcept>? get codes;
  @override
  List<CodeableConcept>? get specialties;
  @override
  Reference? get organization;
  @override
  Reference? get practitioner;

  /// Create a copy of PractitionerRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PractitionerRoleImplCopyWith<_$PractitionerRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
