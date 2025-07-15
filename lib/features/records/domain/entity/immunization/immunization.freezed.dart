// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'immunization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Immunization _$ImmunizationFromJson(Map<String, dynamic> json) {
  return _Immunization.fromJson(json);
}

/// @nodoc
mixin _$Immunization {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String? get lotNumber => throw _privateConstructorUsedError;

  /// Serializes this Immunization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImmunizationCopyWith<Immunization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImmunizationCopyWith<$Res> {
  factory $ImmunizationCopyWith(
          Immunization value, $Res Function(Immunization) then) =
      _$ImmunizationCopyWithImpl<$Res, Immunization>;
  @useResult
  $Res call({String name, String date, String? lotNumber});
}

/// @nodoc
class _$ImmunizationCopyWithImpl<$Res, $Val extends Immunization>
    implements $ImmunizationCopyWith<$Res> {
  _$ImmunizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? lotNumber = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      lotNumber: freezed == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImmunizationImplCopyWith<$Res>
    implements $ImmunizationCopyWith<$Res> {
  factory _$$ImmunizationImplCopyWith(
          _$ImmunizationImpl value, $Res Function(_$ImmunizationImpl) then) =
      __$$ImmunizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String date, String? lotNumber});
}

/// @nodoc
class __$$ImmunizationImplCopyWithImpl<$Res>
    extends _$ImmunizationCopyWithImpl<$Res, _$ImmunizationImpl>
    implements _$$ImmunizationImplCopyWith<$Res> {
  __$$ImmunizationImplCopyWithImpl(
      _$ImmunizationImpl _value, $Res Function(_$ImmunizationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? lotNumber = freezed,
  }) {
    return _then(_$ImmunizationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      lotNumber: freezed == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImmunizationImpl implements _Immunization {
  const _$ImmunizationImpl(
      {required this.name, required this.date, this.lotNumber});

  factory _$ImmunizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImmunizationImplFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final String? lotNumber;

  @override
  String toString() {
    return 'Immunization(name: $name, date: $date, lotNumber: $lotNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImmunizationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.lotNumber, lotNumber) ||
                other.lotNumber == lotNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, date, lotNumber);

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImmunizationImplCopyWith<_$ImmunizationImpl> get copyWith =>
      __$$ImmunizationImplCopyWithImpl<_$ImmunizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImmunizationImplToJson(
      this,
    );
  }
}

abstract class _Immunization implements Immunization {
  const factory _Immunization(
      {required final String name,
      required final String date,
      final String? lotNumber}) = _$ImmunizationImpl;

  factory _Immunization.fromJson(Map<String, dynamic> json) =
      _$ImmunizationImpl.fromJson;

  @override
  String get name;
  @override
  String get date;
  @override
  String? get lotNumber;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImmunizationImplCopyWith<_$ImmunizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
