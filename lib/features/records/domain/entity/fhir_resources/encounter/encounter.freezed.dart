// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encounter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Encounter _$EncounterFromJson(Map<String, dynamic> json) {
  return _Encounter.fromJson(json);
}

/// @nodoc
mixin _$Encounter {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_end')
  String? get periodEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_start')
  String? get periodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_participant')
  bool? get hasParticipant => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_display')
  String? get locationDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'encounter_type')
  List<CodeableConcept>? get encounterType =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'resource_class')
  String? get resourceClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'resource_status')
  String? get resourceStatus => throw _privateConstructorUsedError;
  List<EncounterParticipant>? get participant =>
      throw _privateConstructorUsedError;
  List<CodeableConcept>? get reasonCode => throw _privateConstructorUsedError;

  /// Serializes this Encounter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterCopyWith<Encounter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterCopyWith<$Res> {
  factory $EncounterCopyWith(Encounter value, $Res Function(Encounter) then) =
      _$EncounterCopyWithImpl<$Res, Encounter>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'period_end') String? periodEnd,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'has_participant') bool? hasParticipant,
      @JsonKey(name: 'location_display') String? locationDisplay,
      @JsonKey(name: 'encounter_type') List<CodeableConcept>? encounterType,
      @JsonKey(name: 'resource_class') String? resourceClass,
      @JsonKey(name: 'resource_status') String? resourceStatus,
      List<EncounterParticipant>? participant,
      List<CodeableConcept>? reasonCode});

  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class _$EncounterCopyWithImpl<$Res, $Val extends Encounter>
    implements $EncounterCopyWith<$Res> {
  _$EncounterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? periodEnd = freezed,
    Object? periodStart = freezed,
    Object? hasParticipant = freezed,
    Object? locationDisplay = freezed,
    Object? encounterType = freezed,
    Object? resourceClass = freezed,
    Object? resourceStatus = freezed,
    Object? participant = freezed,
    Object? reasonCode = freezed,
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
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      hasParticipant: freezed == hasParticipant
          ? _value.hasParticipant
          : hasParticipant // ignore: cast_nullable_to_non_nullable
              as bool?,
      locationDisplay: freezed == locationDisplay
          ? _value.locationDisplay
          : locationDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      encounterType: freezed == encounterType
          ? _value.encounterType
          : encounterType // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      resourceClass: freezed == resourceClass
          ? _value.resourceClass
          : resourceClass // ignore: cast_nullable_to_non_nullable
              as String?,
      resourceStatus: freezed == resourceStatus
          ? _value.resourceStatus
          : resourceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as List<EncounterParticipant>?,
      reasonCode: freezed == reasonCode
          ? _value.reasonCode
          : reasonCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
    ) as $Val);
  }

  /// Create a copy of Encounter
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
}

