// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'condition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Condition _$ConditionFromJson(Map<String, dynamic> json) {
  return _Condition.fromJson(json);
}

/// @nodoc
mixin _$Condition {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_text')
  String? get codeText => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_id')
  String? get codeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_system')
  String? get codeSystem => throw _privateConstructorUsedError;
  @JsonKey(name: 'severity_text')
  String? get severityText => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_asserter')
  bool? get hasAsserter => throw _privateConstructorUsedError;
  Reference? get asserter => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_body_site')
  bool? get hasBodySite => throw _privateConstructorUsedError;
  @JsonKey(name: 'body_site')
  List<CodeableConcept>? get bodySite => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinical_status')
  String? get clinicalStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_recorded')
  String? get dateRecorded => throw _privateConstructorUsedError;
  @JsonKey(name: 'onset_datetime')
  String? get onsetDatetime => throw _privateConstructorUsedError;
  @JsonKey(name: 'abatement_datetime')
  String? get abatementDatetime => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this Condition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConditionCopyWith<Condition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConditionCopyWith<$Res> {
  factory $ConditionCopyWith(Condition value, $Res Function(Condition) then) =
      _$ConditionCopyWithImpl<$Res, Condition>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'code_text') String? codeText,
      @JsonKey(name: 'code_id') String? codeId,
      @JsonKey(name: 'code_system') String? codeSystem,
      @JsonKey(name: 'severity_text') String? severityText,
      @JsonKey(name: 'has_asserter') bool? hasAsserter,
      Reference? asserter,
      @JsonKey(name: 'has_body_site') bool? hasBodySite,
      @JsonKey(name: 'body_site') List<CodeableConcept>? bodySite,
      @JsonKey(name: 'clinical_status') String? clinicalStatus,
      @JsonKey(name: 'date_recorded') String? dateRecorded,
      @JsonKey(name: 'onset_datetime') String? onsetDatetime,
      @JsonKey(name: 'abatement_datetime') String? abatementDatetime,
      String? note});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get asserter;
}

