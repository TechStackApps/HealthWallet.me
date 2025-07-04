// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Allergy _$AllergyFromJson(Map<String, dynamic> json) {
  return _Allergy.fromJson(json);
}

/// @nodoc
mixin _$Allergy {
  String get dateRecorded => throw _privateConstructorUsedError;
  String get allergyType => throw _privateConstructorUsedError;
  String get allergicTo => throw _privateConstructorUsedError;
  String? get reaction => throw _privateConstructorUsedError;
  String get onset => throw _privateConstructorUsedError;
  String? get resolutionAge => throw _privateConstructorUsedError;

  /// Serializes this Allergy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Allergy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyCopyWith<Allergy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyCopyWith<$Res> {
  factory $AllergyCopyWith(Allergy value, $Res Function(Allergy) then) =
      _$AllergyCopyWithImpl<$Res, Allergy>;
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
class _$AllergyCopyWithImpl<$Res, $Val extends Allergy>
    implements $AllergyCopyWith<$Res> {
  _$AllergyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Allergy
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
abstract class _$$AllergyImplCopyWith<$Res> implements $AllergyCopyWith<$Res> {
  factory _$$AllergyImplCopyWith(
          _$AllergyImpl value, $Res Function(_$AllergyImpl) then) =
      __$$AllergyImplCopyWithImpl<$Res>;
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
class __$$AllergyImplCopyWithImpl<$Res>
    extends _$AllergyCopyWithImpl<$Res, _$AllergyImpl>
    implements _$$AllergyImplCopyWith<$Res> {
  __$$AllergyImplCopyWithImpl(
      _$AllergyImpl _value, $Res Function(_$AllergyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Allergy
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
    return _then(_$AllergyImpl(
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
class _$AllergyImpl implements _Allergy {
  const _$AllergyImpl(
      {required this.dateRecorded,
      required this.allergyType,
      required this.allergicTo,
      this.reaction,
      required this.onset,
      this.resolutionAge});

  factory _$AllergyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergyImplFromJson(json);

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
    return 'Allergy(dateRecorded: $dateRecorded, allergyType: $allergyType, allergicTo: $allergicTo, reaction: $reaction, onset: $onset, resolutionAge: $resolutionAge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyImpl &&
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

  /// Create a copy of Allergy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyImplCopyWith<_$AllergyImpl> get copyWith =>
      __$$AllergyImplCopyWithImpl<_$AllergyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergyImplToJson(
      this,
    );
  }
}

abstract class _Allergy implements Allergy {
  const factory _Allergy(
      {required final String dateRecorded,
      required final String allergyType,
      required final String allergicTo,
      final String? reaction,
      required final String onset,
      final String? resolutionAge}) = _$AllergyImpl;

  factory _Allergy.fromJson(Map<String, dynamic> json) = _$AllergyImpl.fromJson;

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

  /// Create a copy of Allergy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyImplCopyWith<_$AllergyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
