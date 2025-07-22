// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_dispense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicationDispense _$MedicationDispenseFromJson(Map<String, dynamic> json) {
  return _MedicationDispense.fromJson(json);
}

/// @nodoc
mixin _$MedicationDispense {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_title')
  String? get medicationTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_coding')
  Coding? get medicationCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_dosage_instruction')
  bool? get hasDosageInstruction => throw _privateConstructorUsedError;
  @JsonKey(name: 'dosage_instruction')
  List<DosageInstruction>? get dosageInstruction =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'dosage_instruction_data')
  List<DosageInstructionData>? get dosageInstructionData =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'when_prepared')
  String? get whenPrepared => throw _privateConstructorUsedError;

  /// Serializes this MedicationDispense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationDispenseCopyWith<MedicationDispense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationDispenseCopyWith<$Res> {
  factory $MedicationDispenseCopyWith(
          MedicationDispense value, $Res Function(MedicationDispense) then) =
      _$MedicationDispenseCopyWithImpl<$Res, MedicationDispense>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'medication_title') String? medicationTitle,
      @JsonKey(name: 'medication_coding') Coding? medicationCoding,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      @JsonKey(name: 'has_dosage_instruction') bool? hasDosageInstruction,
      @JsonKey(name: 'dosage_instruction')
      List<DosageInstruction>? dosageInstruction,
      @JsonKey(name: 'dosage_instruction_data')
      List<DosageInstructionData>? dosageInstructionData,
      @JsonKey(name: 'when_prepared') String? whenPrepared});

  $CodeableConceptCopyWith<$Res>? get code;
  $CodingCopyWith<$Res>? get medicationCoding;
  $CodingCopyWith<$Res>? get typeCoding;
}

