// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get start => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get participant => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_patient')
  String? get participantPatient => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_practitioner')
  String? get participantPractitioner => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_location')
  String? get participantLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'minutes_duration')
  String? get minutesDuration => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancelation_reason')
  String? get cancelationReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_category')
  String? get serviceCategory => throw _privateConstructorUsedError;

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? description,
      String? status,
      String? start,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      String? comment,
      String? participant,
      @JsonKey(name: 'participant_patient') String? participantPatient,
      @JsonKey(name: 'participant_practitioner')
      String? participantPractitioner,
      @JsonKey(name: 'participant_location') String? participantLocation,
      @JsonKey(name: 'minutes_duration') String? minutesDuration,
      String? reason,
      @JsonKey(name: 'cancelation_reason') String? cancelationReason,
      @JsonKey(name: 'service_category') String? serviceCategory});

  $CodeableConceptCopyWith<$Res>? get code;
  $CodingCopyWith<$Res>? get typeCoding;
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? start = freezed,
    Object? typeCoding = freezed,
    Object? comment = freezed,
    Object? participant = freezed,
    Object? participantPatient = freezed,
    Object? participantPractitioner = freezed,
    Object? participantLocation = freezed,
    Object? minutesDuration = freezed,
    Object? reason = freezed,
    Object? cancelationReason = freezed,
    Object? serviceCategory = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as String?,
      participantPatient: freezed == participantPatient
          ? _value.participantPatient
          : participantPatient // ignore: cast_nullable_to_non_nullable
              as String?,
      participantPractitioner: freezed == participantPractitioner
          ? _value.participantPractitioner
          : participantPractitioner // ignore: cast_nullable_to_non_nullable
              as String?,
      participantLocation: freezed == participantLocation
          ? _value.participantLocation
          : participantLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      minutesDuration: freezed == minutesDuration
          ? _value.minutesDuration
          : minutesDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelationReason: freezed == cancelationReason
          ? _value.cancelationReason
          : cancelationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCategory: freezed == serviceCategory
          ? _value.serviceCategory
          : serviceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Appointment
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

  /// Create a copy of Appointment
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
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
          _$AppointmentImpl value, $Res Function(_$AppointmentImpl) then) =
      __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? description,
      String? status,
      String? start,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      String? comment,
      String? participant,
      @JsonKey(name: 'participant_patient') String? participantPatient,
      @JsonKey(name: 'participant_practitioner')
      String? participantPractitioner,
      @JsonKey(name: 'participant_location') String? participantLocation,
      @JsonKey(name: 'minutes_duration') String? minutesDuration,
      String? reason,
      @JsonKey(name: 'cancelation_reason') String? cancelationReason,
      @JsonKey(name: 'service_category') String? serviceCategory});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $CodingCopyWith<$Res>? get typeCoding;
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
      _$AppointmentImpl _value, $Res Function(_$AppointmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? start = freezed,
    Object? typeCoding = freezed,
    Object? comment = freezed,
    Object? participant = freezed,
    Object? participantPatient = freezed,
    Object? participantPractitioner = freezed,
    Object? participantLocation = freezed,
    Object? minutesDuration = freezed,
    Object? reason = freezed,
    Object? cancelationReason = freezed,
    Object? serviceCategory = freezed,
  }) {
    return _then(_$AppointmentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as String?,
      participantPatient: freezed == participantPatient
          ? _value.participantPatient
          : participantPatient // ignore: cast_nullable_to_non_nullable
              as String?,
      participantPractitioner: freezed == participantPractitioner
          ? _value.participantPractitioner
          : participantPractitioner // ignore: cast_nullable_to_non_nullable
              as String?,
      participantLocation: freezed == participantLocation
          ? _value.participantLocation
          : participantLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      minutesDuration: freezed == minutesDuration
          ? _value.minutesDuration
          : minutesDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelationReason: freezed == cancelationReason
          ? _value.cancelationReason
          : cancelationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCategory: freezed == serviceCategory
          ? _value.serviceCategory
          : serviceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentImpl implements _Appointment {
  _$AppointmentImpl(
      {this.id,
      this.code,
      this.description,
      this.status,
      this.start,
      @JsonKey(name: 'type_coding') this.typeCoding,
      this.comment,
      this.participant,
      @JsonKey(name: 'participant_patient') this.participantPatient,
      @JsonKey(name: 'participant_practitioner') this.participantPractitioner,
      @JsonKey(name: 'participant_location') this.participantLocation,
      @JsonKey(name: 'minutes_duration') this.minutesDuration,
      this.reason,
      @JsonKey(name: 'cancelation_reason') this.cancelationReason,
      @JsonKey(name: 'service_category') this.serviceCategory});

  factory _$AppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final String? description;
  @override
  final String? status;
  @override
  final String? start;
  @override
  @JsonKey(name: 'type_coding')
  final Coding? typeCoding;
  @override
  final String? comment;
  @override
  final String? participant;
  @override
  @JsonKey(name: 'participant_patient')
  final String? participantPatient;
  @override
  @JsonKey(name: 'participant_practitioner')
  final String? participantPractitioner;
  @override
  @JsonKey(name: 'participant_location')
  final String? participantLocation;
  @override
  @JsonKey(name: 'minutes_duration')
  final String? minutesDuration;
  @override
  final String? reason;
  @override
  @JsonKey(name: 'cancelation_reason')
  final String? cancelationReason;
  @override
  @JsonKey(name: 'service_category')
  final String? serviceCategory;

  @override
  String toString() {
    return 'Appointment(id: $id, code: $code, description: $description, status: $status, start: $start, typeCoding: $typeCoding, comment: $comment, participant: $participant, participantPatient: $participantPatient, participantPractitioner: $participantPractitioner, participantLocation: $participantLocation, minutesDuration: $minutesDuration, reason: $reason, cancelationReason: $cancelationReason, serviceCategory: $serviceCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.typeCoding, typeCoding) ||
                other.typeCoding == typeCoding) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.participant, participant) ||
                other.participant == participant) &&
            (identical(other.participantPatient, participantPatient) ||
                other.participantPatient == participantPatient) &&
            (identical(
                    other.participantPractitioner, participantPractitioner) ||
                other.participantPractitioner == participantPractitioner) &&
            (identical(other.participantLocation, participantLocation) ||
                other.participantLocation == participantLocation) &&
            (identical(other.minutesDuration, minutesDuration) ||
                other.minutesDuration == minutesDuration) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.cancelationReason, cancelationReason) ||
                other.cancelationReason == cancelationReason) &&
            (identical(other.serviceCategory, serviceCategory) ||
                other.serviceCategory == serviceCategory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      description,
      status,
      start,
      typeCoding,
      comment,
      participant,
      participantPatient,
      participantPractitioner,
      participantLocation,
      minutesDuration,
      reason,
      cancelationReason,
      serviceCategory);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentImplToJson(
      this,
    );
  }
}

