// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllergyDto _$AllergyDtoFromJson(Map<String, dynamic> json) {
  return _AllergyDto.fromJson(json);
}

/// @nodoc
mixin _$AllergyDto {
  String get dateRecorded => throw _privateConstructorUsedError;
  String get allergyType => throw _privateConstructorUsedError;
  String get allergicTo => throw _privateConstructorUsedError;
  String? get reaction => throw _privateConstructorUsedError;
  String get onset => throw _privateConstructorUsedError;
  String? get resolutionAge => throw _privateConstructorUsedError;

  /// Serializes this AllergyDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllergyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyDtoCopyWith<AllergyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyDtoCopyWith<$Res> {
  factory $AllergyDtoCopyWith(
          AllergyDto value, $Res Function(AllergyDto) then) =
      _$AllergyDtoCopyWithImpl<$Res, AllergyDto>;
  @useResult
  $Res call(
      {String dateRecorded,
      String allergyType,
      String allergicTo,
      String? reaction,
      String onset,
      String? resolutionAge});
}

/// @nodoc
class _$AllergyDtoCopyWithImpl<$Res, $Val extends AllergyDto>
    implements $AllergyDtoCopyWith<$Res> {
  _$AllergyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRecorded = null,
    Object? allergyType = null,
    Object? allergicTo = null,
    Object? reaction = freezed,
    Object? onset = null,
    Object? resolutionAge = freezed,
  }) {
    return _then(_value.copyWith(
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      allergyType: null == allergyType
          ? _value.allergyType
          : allergyType // ignore: cast_nullable_to_non_nullable
              as String,
      allergicTo: null == allergicTo
          ? _value.allergicTo
          : allergicTo // ignore: cast_nullable_to_non_nullable
              as String,
      reaction: freezed == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String?,
      onset: null == onset
          ? _value.onset
          : onset // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionAge: freezed == resolutionAge
          ? _value.resolutionAge
          : resolutionAge // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergyDtoImplCopyWith<$Res>
    implements $AllergyDtoCopyWith<$Res> {
  factory _$$AllergyDtoImplCopyWith(
          _$AllergyDtoImpl value, $Res Function(_$AllergyDtoImpl) then) =
      __$$AllergyDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String dateRecorded,
      String allergyType,
      String allergicTo,
      String? reaction,
      String onset,
      String? resolutionAge});
}

/// @nodoc
class __$$AllergyDtoImplCopyWithImpl<$Res>
    extends _$AllergyDtoCopyWithImpl<$Res, _$AllergyDtoImpl>
    implements _$$AllergyDtoImplCopyWith<$Res> {
  __$$AllergyDtoImplCopyWithImpl(
      _$AllergyDtoImpl _value, $Res Function(_$AllergyDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllergyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRecorded = null,
    Object? allergyType = null,
    Object? allergicTo = null,
    Object? reaction = freezed,
    Object? onset = null,
    Object? resolutionAge = freezed,
  }) {
    return _then(_$AllergyDtoImpl(
      dateRecorded: null == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String,
      allergyType: null == allergyType
          ? _value.allergyType
          : allergyType // ignore: cast_nullable_to_non_nullable
              as String,
      allergicTo: null == allergicTo
          ? _value.allergicTo
          : allergicTo // ignore: cast_nullable_to_non_nullable
              as String,
      reaction: freezed == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String?,
      onset: null == onset
          ? _value.onset
          : onset // ignore: cast_nullable_to_non_nullable
              as String,
      resolutionAge: freezed == resolutionAge
          ? _value.resolutionAge
          : resolutionAge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllergyDtoImpl implements _AllergyDto {
  const _$AllergyDtoImpl(
      {required this.dateRecorded,
      required this.allergyType,
      required this.allergicTo,
      this.reaction,
      required this.onset,
      this.resolutionAge});

  factory _$AllergyDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergyDtoImplFromJson(json);

  @override
  final String dateRecorded;
  @override
  final String allergyType;
  @override
  final String allergicTo;
  @override
  final String? reaction;
  @override
  final String onset;
  @override
  final String? resolutionAge;

  @override
  String toString() {
    return 'AllergyDto(dateRecorded: $dateRecorded, allergyType: $allergyType, allergicTo: $allergicTo, reaction: $reaction, onset: $onset, resolutionAge: $resolutionAge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyDtoImpl &&
            (identical(other.dateRecorded, dateRecorded) ||
                other.dateRecorded == dateRecorded) &&
            (identical(other.allergyType, allergyType) ||
                other.allergyType == allergyType) &&
            (identical(other.allergicTo, allergicTo) ||
                other.allergicTo == allergicTo) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.onset, onset) || other.onset == onset) &&
            (identical(other.resolutionAge, resolutionAge) ||
                other.resolutionAge == resolutionAge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dateRecorded, allergyType,
      allergicTo, reaction, onset, resolutionAge);

  /// Create a copy of AllergyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyDtoImplCopyWith<_$AllergyDtoImpl> get copyWith =>
      __$$AllergyDtoImplCopyWithImpl<_$AllergyDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergyDtoImplToJson(
      this,
    );
  }
}

abstract class _AllergyDto implements AllergyDto {
  const factory _AllergyDto(
      {required final String dateRecorded,
      required final String allergyType,
      required final String allergicTo,
      final String? reaction,
      required final String onset,
      final String? resolutionAge}) = _$AllergyDtoImpl;

  factory _AllergyDto.fromJson(Map<String, dynamic> json) =
      _$AllergyDtoImpl.fromJson;

  @override
  String get dateRecorded;
  @override
  String get allergyType;
  @override
  String get allergicTo;
  @override
  String? get reaction;
  @override
  String get onset;
  @override
  String? get resolutionAge;

  /// Create a copy of AllergyDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyDtoImplCopyWith<_$AllergyDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
