// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adverse_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdverseEvent _$AdverseEventFromJson(Map<String, dynamic> json) {
  return _AdverseEvent.fromJson(json);
}

/// @nodoc
mixin _$AdverseEvent {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  Reference? get subject => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type')
  String? get eventType => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_event_type')
  bool? get hasEventType => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  CodeableConcept? get seriousness => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_seriousness')
  bool? get hasSeriousness => throw _privateConstructorUsedError;
  String? get actuality => throw _privateConstructorUsedError;
  CodeableConcept? get event => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_event')
  bool? get hasEvent => throw _privateConstructorUsedError;

  /// Serializes this AdverseEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdverseEventCopyWith<AdverseEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdverseEventCopyWith<$Res> {
  factory $AdverseEventCopyWith(
          AdverseEvent value, $Res Function(AdverseEvent) then) =
      _$AdverseEventCopyWithImpl<$Res, AdverseEvent>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      Reference? subject,
      String? description,
      @JsonKey(name: 'event_type') String? eventType,
      @JsonKey(name: 'has_event_type') bool? hasEventType,
      String? date,
      CodeableConcept? seriousness,
      @JsonKey(name: 'has_seriousness') bool? hasSeriousness,
      String? actuality,
      CodeableConcept? event,
      @JsonKey(name: 'has_event') bool? hasEvent});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get subject;
  $CodeableConceptCopyWith<$Res>? get seriousness;
  $CodeableConceptCopyWith<$Res>? get event;
}

/// @nodoc
class _$AdverseEventCopyWithImpl<$Res, $Val extends AdverseEvent>
    implements $AdverseEventCopyWith<$Res> {
  _$AdverseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? subject = freezed,
    Object? description = freezed,
    Object? eventType = freezed,
    Object? hasEventType = freezed,
    Object? date = freezed,
    Object? seriousness = freezed,
    Object? hasSeriousness = freezed,
    Object? actuality = freezed,
    Object? event = freezed,
    Object? hasEvent = freezed,
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
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasEventType: freezed == hasEventType
          ? _value.hasEventType
          : hasEventType // ignore: cast_nullable_to_non_nullable
              as bool?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      seriousness: freezed == seriousness
          ? _value.seriousness
          : seriousness // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      hasSeriousness: freezed == hasSeriousness
          ? _value.hasSeriousness
          : hasSeriousness // ignore: cast_nullable_to_non_nullable
              as bool?,
      actuality: freezed == actuality
          ? _value.actuality
          : actuality // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      hasEvent: freezed == hasEvent
          ? _value.hasEvent
          : hasEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of AdverseEvent
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

  /// Create a copy of AdverseEvent
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

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get seriousness {
    if (_value.seriousness == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.seriousness!, (value) {
      return _then(_value.copyWith(seriousness: value) as $Val);
    });
  }

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdverseEventImplCopyWith<$Res>
    implements $AdverseEventCopyWith<$Res> {
  factory _$$AdverseEventImplCopyWith(
          _$AdverseEventImpl value, $Res Function(_$AdverseEventImpl) then) =
      __$$AdverseEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      Reference? subject,
      String? description,
      @JsonKey(name: 'event_type') String? eventType,
      @JsonKey(name: 'has_event_type') bool? hasEventType,
      String? date,
      CodeableConcept? seriousness,
      @JsonKey(name: 'has_seriousness') bool? hasSeriousness,
      String? actuality,
      CodeableConcept? event,
      @JsonKey(name: 'has_event') bool? hasEvent});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get subject;
  @override
  $CodeableConceptCopyWith<$Res>? get seriousness;
  @override
  $CodeableConceptCopyWith<$Res>? get event;
}

