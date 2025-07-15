// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicationDto _$MedicationDtoFromJson(Map<String, dynamic> json) {
  return _MedicationDto.fromJson(json);
}

/// @nodoc
mixin _$MedicationDto {
  String get name => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this MedicationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationDtoCopyWith<MedicationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationDtoCopyWith<$Res> {
  factory $MedicationDtoCopyWith(
          MedicationDto value, $Res Function(MedicationDto) then) =
      _$MedicationDtoCopyWithImpl<$Res, MedicationDto>;
  @useResult
  $Res call({String name, String dosage, String frequency, String? reason});
}

/// @nodoc
class _$MedicationDtoCopyWithImpl<$Res, $Val extends MedicationDto>
    implements $MedicationDtoCopyWith<$Res> {
  _$MedicationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dosage = null,
    Object? frequency = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationDtoImplCopyWith<$Res>
    implements $MedicationDtoCopyWith<$Res> {
  factory _$$MedicationDtoImplCopyWith(
          _$MedicationDtoImpl value, $Res Function(_$MedicationDtoImpl) then) =
      __$$MedicationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String dosage, String frequency, String? reason});
}

/// @nodoc
class __$$MedicationDtoImplCopyWithImpl<$Res>
    extends _$MedicationDtoCopyWithImpl<$Res, _$MedicationDtoImpl>
    implements _$$MedicationDtoImplCopyWith<$Res> {
  __$$MedicationDtoImplCopyWithImpl(
      _$MedicationDtoImpl _value, $Res Function(_$MedicationDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? dosage = null,
    Object? frequency = null,
    Object? reason = freezed,
  }) {
    return _then(_$MedicationDtoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationDtoImpl implements _MedicationDto {
  const _$MedicationDtoImpl(
      {required this.name,
      required this.dosage,
      required this.frequency,
      this.reason});

  factory _$MedicationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationDtoImplFromJson(json);

  @override
  final String name;
  @override
  final String dosage;
  @override
  final String frequency;
  @override
  final String? reason;

  @override
  String toString() {
    return 'MedicationDto(name: $name, dosage: $dosage, frequency: $frequency, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, dosage, frequency, reason);

  /// Create a copy of MedicationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationDtoImplCopyWith<_$MedicationDtoImpl> get copyWith =>
      __$$MedicationDtoImplCopyWithImpl<_$MedicationDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationDtoImplToJson(
      this,
    );
  }
}

abstract class _MedicationDto implements MedicationDto {
  const factory _MedicationDto(
      {required final String name,
      required final String dosage,
      required final String frequency,
      final String? reason}) = _$MedicationDtoImpl;

  factory _MedicationDto.fromJson(Map<String, dynamic> json) =
      _$MedicationDtoImpl.fromJson;

  @override
  String get name;
  @override
  String get dosage;
  @override
  String get frequency;
  @override
  String? get reason;

  /// Create a copy of MedicationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationDtoImplCopyWith<_$MedicationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
