// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'related_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RelatedPerson _$RelatedPersonFromJson(Map<String, dynamic> json) {
  return _RelatedPerson.fromJson(json);
}

/// @nodoc
mixin _$RelatedPerson {
  String? get id => throw _privateConstructorUsedError;
  String? get patient => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get birthdate => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'related_person_telecom')
  List<Telecom>? get relatedPersonTelecom => throw _privateConstructorUsedError;

  /// Serializes this RelatedPerson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RelatedPersonCopyWith<RelatedPerson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelatedPersonCopyWith<$Res> {
  factory $RelatedPersonCopyWith(
          RelatedPerson value, $Res Function(RelatedPerson) then) =
      _$RelatedPersonCopyWithImpl<$Res, RelatedPerson>;
  @useResult
  $Res call(
      {String? id,
      String? patient,
      String? name,
      String? birthdate,
      String? gender,
      Address? address,
      @JsonKey(name: 'related_person_telecom')
      List<Telecom>? relatedPersonTelecom});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$RelatedPersonCopyWithImpl<$Res, $Val extends RelatedPerson>
    implements $RelatedPersonCopyWith<$Res> {
  _$RelatedPersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? patient = freezed,
    Object? name = freezed,
    Object? birthdate = freezed,
    Object? gender = freezed,
    Object? address = freezed,
    Object? relatedPersonTelecom = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      relatedPersonTelecom: freezed == relatedPersonTelecom
          ? _value.relatedPersonTelecom
          : relatedPersonTelecom // ignore: cast_nullable_to_non_nullable
              as List<Telecom>?,
    ) as $Val);
  }

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RelatedPersonImplCopyWith<$Res>
    implements $RelatedPersonCopyWith<$Res> {
  factory _$$RelatedPersonImplCopyWith(
          _$RelatedPersonImpl value, $Res Function(_$RelatedPersonImpl) then) =
      __$$RelatedPersonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? patient,
      String? name,
      String? birthdate,
      String? gender,
      Address? address,
      @JsonKey(name: 'related_person_telecom')
      List<Telecom>? relatedPersonTelecom});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$RelatedPersonImplCopyWithImpl<$Res>
    extends _$RelatedPersonCopyWithImpl<$Res, _$RelatedPersonImpl>
    implements _$$RelatedPersonImplCopyWith<$Res> {
  __$$RelatedPersonImplCopyWithImpl(
      _$RelatedPersonImpl _value, $Res Function(_$RelatedPersonImpl) _then)
      : super(_value, _then);

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? patient = freezed,
    Object? name = freezed,
    Object? birthdate = freezed,
    Object? gender = freezed,
    Object? address = freezed,
    Object? relatedPersonTelecom = freezed,
  }) {
    return _then(_$RelatedPersonImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      relatedPersonTelecom: freezed == relatedPersonTelecom
          ? _value._relatedPersonTelecom
          : relatedPersonTelecom // ignore: cast_nullable_to_non_nullable
              as List<Telecom>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelatedPersonImpl implements _RelatedPerson {
  _$RelatedPersonImpl(
      {this.id,
      this.patient,
      this.name,
      this.birthdate,
      this.gender,
      this.address,
      @JsonKey(name: 'related_person_telecom')
      final List<Telecom>? relatedPersonTelecom})
      : _relatedPersonTelecom = relatedPersonTelecom;

  factory _$RelatedPersonImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelatedPersonImplFromJson(json);

  @override
  final String? id;
  @override
  final String? patient;
  @override
  final String? name;
  @override
  final String? birthdate;
  @override
  final String? gender;
  @override
  final Address? address;
  final List<Telecom>? _relatedPersonTelecom;
  @override
  @JsonKey(name: 'related_person_telecom')
  List<Telecom>? get relatedPersonTelecom {
    final value = _relatedPersonTelecom;
    if (value == null) return null;
    if (_relatedPersonTelecom is EqualUnmodifiableListView)
      return _relatedPersonTelecom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RelatedPerson(id: $id, patient: $patient, name: $name, birthdate: $birthdate, gender: $gender, address: $address, relatedPersonTelecom: $relatedPersonTelecom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelatedPersonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._relatedPersonTelecom, _relatedPersonTelecom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      patient,
      name,
      birthdate,
      gender,
      address,
      const DeepCollectionEquality().hash(_relatedPersonTelecom));

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RelatedPersonImplCopyWith<_$RelatedPersonImpl> get copyWith =>
      __$$RelatedPersonImplCopyWithImpl<_$RelatedPersonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelatedPersonImplToJson(
      this,
    );
  }
}

abstract class _RelatedPerson implements RelatedPerson {
  factory _RelatedPerson(
      {final String? id,
      final String? patient,
      final String? name,
      final String? birthdate,
      final String? gender,
      final Address? address,
      @JsonKey(name: 'related_person_telecom')
      final List<Telecom>? relatedPersonTelecom}) = _$RelatedPersonImpl;

  factory _RelatedPerson.fromJson(Map<String, dynamic> json) =
      _$RelatedPersonImpl.fromJson;

  @override
  String? get id;
  @override
  String? get patient;
  @override
  String? get name;
  @override
  String? get birthdate;
  @override
  String? get gender;
  @override
  Address? get address;
  @override
  @JsonKey(name: 'related_person_telecom')
  List<Telecom>? get relatedPersonTelecom;

  /// Create a copy of RelatedPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RelatedPersonImplCopyWith<_$RelatedPersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