/// @nodoc
class _$MedicationDispenseCopyWithImpl<$Res, $Val extends MedicationDispense>
    implements $MedicationDispenseCopyWith<$Res> {
  _$MedicationDispenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? medicationTitle = freezed,
    Object? medicationCoding = freezed,
    Object? typeCoding = freezed,
    Object? hasDosageInstruction = freezed,
    Object? dosageInstruction = freezed,
    Object? dosageInstructionData = freezed,
    Object? whenPrepared = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      medicationTitle: freezed == medicationTitle
          ? _value.medicationTitle
          : medicationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      medicationCoding: freezed == medicationCoding
          ? _value.medicationCoding
          : medicationCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      hasDosageInstruction: freezed == hasDosageInstruction
          ? _value.hasDosageInstruction
          : hasDosageInstruction // ignore: cast_nullable_to_non_nullable
              as bool?,
      dosageInstruction: freezed == dosageInstruction
          ? _value.dosageInstruction
          : dosageInstruction // ignore: cast_nullable_to_non_nullable
              as List<DosageInstruction>?,
      dosageInstructionData: freezed == dosageInstructionData
          ? _value.dosageInstructionData
          : dosageInstructionData // ignore: cast_nullable_to_non_nullable
              as List<DosageInstructionData>?,
      whenPrepared: freezed == whenPrepared
          ? _value.whenPrepared
          : whenPrepared // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get code {
    if (_value.code == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.code!, (value) {
      return _then(_value.copyWith(code: value) as $Val);
    });
  }

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get medicationCoding {
    if (_value.medicationCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.medicationCoding!, (value) {
      return _then(_value.copyWith(medicationCoding: value) as $Val);
    });
  }

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get typeCoding {
    if (_value.typeCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.typeCoding!, (value) {
      return _then(_value.copyWith(typeCoding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MedicationDispenseImplCopyWith<$Res>
    implements $MedicationDispenseCopyWith<$Res> {
  factory _$$MedicationDispenseImplCopyWith(_$MedicationDispenseImpl value,
          $Res Function(_$MedicationDispenseImpl) then) =
      __$$MedicationDispenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'medication_title') String? medicationTitle,
      @JsonKey(name: 'medication_coding') Coding? medicationCoding,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      @JsonKey(name: 'has_dosage_instruction') bool? hasDosageInstruction,
      @JsonKey(name: 'dosage_instruction')
      List<DosageInstruction>? dosageInstruction,
      @JsonKey(name: 'dosage_instruction_data')
      List<DosageInstructionData>? dosageInstructionData,
      @JsonKey(name: 'when_prepared') String? whenPrepared});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $CodingCopyWith<$Res>? get medicationCoding;
  @override
  $CodingCopyWith<$Res>? get typeCoding;
}

/// @nodoc
class __$$MedicationDispenseImplCopyWithImpl<$Res>
    extends _$MedicationDispenseCopyWithImpl<$Res, _$MedicationDispenseImpl>
    implements _$$MedicationDispenseImplCopyWith<$Res> {
  __$$MedicationDispenseImplCopyWithImpl(_$MedicationDispenseImpl _value,
      $Res Function(_$MedicationDispenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? medicationTitle = freezed,
    Object? medicationCoding = freezed,
    Object? typeCoding = freezed,
    Object? hasDosageInstruction = freezed,
    Object? dosageInstruction = freezed,
    Object? dosageInstructionData = freezed,
    Object? whenPrepared = freezed,
  }) {
    return _then(_$MedicationDispenseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      medicationTitle: freezed == medicationTitle
          ? _value.medicationTitle
          : medicationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      medicationCoding: freezed == medicationCoding
          ? _value.medicationCoding
          : medicationCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      hasDosageInstruction: freezed == hasDosageInstruction
          ? _value.hasDosageInstruction
          : hasDosageInstruction // ignore: cast_nullable_to_non_nullable
              as bool?,
      dosageInstruction: freezed == dosageInstruction
          ? _value._dosageInstruction
          : dosageInstruction // ignore: cast_nullable_to_non_nullable
              as List<DosageInstruction>?,
      dosageInstructionData: freezed == dosageInstructionData
          ? _value._dosageInstructionData
          : dosageInstructionData // ignore: cast_nullable_to_non_nullable
              as List<DosageInstructionData>?,
      whenPrepared: freezed == whenPrepared
          ? _value.whenPrepared
          : whenPrepared // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationDispenseImpl implements _MedicationDispense {
  _$MedicationDispenseImpl(
      {this.id,
      this.code,
      @JsonKey(name: 'medication_title') this.medicationTitle,
      @JsonKey(name: 'medication_coding') this.medicationCoding,
      @JsonKey(name: 'type_coding') this.typeCoding,
      @JsonKey(name: 'has_dosage_instruction') this.hasDosageInstruction,
      @JsonKey(name: 'dosage_instruction')
      final List<DosageInstruction>? dosageInstruction,
      @JsonKey(name: 'dosage_instruction_data')
      final List<DosageInstructionData>? dosageInstructionData,
      @JsonKey(name: 'when_prepared') this.whenPrepared})
      : _dosageInstruction = dosageInstruction,
        _dosageInstructionData = dosageInstructionData;

  factory _$MedicationDispenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationDispenseImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  @JsonKey(name: 'medication_title')
  final String? medicationTitle;
  @override
  @JsonKey(name: 'medication_coding')
  final Coding? medicationCoding;
  @override
  @JsonKey(name: 'type_coding')
  final Coding? typeCoding;
  @override
  @JsonKey(name: 'has_dosage_instruction')
  final bool? hasDosageInstruction;
  final List<DosageInstruction>? _dosageInstruction;
  @override
  @JsonKey(name: 'dosage_instruction')
  List<DosageInstruction>? get dosageInstruction {
    final value = _dosageInstruction;
    if (value == null) return null;
    if (_dosageInstruction is EqualUnmodifiableListView)
      return _dosageInstruction;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DosageInstructionData>? _dosageInstructionData;
  @override
  @JsonKey(name: 'dosage_instruction_data')
  List<DosageInstructionData>? get dosageInstructionData {
    final value = _dosageInstructionData;
    if (value == null) return null;
    if (_dosageInstructionData is EqualUnmodifiableListView)
      return _dosageInstructionData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'when_prepared')
  final String? whenPrepared;

  @override
  String toString() {
    return 'MedicationDispense(id: $id, code: $code, medicationTitle: $medicationTitle, medicationCoding: $medicationCoding, typeCoding: $typeCoding, hasDosageInstruction: $hasDosageInstruction, dosageInstruction: $dosageInstruction, dosageInstructionData: $dosageInstructionData, whenPrepared: $whenPrepared)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationDispenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.medicationTitle, medicationTitle) ||
                other.medicationTitle == medicationTitle) &&
            (identical(other.medicationCoding, medicationCoding) ||
                other.medicationCoding == medicationCoding) &&
            (identical(other.typeCoding, typeCoding) ||
                other.typeCoding == typeCoding) &&
            (identical(other.hasDosageInstruction, hasDosageInstruction) ||
                other.hasDosageInstruction == hasDosageInstruction) &&
            const DeepCollectionEquality()
                .equals(other._dosageInstruction, _dosageInstruction) &&
            const DeepCollectionEquality()
                .equals(other._dosageInstructionData, _dosageInstructionData) &&
            (identical(other.whenPrepared, whenPrepared) ||
                other.whenPrepared == whenPrepared));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      medicationTitle,
      medicationCoding,
      typeCoding,
      hasDosageInstruction,
      const DeepCollectionEquality().hash(_dosageInstruction),
      const DeepCollectionEquality().hash(_dosageInstructionData),
      whenPrepared);

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationDispenseImplCopyWith<_$MedicationDispenseImpl> get copyWith =>
      __$$MedicationDispenseImplCopyWithImpl<_$MedicationDispenseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationDispenseImplToJson(
      this,
    );
  }
}

abstract class _MedicationDispense implements MedicationDispense {
  factory _MedicationDispense(
      {final String? id,
      final CodeableConcept? code,
      @JsonKey(name: 'medication_title') final String? medicationTitle,
      @JsonKey(name: 'medication_coding') final Coding? medicationCoding,
      @JsonKey(name: 'type_coding') final Coding? typeCoding,
      @JsonKey(name: 'has_dosage_instruction') final bool? hasDosageInstruction,
      @JsonKey(name: 'dosage_instruction')
      final List<DosageInstruction>? dosageInstruction,
      @JsonKey(name: 'dosage_instruction_data')
      final List<DosageInstructionData>? dosageInstructionData,
      @JsonKey(name: 'when_prepared')
      final String? whenPrepared}) = _$MedicationDispenseImpl;

  factory _MedicationDispense.fromJson(Map<String, dynamic> json) =
      _$MedicationDispenseImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  @JsonKey(name: 'medication_title')
  String? get medicationTitle;
  @override
  @JsonKey(name: 'medication_coding')
  Coding? get medicationCoding;
  @override
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding;
  @override
  @JsonKey(name: 'has_dosage_instruction')
  bool? get hasDosageInstruction;
  @override
  @JsonKey(name: 'dosage_instruction')
  List<DosageInstruction>? get dosageInstruction;
  @override
  @JsonKey(name: 'dosage_instruction_data')
  List<DosageInstructionData>? get dosageInstructionData;
  @override
  @JsonKey(name: 'when_prepared')
  String? get whenPrepared;

  /// Create a copy of MedicationDispense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationDispenseImplCopyWith<_$MedicationDispenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DosageInstruction _$DosageInstructionFromJson(Map<String, dynamic> json) {
  return _DosageInstruction.fromJson(json);
}

/// @nodoc
mixin _$DosageInstruction {
  String? get text => throw _privateConstructorUsedError;

  /// Serializes this DosageInstruction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DosageInstruction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DosageInstructionCopyWith<DosageInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DosageInstructionCopyWith<$Res> {
  factory $DosageInstructionCopyWith(
          DosageInstruction value, $Res Function(DosageInstruction) then) =
      _$DosageInstructionCopyWithImpl<$Res, DosageInstruction>;
  @useResult
  $Res call({String? text});
}

/// @nodoc
class _$DosageInstructionCopyWithImpl<$Res, $Val extends DosageInstruction>
    implements $DosageInstructionCopyWith<$Res> {
  _$DosageInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DosageInstruction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DosageInstructionImplCopyWith<$Res>
    implements $DosageInstructionCopyWith<$Res> {
  factory _$$DosageInstructionImplCopyWith(_$DosageInstructionImpl value,
          $Res Function(_$DosageInstructionImpl) then) =
      __$$DosageInstructionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text});
}

/// @nodoc
class __$$DosageInstructionImplCopyWithImpl<$Res>
    extends _$DosageInstructionCopyWithImpl<$Res, _$DosageInstructionImpl>
    implements _$$DosageInstructionImplCopyWith<$Res> {
  __$$DosageInstructionImplCopyWithImpl(_$DosageInstructionImpl _value,
      $Res Function(_$DosageInstructionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DosageInstruction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_$DosageInstructionImpl(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DosageInstructionImpl implements _DosageInstruction {
  _$DosageInstructionImpl({this.text});

  factory _$DosageInstructionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DosageInstructionImplFromJson(json);

  @override
  final String? text;

  @override
  String toString() {
    return 'DosageInstruction(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DosageInstructionImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of DosageInstruction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DosageInstructionImplCopyWith<_$DosageInstructionImpl> get copyWith =>
      __$$DosageInstructionImplCopyWithImpl<_$DosageInstructionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DosageInstructionImplToJson(
      this,
    );
  }
}

abstract class _DosageInstruction implements DosageInstruction {
  factory _DosageInstruction({final String? text}) = _$DosageInstructionImpl;

  factory _DosageInstruction.fromJson(Map<String, dynamic> json) =
      _$DosageInstructionImpl.fromJson;

  @override
  String? get text;

  /// Create a copy of DosageInstruction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DosageInstructionImplCopyWith<_$DosageInstructionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DosageInstructionData _$DosageInstructionDataFromJson(
    Map<String, dynamic> json) {
  return _DosageInstructionData.fromJson(json);
}

/// @nodoc
mixin _$DosageInstructionData {
  String? get route => throw _privateConstructorUsedError;
  String? get doseQuantity => throw _privateConstructorUsedError;
  String? get additionalInstructions => throw _privateConstructorUsedError;
  String? get timing => throw _privateConstructorUsedError;

  /// Serializes this DosageInstructionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DosageInstructionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DosageInstructionDataCopyWith<DosageInstructionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DosageInstructionDataCopyWith<$Res> {
  factory $DosageInstructionDataCopyWith(DosageInstructionData value,
          $Res Function(DosageInstructionData) then) =
      _$DosageInstructionDataCopyWithImpl<$Res, DosageInstructionData>;
  @useResult
  $Res call(
      {String? route,
      String? doseQuantity,
      String? additionalInstructions,
      String? timing});
}

/// @nodoc
class _$DosageInstructionDataCopyWithImpl<$Res,
        $Val extends DosageInstructionData>
    implements $DosageInstructionDataCopyWith<$Res> {
  _$DosageInstructionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DosageInstructionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = freezed,
    Object? doseQuantity = freezed,
    Object? additionalInstructions = freezed,
    Object? timing = freezed,
  }) {
    return _then(_value.copyWith(
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      doseQuantity: freezed == doseQuantity
          ? _value.doseQuantity
          : doseQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalInstructions: freezed == additionalInstructions
          ? _value.additionalInstructions
          : additionalInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      timing: freezed == timing
          ? _value.timing
          : timing // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DosageInstructionDataImplCopyWith<$Res>
    implements $DosageInstructionDataCopyWith<$Res> {
  factory _$$DosageInstructionDataImplCopyWith(
          _$DosageInstructionDataImpl value,
          $Res Function(_$DosageInstructionDataImpl) then) =
      __$$DosageInstructionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? route,
      String? doseQuantity,
      String? additionalInstructions,
      String? timing});
}

/// @nodoc
class __$$DosageInstructionDataImplCopyWithImpl<$Res>
    extends _$DosageInstructionDataCopyWithImpl<$Res,
        _$DosageInstructionDataImpl>
    implements _$$DosageInstructionDataImplCopyWith<$Res> {
  __$$DosageInstructionDataImplCopyWithImpl(_$DosageInstructionDataImpl _value,
      $Res Function(_$DosageInstructionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DosageInstructionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = freezed,
    Object? doseQuantity = freezed,
    Object? additionalInstructions = freezed,
    Object? timing = freezed,
  }) {
    return _then(_$DosageInstructionDataImpl(
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      doseQuantity: freezed == doseQuantity
          ? _value.doseQuantity
          : doseQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalInstructions: freezed == additionalInstructions
          ? _value.additionalInstructions
          : additionalInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      timing: freezed == timing
          ? _value.timing
          : timing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DosageInstructionDataImpl implements _DosageInstructionData {
  _$DosageInstructionDataImpl(
      {this.route,
      this.doseQuantity,
      this.additionalInstructions,
      this.timing});

  factory _$DosageInstructionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DosageInstructionDataImplFromJson(json);

  @override
  final String? route;
  @override
  final String? doseQuantity;
  @override
  final String? additionalInstructions;
  @override
  final String? timing;

  @override
  String toString() {
    return 'DosageInstructionData(route: $route, doseQuantity: $doseQuantity, additionalInstructions: $additionalInstructions, timing: $timing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DosageInstructionDataImpl &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.doseQuantity, doseQuantity) ||
                other.doseQuantity == doseQuantity) &&
            (identical(other.additionalInstructions, additionalInstructions) ||
                other.additionalInstructions == additionalInstructions) &&
            (identical(other.timing, timing) || other.timing == timing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, route, doseQuantity, additionalInstructions, timing);

  /// Create a copy of DosageInstructionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DosageInstructionDataImplCopyWith<_$DosageInstructionDataImpl>
      get copyWith => __$$DosageInstructionDataImplCopyWithImpl<
          _$DosageInstructionDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DosageInstructionDataImplToJson(
      this,
    );
  }
}

abstract class _DosageInstructionData implements DosageInstructionData {
  factory _DosageInstructionData(
      {final String? route,
      final String? doseQuantity,
      final String? additionalInstructions,
      final String? timing}) = _$DosageInstructionDataImpl;

  factory _DosageInstructionData.fromJson(Map<String, dynamic> json) =
      _$DosageInstructionDataImpl.fromJson;

  @override
  String? get route;
  @override
  String? get doseQuantity;
  @override
  String? get additionalInstructions;
  @override
  String? get timing;

  /// Create a copy of DosageInstructionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DosageInstructionDataImplCopyWith<_$DosageInstructionDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
