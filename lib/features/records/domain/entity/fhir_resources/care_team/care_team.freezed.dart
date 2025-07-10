// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CareTeam _$CareTeamFromJson(Map<String, dynamic> json) {
  return _CareTeam.fromJson(json);
}

/// @nodoc
mixin _$CareTeam {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_start')
  String? get periodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_end')
  String? get periodEnd => throw _privateConstructorUsedError;
  List<CareTeamParticipant>? get participants =>
      throw _privateConstructorUsedError;
  List<CodeableConcept>? get category => throw _privateConstructorUsedError;
  Reference? get subject => throw _privateConstructorUsedError;
  Reference? get encounter => throw _privateConstructorUsedError;
  @JsonKey(name: 'managing_organization')
  Reference? get managingOrganization => throw _privateConstructorUsedError;

  /// Serializes this CareTeam to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CareTeamCopyWith<CareTeam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareTeamCopyWith<$Res> {
  factory $CareTeamCopyWith(CareTeam value, $Res Function(CareTeam) then) =
      _$CareTeamCopyWithImpl<$Res, CareTeam>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? name,
      String? status,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'period_end') String? periodEnd,
      List<CareTeamParticipant>? participants,
      List<CodeableConcept>? category,
      Reference? subject,
      Reference? encounter,
      @JsonKey(name: 'managing_organization') Reference? managingOrganization});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get subject;
  $ReferenceCopyWith<$Res>? get encounter;
  $ReferenceCopyWith<$Res>? get managingOrganization;
}

/// @nodoc
class _$CareTeamCopyWithImpl<$Res, $Val extends CareTeam>
    implements $CareTeamCopyWith<$Res> {
  _$CareTeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
    Object? participants = freezed,
    Object? category = freezed,
    Object? subject = freezed,
    Object? encounter = freezed,
    Object? managingOrganization = freezed,
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
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<CareTeamParticipant>?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      encounter: freezed == encounter
          ? _value.encounter
          : encounter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      managingOrganization: freezed == managingOrganization
          ? _value.managingOrganization
          : managingOrganization // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of CareTeam
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

  /// Create a copy of CareTeam
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

  /// Create a copy of CareTeam
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

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get managingOrganization {
    if (_value.managingOrganization == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.managingOrganization!, (value) {
      return _then(_value.copyWith(managingOrganization: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CareTeamImplCopyWith<$Res>
    implements $CareTeamCopyWith<$Res> {
  factory _$$CareTeamImplCopyWith(
          _$CareTeamImpl value, $Res Function(_$CareTeamImpl) then) =
      __$$CareTeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? name,
      String? status,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'period_end') String? periodEnd,
      List<CareTeamParticipant>? participants,
      List<CodeableConcept>? category,
      Reference? subject,
      Reference? encounter,
      @JsonKey(name: 'managing_organization') Reference? managingOrganization});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get subject;
  @override
  $ReferenceCopyWith<$Res>? get encounter;
  @override
  $ReferenceCopyWith<$Res>? get managingOrganization;
}

/// @nodoc
class __$$CareTeamImplCopyWithImpl<$Res>
    extends _$CareTeamCopyWithImpl<$Res, _$CareTeamImpl>
    implements _$$CareTeamImplCopyWith<$Res> {
  __$$CareTeamImplCopyWithImpl(
      _$CareTeamImpl _value, $Res Function(_$CareTeamImpl) _then)
      : super(_value, _then);

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
    Object? participants = freezed,
    Object? category = freezed,
    Object? subject = freezed,
    Object? encounter = freezed,
    Object? managingOrganization = freezed,
  }) {
    return _then(_$CareTeamImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<CareTeamParticipant>?,
      category: freezed == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      encounter: freezed == encounter
          ? _value.encounter
          : encounter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      managingOrganization: freezed == managingOrganization
          ? _value.managingOrganization
          : managingOrganization // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CareTeamImpl implements _CareTeam {
  _$CareTeamImpl(
      {this.id,
      this.code,
      this.name,
      this.status,
      @JsonKey(name: 'period_start') this.periodStart,
      @JsonKey(name: 'period_end') this.periodEnd,
      final List<CareTeamParticipant>? participants,
      final List<CodeableConcept>? category,
      this.subject,
      this.encounter,
      @JsonKey(name: 'managing_organization') this.managingOrganization})
      : _participants = participants,
        _category = category;

  factory _$CareTeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareTeamImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final String? name;
  @override
  final String? status;
  @override
  @JsonKey(name: 'period_start')
  final String? periodStart;
  @override
  @JsonKey(name: 'period_end')
  final String? periodEnd;
  final List<CareTeamParticipant>? _participants;
  @override
  List<CareTeamParticipant>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _category;
  @override
  List<CodeableConcept>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Reference? subject;
  @override
  final Reference? encounter;
  @override
  @JsonKey(name: 'managing_organization')
  final Reference? managingOrganization;

  @override
  String toString() {
    return 'CareTeam(id: $id, code: $code, name: $name, status: $status, periodStart: $periodStart, periodEnd: $periodEnd, participants: $participants, category: $category, subject: $subject, encounter: $encounter, managingOrganization: $managingOrganization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareTeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.encounter, encounter) ||
                other.encounter == encounter) &&
            (identical(other.managingOrganization, managingOrganization) ||
                other.managingOrganization == managingOrganization));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      name,
      status,
      periodStart,
      periodEnd,
      const DeepCollectionEquality().hash(_participants),
      const DeepCollectionEquality().hash(_category),
      subject,
      encounter,
      managingOrganization);

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareTeamImplCopyWith<_$CareTeamImpl> get copyWith =>
      __$$CareTeamImplCopyWithImpl<_$CareTeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareTeamImplToJson(
      this,
    );
  }
}