/// @nodoc
class _$ConditionCopyWithImpl<$Res, $Val extends Condition>
    implements $ConditionCopyWith<$Res> {
  _$ConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? codeText = freezed,
    Object? codeId = freezed,
    Object? codeSystem = freezed,
    Object? severityText = freezed,
    Object? hasAsserter = freezed,
    Object? asserter = freezed,
    Object? hasBodySite = freezed,
    Object? bodySite = freezed,
    Object? clinicalStatus = freezed,
    Object? dateRecorded = freezed,
    Object? onsetDatetime = freezed,
    Object? abatementDatetime = freezed,
    Object? note = freezed,
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
      codeText: freezed == codeText
          ? _value.codeText
          : codeText // ignore: cast_nullable_to_non_nullable
              as String?,
      codeId: freezed == codeId
          ? _value.codeId
          : codeId // ignore: cast_nullable_to_non_nullable
              as String?,
      codeSystem: freezed == codeSystem
          ? _value.codeSystem
          : codeSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      severityText: freezed == severityText
          ? _value.severityText
          : severityText // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAsserter: freezed == hasAsserter
          ? _value.hasAsserter
          : hasAsserter // ignore: cast_nullable_to_non_nullable
              as bool?,
      asserter: freezed == asserter
          ? _value.asserter
          : asserter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      hasBodySite: freezed == hasBodySite
          ? _value.hasBodySite
          : hasBodySite // ignore: cast_nullable_to_non_nullable
              as bool?,
      bodySite: freezed == bodySite
          ? _value.bodySite
          : bodySite // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      clinicalStatus: freezed == clinicalStatus
          ? _value.clinicalStatus
          : clinicalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      dateRecorded: freezed == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String?,
      onsetDatetime: freezed == onsetDatetime
          ? _value.onsetDatetime
          : onsetDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      abatementDatetime: freezed == abatementDatetime
          ? _value.abatementDatetime
          : abatementDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Condition
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

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get asserter {
    if (_value.asserter == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.asserter!, (value) {
      return _then(_value.copyWith(asserter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConditionImplCopyWith<$Res>
    implements $ConditionCopyWith<$Res> {
  factory _$$ConditionImplCopyWith(
          _$ConditionImpl value, $Res Function(_$ConditionImpl) then) =
      __$$ConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'code_text') String? codeText,
      @JsonKey(name: 'code_id') String? codeId,
      @JsonKey(name: 'code_system') String? codeSystem,
      @JsonKey(name: 'severity_text') String? severityText,
      @JsonKey(name: 'has_asserter') bool? hasAsserter,
      Reference? asserter,
      @JsonKey(name: 'has_body_site') bool? hasBodySite,
      @JsonKey(name: 'body_site') List<CodeableConcept>? bodySite,
      @JsonKey(name: 'clinical_status') String? clinicalStatus,
      @JsonKey(name: 'date_recorded') String? dateRecorded,
      @JsonKey(name: 'onset_datetime') String? onsetDatetime,
      @JsonKey(name: 'abatement_datetime') String? abatementDatetime,
      String? note});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get asserter;
}

/// @nodoc
class __$$ConditionImplCopyWithImpl<$Res>
    extends _$ConditionCopyWithImpl<$Res, _$ConditionImpl>
    implements _$$ConditionImplCopyWith<$Res> {
  __$$ConditionImplCopyWithImpl(
      _$ConditionImpl _value, $Res Function(_$ConditionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? codeText = freezed,
    Object? codeId = freezed,
    Object? codeSystem = freezed,
    Object? severityText = freezed,
    Object? hasAsserter = freezed,
    Object? asserter = freezed,
    Object? hasBodySite = freezed,
    Object? bodySite = freezed,
    Object? clinicalStatus = freezed,
    Object? dateRecorded = freezed,
    Object? onsetDatetime = freezed,
    Object? abatementDatetime = freezed,
    Object? note = freezed,
  }) {
    return _then(_$ConditionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      codeText: freezed == codeText
          ? _value.codeText
          : codeText // ignore: cast_nullable_to_non_nullable
              as String?,
      codeId: freezed == codeId
          ? _value.codeId
          : codeId // ignore: cast_nullable_to_non_nullable
              as String?,
      codeSystem: freezed == codeSystem
          ? _value.codeSystem
          : codeSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      severityText: freezed == severityText
          ? _value.severityText
          : severityText // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAsserter: freezed == hasAsserter
          ? _value.hasAsserter
          : hasAsserter // ignore: cast_nullable_to_non_nullable
              as bool?,
      asserter: freezed == asserter
          ? _value.asserter
          : asserter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      hasBodySite: freezed == hasBodySite
          ? _value.hasBodySite
          : hasBodySite // ignore: cast_nullable_to_non_nullable
              as bool?,
      bodySite: freezed == bodySite
          ? _value._bodySite
          : bodySite // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      clinicalStatus: freezed == clinicalStatus
          ? _value.clinicalStatus
          : clinicalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      dateRecorded: freezed == dateRecorded
          ? _value.dateRecorded
          : dateRecorded // ignore: cast_nullable_to_non_nullable
              as String?,
      onsetDatetime: freezed == onsetDatetime
          ? _value.onsetDatetime
          : onsetDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      abatementDatetime: freezed == abatementDatetime
          ? _value.abatementDatetime
          : abatementDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConditionImpl implements _Condition {
  const _$ConditionImpl(
      {this.id,
      this.code,
      @JsonKey(name: 'code_text') this.codeText,
      @JsonKey(name: 'code_id') this.codeId,
      @JsonKey(name: 'code_system') this.codeSystem,
      @JsonKey(name: 'severity_text') this.severityText,
      @JsonKey(name: 'has_asserter') this.hasAsserter,
      this.asserter,
      @JsonKey(name: 'has_body_site') this.hasBodySite,
      @JsonKey(name: 'body_site') final List<CodeableConcept>? bodySite,
      @JsonKey(name: 'clinical_status') this.clinicalStatus,
      @JsonKey(name: 'date_recorded') this.dateRecorded,
      @JsonKey(name: 'onset_datetime') this.onsetDatetime,
      @JsonKey(name: 'abatement_datetime') this.abatementDatetime,
      this.note})
      : _bodySite = bodySite;

  factory _$ConditionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConditionImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  @JsonKey(name: 'code_text')
  final String? codeText;
  @override
  @JsonKey(name: 'code_id')
  final String? codeId;
  @override
  @JsonKey(name: 'code_system')
  final String? codeSystem;
  @override
  @JsonKey(name: 'severity_text')
  final String? severityText;
  @override
  @JsonKey(name: 'has_asserter')
  final bool? hasAsserter;
  @override
  final Reference? asserter;
  @override
  @JsonKey(name: 'has_body_site')
  final bool? hasBodySite;
  final List<CodeableConcept>? _bodySite;
  @override
  @JsonKey(name: 'body_site')
  List<CodeableConcept>? get bodySite {
    final value = _bodySite;
    if (value == null) return null;
    if (_bodySite is EqualUnmodifiableListView) return _bodySite;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'clinical_status')
  final String? clinicalStatus;
  @override
  @JsonKey(name: 'date_recorded')
  final String? dateRecorded;
  @override
  @JsonKey(name: 'onset_datetime')
  final String? onsetDatetime;
  @override
  @JsonKey(name: 'abatement_datetime')
  final String? abatementDatetime;
  @override
  final String? note;

  @override
  String toString() {
    return 'Condition(id: $id, code: $code, codeText: $codeText, codeId: $codeId, codeSystem: $codeSystem, severityText: $severityText, hasAsserter: $hasAsserter, asserter: $asserter, hasBodySite: $hasBodySite, bodySite: $bodySite, clinicalStatus: $clinicalStatus, dateRecorded: $dateRecorded, onsetDatetime: $onsetDatetime, abatementDatetime: $abatementDatetime, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConditionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codeText, codeText) ||
                other.codeText == codeText) &&
            (identical(other.codeId, codeId) || other.codeId == codeId) &&
            (identical(other.codeSystem, codeSystem) ||
                other.codeSystem == codeSystem) &&
            (identical(other.severityText, severityText) ||
                other.severityText == severityText) &&
            (identical(other.hasAsserter, hasAsserter) ||
                other.hasAsserter == hasAsserter) &&
            (identical(other.asserter, asserter) ||
                other.asserter == asserter) &&
            (identical(other.hasBodySite, hasBodySite) ||
                other.hasBodySite == hasBodySite) &&
            const DeepCollectionEquality().equals(other._bodySite, _bodySite) &&
            (identical(other.clinicalStatus, clinicalStatus) ||
                other.clinicalStatus == clinicalStatus) &&
            (identical(other.dateRecorded, dateRecorded) ||
                other.dateRecorded == dateRecorded) &&
            (identical(other.onsetDatetime, onsetDatetime) ||
                other.onsetDatetime == onsetDatetime) &&
            (identical(other.abatementDatetime, abatementDatetime) ||
                other.abatementDatetime == abatementDatetime) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      codeText,
      codeId,
      codeSystem,
      severityText,
      hasAsserter,
      asserter,
      hasBodySite,
      const DeepCollectionEquality().hash(_bodySite),
      clinicalStatus,
      dateRecorded,
      onsetDatetime,
      abatementDatetime,
      note);

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConditionImplCopyWith<_$ConditionImpl> get copyWith =>
      __$$ConditionImplCopyWithImpl<_$ConditionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConditionImplToJson(
      this,
    );
  }
}

abstract class _Condition implements Condition {
  const factory _Condition(
      {final String? id,
      final CodeableConcept? code,
      @JsonKey(name: 'code_text') final String? codeText,
      @JsonKey(name: 'code_id') final String? codeId,
      @JsonKey(name: 'code_system') final String? codeSystem,
      @JsonKey(name: 'severity_text') final String? severityText,
      @JsonKey(name: 'has_asserter') final bool? hasAsserter,
      final Reference? asserter,
      @JsonKey(name: 'has_body_site') final bool? hasBodySite,
      @JsonKey(name: 'body_site') final List<CodeableConcept>? bodySite,
      @JsonKey(name: 'clinical_status') final String? clinicalStatus,
      @JsonKey(name: 'date_recorded') final String? dateRecorded,
      @JsonKey(name: 'onset_datetime') final String? onsetDatetime,
      @JsonKey(name: 'abatement_datetime') final String? abatementDatetime,
      final String? note}) = _$ConditionImpl;

  factory _Condition.fromJson(Map<String, dynamic> json) =
      _$ConditionImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  @JsonKey(name: 'code_text')
  String? get codeText;
  @override
  @JsonKey(name: 'code_id')
  String? get codeId;
  @override
  @JsonKey(name: 'code_system')
  String? get codeSystem;
  @override
  @JsonKey(name: 'severity_text')
  String? get severityText;
  @override
  @JsonKey(name: 'has_asserter')
  bool? get hasAsserter;
  @override
  Reference? get asserter;
  @override
  @JsonKey(name: 'has_body_site')
  bool? get hasBodySite;
  @override
  @JsonKey(name: 'body_site')
  List<CodeableConcept>? get bodySite;
  @override
  @JsonKey(name: 'clinical_status')
  String? get clinicalStatus;
  @override
  @JsonKey(name: 'date_recorded')
  String? get dateRecorded;
  @override
  @JsonKey(name: 'onset_datetime')
  String? get onsetDatetime;
  @override
  @JsonKey(name: 'abatement_datetime')
  String? get abatementDatetime;
  @override
  String? get note;

  /// Create a copy of Condition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConditionImplCopyWith<_$ConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