abstract class _Appointment implements Appointment {
  factory _Appointment(
      {final String? id,
      final CodeableConcept? code,
      final String? description,
      final String? status,
      final String? start,
      @JsonKey(name: 'type_coding') final Coding? typeCoding,
      final String? comment,
      final String? participant,
      @JsonKey(name: 'participant_patient') final String? participantPatient,
      @JsonKey(name: 'participant_practitioner')
      final String? participantPractitioner,
      @JsonKey(name: 'participant_location') final String? participantLocation,
      @JsonKey(name: 'minutes_duration') final String? minutesDuration,
      final String? reason,
      @JsonKey(name: 'cancelation_reason') final String? cancelationReason,
      @JsonKey(name: 'service_category')
      final String? serviceCategory}) = _$AppointmentImpl;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$AppointmentImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  String? get description;
  @override
  String? get status;
  @override
  String? get start;
  @override
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding;
  @override
  String? get comment;
  @override
  String? get participant;
  @override
  @JsonKey(name: 'participant_patient')
  String? get participantPatient;
  @override
  @JsonKey(name: 'participant_practitioner')
  String? get participantPractitioner;
  @override
  @JsonKey(name: 'participant_location')
  String? get participantLocation;
  @override
  @JsonKey(name: 'minutes_duration')
  String? get minutesDuration;
  @override
  String? get reason;
  @override
  @JsonKey(name: 'cancelation_reason')
  String? get cancelationReason;
  @override
  @JsonKey(name: 'service_category')
  String? get serviceCategory;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