/// @nodoc
class __$$AdverseEventImplCopyWithImpl<$Res>
    extends _$AdverseEventCopyWithImpl<$Res, _$AdverseEventImpl>
    implements _$$AdverseEventImplCopyWith<$Res> {
  __$$AdverseEventImplCopyWithImpl(
      _$AdverseEventImpl _value, $Res Function(_$AdverseEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? subject = freezed,
    Object? description = freezed,
    Object? eventType = freezed,
    Object? hasEventType = freezed,
    Object? date = freezed,
    Object? seriousness = freezed,
    Object? hasSeriousness = freezed,
    Object? actuality = freezed,
    Object? event = freezed,
    Object? hasEvent = freezed,
  }) {
    return _then(_$AdverseEventImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasEventType: freezed == hasEventType
          ? _value.hasEventType
          : hasEventType // ignore: cast_nullable_to_non_nullable
              as bool?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      seriousness: freezed == seriousness
          ? _value.seriousness
          : seriousness // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      hasSeriousness: freezed == hasSeriousness
          ? _value.hasSeriousness
          : hasSeriousness // ignore: cast_nullable_to_non_nullable
              as bool?,
      actuality: freezed == actuality
          ? _value.actuality
          : actuality // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      hasEvent: freezed == hasEvent
          ? _value.hasEvent
          : hasEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdverseEventImpl implements _AdverseEvent {
  _$AdverseEventImpl(
      {this.id,
      this.code,
      this.subject,
      this.description,
      @JsonKey(name: 'event_type') this.eventType,
      @JsonKey(name: 'has_event_type') this.hasEventType,
      this.date,
      this.seriousness,
      @JsonKey(name: 'has_seriousness') this.hasSeriousness,
      this.actuality,
      this.event,
      @JsonKey(name: 'has_event') this.hasEvent});

  factory _$AdverseEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdverseEventImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final Reference? subject;
  @override
  final String? description;
  @override
  @JsonKey(name: 'event_type')
  final String? eventType;
  @override
  @JsonKey(name: 'has_event_type')
  final bool? hasEventType;
  @override
  final String? date;
  @override
  final CodeableConcept? seriousness;
  @override
  @JsonKey(name: 'has_seriousness')
  final bool? hasSeriousness;
  @override
  final String? actuality;
  @override
  final CodeableConcept? event;
  @override
  @JsonKey(name: 'has_event')
  final bool? hasEvent;

  @override
  String toString() {
    return 'AdverseEvent(id: $id, code: $code, subject: $subject, description: $description, eventType: $eventType, hasEventType: $hasEventType, date: $date, seriousness: $seriousness, hasSeriousness: $hasSeriousness, actuality: $actuality, event: $event, hasEvent: $hasEvent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdverseEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.hasEventType, hasEventType) ||
                other.hasEventType == hasEventType) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.seriousness, seriousness) ||
                other.seriousness == seriousness) &&
            (identical(other.hasSeriousness, hasSeriousness) ||
                other.hasSeriousness == hasSeriousness) &&
            (identical(other.actuality, actuality) ||
                other.actuality == actuality) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.hasEvent, hasEvent) ||
                other.hasEvent == hasEvent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      subject,
      description,
      eventType,
      hasEventType,
      date,
      seriousness,
      hasSeriousness,
      actuality,
      event,
      hasEvent);

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdverseEventImplCopyWith<_$AdverseEventImpl> get copyWith =>
      __$$AdverseEventImplCopyWithImpl<_$AdverseEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdverseEventImplToJson(
      this,
    );
  }
}

abstract class _AdverseEvent implements AdverseEvent {
  factory _AdverseEvent(
      {final String? id,
      final CodeableConcept? code,
      final Reference? subject,
      final String? description,
      @JsonKey(name: 'event_type') final String? eventType,
      @JsonKey(name: 'has_event_type') final bool? hasEventType,
      final String? date,
      final CodeableConcept? seriousness,
      @JsonKey(name: 'has_seriousness') final bool? hasSeriousness,
      final String? actuality,
      final CodeableConcept? event,
      @JsonKey(name: 'has_event') final bool? hasEvent}) = _$AdverseEventImpl;

  factory _AdverseEvent.fromJson(Map<String, dynamic> json) =
      _$AdverseEventImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  Reference? get subject;
  @override
  String? get description;
  @override
  @JsonKey(name: 'event_type')
  String? get eventType;
  @override
  @JsonKey(name: 'has_event_type')
  bool? get hasEventType;
  @override
  String? get date;
  @override
  CodeableConcept? get seriousness;
  @override
  @JsonKey(name: 'has_seriousness')
  bool? get hasSeriousness;
  @override
  String? get actuality;
  @override
  CodeableConcept? get event;
  @override
  @JsonKey(name: 'has_event')
  bool? get hasEvent;

  /// Create a copy of AdverseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdverseEventImplCopyWith<_$AdverseEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
