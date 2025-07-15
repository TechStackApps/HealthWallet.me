// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicationRequest _$MedicationRequestFromJson(Map<String, dynamic> json) {
  return _MedicationRequest.fromJson(json);
}

/// @nodoc
mixin _$MedicationRequest {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get intent => throw _privateConstructorUsedError;
  CodeableConcept? get medicationCodeableConcept =>
      throw _privateConstructorUsedError;
  @ReferenceConverter()
  Reference? get requester => throw _privateConstructorUsedError;
  @ReferenceConverter()
  Reference? get subject => throw _privateConstructorUsedError;
  @ReferenceConverter()
  Reference? get encounter => throw _privateConstructorUsedError;
  String? get authoredOn => throw _privateConstructorUsedError;

  /// Serializes this MedicationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationRequestCopyWith<MedicationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationRequestCopyWith<$Res> {
  factory $MedicationRequestCopyWith(
          MedicationRequest value, $Res Function(MedicationRequest) then) =
      _$MedicationRequestCopyWithImpl<$Res, MedicationRequest>;
  @useResult
  $Res call(
      {String id,
      String status,
      String intent,
      CodeableConcept? medicationCodeableConcept,
      @ReferenceConverter() Reference? requester,
      @ReferenceConverter() Reference? subject,
      @ReferenceConverter() Reference? encounter,
      String? authoredOn});

  $CodeableConceptCopyWith<$Res>? get medicationCodeableConcept;
  $ReferenceCopyWith<$Res>? get requester;
  $ReferenceCopyWith<$Res>? get subject;
  $ReferenceCopyWith<$Res>? get encounter;
}

/// @nodoc
class _$MedicationRequestCopyWithImpl<$Res, $Val extends MedicationRequest>
    implements $MedicationRequestCopyWith<$Res> {
  _$MedicationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? intent = null,
    Object? medicationCodeableConcept = freezed,
    Object? requester = freezed,
    Object? subject = freezed,
    Object? encounter = freezed,
    Object? authoredOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      intent: null == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String,
      medicationCodeableConcept: freezed == medicationCodeableConcept
          ? _value.medicationCodeableConcept
          : medicationCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      requester: freezed == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as Reference?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      encounter: freezed == encounter
          ? _value.encounter
          : encounter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      authoredOn: freezed == authoredOn
          ? _value.authoredOn
          : authoredOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get medicationCodeableConcept {
    if (_value.medicationCodeableConcept == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.medicationCodeableConcept!,
        (value) {
      return _then(_value.copyWith(medicationCodeableConcept: value) as $Val);
    });
  }

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get requester {
    if (_value.requester == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.requester!, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get subject {
    if (_value.subject == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.subject!, (value) {
      return _then(_value.copyWith(subject: value) as $Val);
    });
  }

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get encounter {
    if (_value.encounter == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.encounter!, (value) {
      return _then(_value.copyWith(encounter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MedicationRequestImplCopyWith<$Res>
    implements $MedicationRequestCopyWith<$Res> {
  factory _$$MedicationRequestImplCopyWith(_$MedicationRequestImpl value,
          $Res Function(_$MedicationRequestImpl) then) =
      __$$MedicationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      String intent,
      CodeableConcept? medicationCodeableConcept,
      @ReferenceConverter() Reference? requester,
      @ReferenceConverter() Reference? subject,
      @ReferenceConverter() Reference? encounter,
      String? authoredOn});

  @override
  $CodeableConceptCopyWith<$Res>? get medicationCodeableConcept;
  @override
  $ReferenceCopyWith<$Res>? get requester;
  @override
  $ReferenceCopyWith<$Res>? get subject;
  @override
  $ReferenceCopyWith<$Res>? get encounter;
}

/// @nodoc
class __$$MedicationRequestImplCopyWithImpl<$Res>
    extends _$MedicationRequestCopyWithImpl<$Res, _$MedicationRequestImpl>
    implements _$$MedicationRequestImplCopyWith<$Res> {
  __$$MedicationRequestImplCopyWithImpl(_$MedicationRequestImpl _value,
      $Res Function(_$MedicationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? intent = null,
    Object? medicationCodeableConcept = freezed,
    Object? requester = freezed,
    Object? subject = freezed,
    Object? encounter = freezed,
    Object? authoredOn = freezed,
  }) {
    return _then(_$MedicationRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      intent: null == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String,
      medicationCodeableConcept: freezed == medicationCodeableConcept
          ? _value.medicationCodeableConcept
          : medicationCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      requester: freezed == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as Reference?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      encounter: freezed == encounter
          ? _value.encounter
          : encounter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      authoredOn: freezed == authoredOn
          ? _value.authoredOn
          : authoredOn // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MedicationRequestImpl implements _MedicationRequest {
  _$MedicationRequestImpl(
      {required this.id,
      required this.status,
      required this.intent,
      this.medicationCodeableConcept,
      @ReferenceConverter() this.requester,
      @ReferenceConverter() this.subject,
      @ReferenceConverter() this.encounter,
      this.authoredOn});

  factory _$MedicationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  final String intent;
  @override
  final CodeableConcept? medicationCodeableConcept;
  @override
  @ReferenceConverter()
  final Reference? requester;
  @override
  @ReferenceConverter()
  final Reference? subject;
  @override
  @ReferenceConverter()
  final Reference? encounter;
  @override
  final String? authoredOn;

  @override
  String toString() {
    return 'MedicationRequest(id: $id, status: $status, intent: $intent, medicationCodeableConcept: $medicationCodeableConcept, requester: $requester, subject: $subject, encounter: $encounter, authoredOn: $authoredOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.medicationCodeableConcept,
                    medicationCodeableConcept) ||
                other.medicationCodeableConcept == medicationCodeableConcept) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.encounter, encounter) ||
                other.encounter == encounter) &&
            (identical(other.authoredOn, authoredOn) ||
                other.authoredOn == authoredOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, intent,
      medicationCodeableConcept, requester, subject, encounter, authoredOn);

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationRequestImplCopyWith<_$MedicationRequestImpl> get copyWith =>
      __$$MedicationRequestImplCopyWithImpl<_$MedicationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationRequestImplToJson(
      this,
    );
  }
}

abstract class _MedicationRequest implements MedicationRequest {
  factory _MedicationRequest(
      {required final String id,
      required final String status,
      required final String intent,
      final CodeableConcept? medicationCodeableConcept,
      @ReferenceConverter() final Reference? requester,
      @ReferenceConverter() final Reference? subject,
      @ReferenceConverter() final Reference? encounter,
      final String? authoredOn}) = _$MedicationRequestImpl;

  factory _MedicationRequest.fromJson(Map<String, dynamic> json) =
      _$MedicationRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  String get intent;
  @override
  CodeableConcept? get medicationCodeableConcept;
  @override
  @ReferenceConverter()
  Reference? get requester;
  @override
  @ReferenceConverter()
  Reference? get subject;
  @override
  @ReferenceConverter()
  Reference? get encounter;
  @override
  String? get authoredOn;

  /// Create a copy of MedicationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationRequestImplCopyWith<_$MedicationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