abstract class _CareTeam implements CareTeam {
  factory _CareTeam(
      {final String? id,
      final CodeableConcept? code,
      final String? name,
      final String? status,
      @JsonKey(name: 'period_start') final String? periodStart,
      @JsonKey(name: 'period_end') final String? periodEnd,
      final List<CareTeamParticipant>? participants,
      final List<CodeableConcept>? category,
      final Reference? subject,
      final Reference? encounter,
      @JsonKey(name: 'managing_organization')
      final Reference? managingOrganization}) = _$CareTeamImpl;

  factory _CareTeam.fromJson(Map<String, dynamic> json) =
      _$CareTeamImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  String? get name;
  @override
  String? get status;
  @override
  @JsonKey(name: 'period_start')
  String? get periodStart;
  @override
  @JsonKey(name: 'period_end')
  String? get periodEnd;
  @override
  List<CareTeamParticipant>? get participants;
  @override
  List<CodeableConcept>? get category;
  @override
  Reference? get subject;
  @override
  Reference? get encounter;
  @override
  @JsonKey(name: 'managing_organization')
  Reference? get managingOrganization;

  /// Create a copy of CareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareTeamImplCopyWith<_$CareTeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CareTeamParticipant _$CareTeamParticipantFromJson(Map<String, dynamic> json) {
  return _CareTeamParticipant.fromJson(json);
}

/// @nodoc
mixin _$CareTeamParticipant {
  Reference? get reference => throw _privateConstructorUsedError;
  String? get display => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get periodStart => throw _privateConstructorUsedError;
  String? get periodEnd => throw _privateConstructorUsedError;

  /// Serializes this CareTeamParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CareTeamParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CareTeamParticipantCopyWith<CareTeamParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareTeamParticipantCopyWith<$Res> {
  factory $CareTeamParticipantCopyWith(
          CareTeamParticipant value, $Res Function(CareTeamParticipant) then) =
      _$CareTeamParticipantCopyWithImpl<$Res, CareTeamParticipant>;
  @useResult
  $Res call(
      {Reference? reference,
      String? display,
      String? role,
      String? periodStart,
      String? periodEnd});

  $ReferenceCopyWith<$Res>? get reference;
}

/// @nodoc
class _$CareTeamParticipantCopyWithImpl<$Res, $Val extends CareTeamParticipant>
    implements $CareTeamParticipantCopyWith<$Res> {
  _$CareTeamParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CareTeamParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? display = freezed,
    Object? role = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
  }) {
    return _then(_value.copyWith(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CareTeamParticipant
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
abstract class _$$CareTeamParticipantImplCopyWith<$Res>
    implements $CareTeamParticipantCopyWith<$Res> {
  factory _$$CareTeamParticipantImplCopyWith(_$CareTeamParticipantImpl value,
          $Res Function(_$CareTeamParticipantImpl) then) =
      __$$CareTeamParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Reference? reference,
      String? display,
      String? role,
      String? periodStart,
      String? periodEnd});

  @override
  $ReferenceCopyWith<$Res>? get reference;
}

/// @nodoc
class __$$CareTeamParticipantImplCopyWithImpl<$Res>
    extends _$CareTeamParticipantCopyWithImpl<$Res, _$CareTeamParticipantImpl>
    implements _$$CareTeamParticipantImplCopyWith<$Res> {
  __$$CareTeamParticipantImplCopyWithImpl(_$CareTeamParticipantImpl _value,
      $Res Function(_$CareTeamParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of CareTeamParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? display = freezed,
    Object? role = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
  }) {
    return _then(_$CareTeamParticipantImpl(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CareTeamParticipantImpl implements _CareTeamParticipant {
  _$CareTeamParticipantImpl(
      {this.reference,
      this.display,
      this.role,
      this.periodStart,
      this.periodEnd});

  factory _$CareTeamParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$CareTeamParticipantImplFromJson(json);

  @override
  final Reference? reference;
  @override
  final String? display;
  @override
  final String? role;
  @override
  final String? periodStart;
  @override
  final String? periodEnd;

  @override
  String toString() {
    return 'CareTeamParticipant(reference: $reference, display: $display, role: $role, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CareTeamParticipantImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.display, display) || other.display == display) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, reference, display, role, periodStart, periodEnd);

  /// Create a copy of CareTeamParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CareTeamParticipantImplCopyWith<_$CareTeamParticipantImpl> get copyWith =>
      __$$CareTeamParticipantImplCopyWithImpl<_$CareTeamParticipantImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CareTeamParticipantImplToJson(
      this,
    );
  }
}

abstract class _CareTeamParticipant implements CareTeamParticipant {
  factory _CareTeamParticipant(
      {final Reference? reference,
      final String? display,
      final String? role,
      final String? periodStart,
      final String? periodEnd}) = _$CareTeamParticipantImpl;

  factory _CareTeamParticipant.fromJson(Map<String, dynamic> json) =
      _$CareTeamParticipantImpl.fromJson;

  @override
  Reference? get reference;
  @override
  String? get display;
  @override
  String? get role;
  @override
  String? get periodStart;
  @override
  String? get periodEnd;

  /// Create a copy of CareTeamParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CareTeamParticipantImplCopyWith<_$CareTeamParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