/// @nodoc
abstract class _$$EncounterImplCopyWith<$Res>
    implements $EncounterCopyWith<$Res> {
  factory _$$EncounterImplCopyWith(
          _$EncounterImpl value, $Res Function(_$EncounterImpl) then) =
      __$$EncounterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'period_end') String? periodEnd,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'has_participant') bool? hasParticipant,
      @JsonKey(name: 'location_display') String? locationDisplay,
      @JsonKey(name: 'encounter_type') List<CodeableConcept>? encounterType,
      @JsonKey(name: 'resource_class') String? resourceClass,
      @JsonKey(name: 'resource_status') String? resourceStatus,
      List<EncounterParticipant>? participant,
      List<CodeableConcept>? reasonCode});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class __$$EncounterImplCopyWithImpl<$Res>
    extends _$EncounterCopyWithImpl<$Res, _$EncounterImpl>
    implements _$$EncounterImplCopyWith<$Res> {
  __$$EncounterImplCopyWithImpl(
      _$EncounterImpl _value, $Res Function(_$EncounterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? periodEnd = freezed,
    Object? periodStart = freezed,
    Object? hasParticipant = freezed,
    Object? locationDisplay = freezed,
    Object? encounterType = freezed,
    Object? resourceClass = freezed,
    Object? resourceStatus = freezed,
    Object? participant = freezed,
    Object? reasonCode = freezed,
  }) {
    return _then(_$EncounterImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      hasParticipant: freezed == hasParticipant
          ? _value.hasParticipant
          : hasParticipant // ignore: cast_nullable_to_non_nullable
              as bool?,
      locationDisplay: freezed == locationDisplay
          ? _value.locationDisplay
          : locationDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      encounterType: freezed == encounterType
          ? _value._encounterType
          : encounterType // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      resourceClass: freezed == resourceClass
          ? _value.resourceClass
          : resourceClass // ignore: cast_nullable_to_non_nullable
              as String?,
      resourceStatus: freezed == resourceStatus
          ? _value.resourceStatus
          : resourceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value._participant
          : participant // ignore: cast_nullable_to_non_nullable
              as List<EncounterParticipant>?,
      reasonCode: freezed == reasonCode
          ? _value._reasonCode
          : reasonCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EncounterImpl implements _Encounter {
  _$EncounterImpl(
      {this.id,
      this.code,
      @JsonKey(name: 'period_end') this.periodEnd,
      @JsonKey(name: 'period_start') this.periodStart,
      @JsonKey(name: 'has_participant') this.hasParticipant,
      @JsonKey(name: 'location_display') this.locationDisplay,
      @JsonKey(name: 'encounter_type')
      final List<CodeableConcept>? encounterType,
      @JsonKey(name: 'resource_class') this.resourceClass,
      @JsonKey(name: 'resource_status') this.resourceStatus,
      final List<EncounterParticipant>? participant,
      final List<CodeableConcept>? reasonCode})
      : _encounterType = encounterType,
        _participant = participant,
        _reasonCode = reasonCode;

  factory _$EncounterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncounterImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  @JsonKey(name: 'period_end')
  final String? periodEnd;
  @override
  @JsonKey(name: 'period_start')
  final String? periodStart;
  @override
  @JsonKey(name: 'has_participant')
  final bool? hasParticipant;
  @override
  @JsonKey(name: 'location_display')
  final String? locationDisplay;
  final List<CodeableConcept>? _encounterType;
  @override
  @JsonKey(name: 'encounter_type')
  List<CodeableConcept>? get encounterType {
    final value = _encounterType;
    if (value == null) return null;
    if (_encounterType is EqualUnmodifiableListView) return _encounterType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'resource_class')
  final String? resourceClass;
  @override
  @JsonKey(name: 'resource_status')
  final String? resourceStatus;
  final List<EncounterParticipant>? _participant;
  @override
  List<EncounterParticipant>? get participant {
    final value = _participant;
    if (value == null) return null;
    if (_participant is EqualUnmodifiableListView) return _participant;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _reasonCode;
  @override
  List<CodeableConcept>? get reasonCode {
    final value = _reasonCode;
    if (value == null) return null;
    if (_reasonCode is EqualUnmodifiableListView) return _reasonCode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Encounter(id: $id, code: $code, periodEnd: $periodEnd, periodStart: $periodStart, hasParticipant: $hasParticipant, locationDisplay: $locationDisplay, encounterType: $encounterType, resourceClass: $resourceClass, resourceStatus: $resourceStatus, participant: $participant, reasonCode: $reasonCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncounterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.hasParticipant, hasParticipant) ||
                other.hasParticipant == hasParticipant) &&
            (identical(other.locationDisplay, locationDisplay) ||
                other.locationDisplay == locationDisplay) &&
            const DeepCollectionEquality()
                .equals(other._encounterType, _encounterType) &&
            (identical(other.resourceClass, resourceClass) ||
                other.resourceClass == resourceClass) &&
            (identical(other.resourceStatus, resourceStatus) ||
                other.resourceStatus == resourceStatus) &&
            const DeepCollectionEquality()
                .equals(other._participant, _participant) &&
            const DeepCollectionEquality()
                .equals(other._reasonCode, _reasonCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      periodEnd,
      periodStart,
      hasParticipant,
      locationDisplay,
      const DeepCollectionEquality().hash(_encounterType),
      resourceClass,
      resourceStatus,
      const DeepCollectionEquality().hash(_participant),
      const DeepCollectionEquality().hash(_reasonCode));

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncounterImplCopyWith<_$EncounterImpl> get copyWith =>
      __$$EncounterImplCopyWithImpl<_$EncounterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncounterImplToJson(
      this,
    );
  }
}

abstract class _Encounter implements Encounter {
  factory _Encounter(
      {final String? id,
      final CodeableConcept? code,
      @JsonKey(name: 'period_end') final String? periodEnd,
      @JsonKey(name: 'period_start') final String? periodStart,
      @JsonKey(name: 'has_participant') final bool? hasParticipant,
      @JsonKey(name: 'location_display') final String? locationDisplay,
      @JsonKey(name: 'encounter_type')
      final List<CodeableConcept>? encounterType,
      @JsonKey(name: 'resource_class') final String? resourceClass,
      @JsonKey(name: 'resource_status') final String? resourceStatus,
      final List<EncounterParticipant>? participant,
      final List<CodeableConcept>? reasonCode}) = _$EncounterImpl;

  factory _Encounter.fromJson(Map<String, dynamic> json) =
      _$EncounterImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  @JsonKey(name: 'period_end')
  String? get periodEnd;
  @override
  @JsonKey(name: 'period_start')
  String? get periodStart;
  @override
  @JsonKey(name: 'has_participant')
  bool? get hasParticipant;
  @override
  @JsonKey(name: 'location_display')
  String? get locationDisplay;
  @override
  @JsonKey(name: 'encounter_type')
  List<CodeableConcept>? get encounterType;
  @override
  @JsonKey(name: 'resource_class')
  String? get resourceClass;
  @override
  @JsonKey(name: 'resource_status')
  String? get resourceStatus;
  @override
  List<EncounterParticipant>? get participant;
  @override
  List<CodeableConcept>? get reasonCode;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncounterImplCopyWith<_$EncounterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EncounterParticipant _$EncounterParticipantFromJson(Map<String, dynamic> json) {
  return _EncounterParticipant.fromJson(json);
}

/// @nodoc
mixin _$EncounterParticipant {
  String? get display => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  Reference? get reference => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get periodStart => throw _privateConstructorUsedError;

  /// Serializes this EncounterParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterParticipantCopyWith<EncounterParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterParticipantCopyWith<$Res> {
  factory $EncounterParticipantCopyWith(EncounterParticipant value,
          $Res Function(EncounterParticipant) then) =
      _$EncounterParticipantCopyWithImpl<$Res, EncounterParticipant>;
  @useResult
  $Res call(
      {String? display,
      String? role,
      Reference? reference,
      String? text,
      String? periodStart});

  $ReferenceCopyWith<$Res>? get reference;
}

/// @nodoc
class _$EncounterParticipantCopyWithImpl<$Res,
        $Val extends EncounterParticipant>
    implements $EncounterParticipantCopyWith<$Res> {
  _$EncounterParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display = freezed,
    Object? role = freezed,
    Object? reference = freezed,
    Object? text = freezed,
    Object? periodStart = freezed,
  }) {
    return _then(_value.copyWith(
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get reference {
    if (_value.reference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.reference!, (value) {
      return _then(_value.copyWith(reference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EncounterParticipantImplCopyWith<$Res>
    implements $EncounterParticipantCopyWith<$Res> {
  factory _$$EncounterParticipantImplCopyWith(_$EncounterParticipantImpl value,
          $Res Function(_$EncounterParticipantImpl) then) =
      __$$EncounterParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? display,
      String? role,
      Reference? reference,
      String? text,
      String? periodStart});

  @override
  $ReferenceCopyWith<$Res>? get reference;
}

/// @nodoc
class __$$EncounterParticipantImplCopyWithImpl<$Res>
    extends _$EncounterParticipantCopyWithImpl<$Res, _$EncounterParticipantImpl>
    implements _$$EncounterParticipantImplCopyWith<$Res> {
  __$$EncounterParticipantImplCopyWithImpl(_$EncounterParticipantImpl _value,
      $Res Function(_$EncounterParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display = freezed,
    Object? role = freezed,
    Object? reference = freezed,
    Object? text = freezed,
    Object? periodStart = freezed,
  }) {
    return _then(_$EncounterParticipantImpl(
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EncounterParticipantImpl implements _EncounterParticipant {
  _$EncounterParticipantImpl(
      {this.display, this.role, this.reference, this.text, this.periodStart});

  factory _$EncounterParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncounterParticipantImplFromJson(json);

  @override
  final String? display;
  @override
  final String? role;
  @override
  final Reference? reference;
  @override
  final String? text;
  @override
  final String? periodStart;

  @override
  String toString() {
    return 'EncounterParticipant(display: $display, role: $role, reference: $reference, text: $text, periodStart: $periodStart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncounterParticipantImpl &&
            (identical(other.display, display) || other.display == display) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, display, role, reference, text, periodStart);

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncounterParticipantImplCopyWith<_$EncounterParticipantImpl>
      get copyWith =>
          __$$EncounterParticipantImplCopyWithImpl<_$EncounterParticipantImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncounterParticipantImplToJson(
      this,
    );
  }
}

abstract class _EncounterParticipant implements EncounterParticipant {
  factory _EncounterParticipant(
      {final String? display,
      final String? role,
      final Reference? reference,
      final String? text,
      final String? periodStart}) = _$EncounterParticipantImpl;

  factory _EncounterParticipant.fromJson(Map<String, dynamic> json) =
      _$EncounterParticipantImpl.fromJson;

  @override
  String? get display;
  @override
  String? get role;
  @override
  Reference? get reference;
  @override
  String? get text;
  @override
  String? get periodStart;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncounterParticipantImplCopyWith<_$EncounterParticipantImpl>
      get copyWith => throw _privateConstructorUsedError;
}
