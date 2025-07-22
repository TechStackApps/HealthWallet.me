// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'research_study.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResearchStudy _$ResearchStudyFromJson(Map<String, dynamic> json) {
  return _ResearchStudy.fromJson(json);
}

/// @nodoc
mixin _$ResearchStudy {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_coding')
  Coding? get categoryCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'focus_coding')
  Coding? get focusCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'protocol_reference')
  Reference? get protocolReference => throw _privateConstructorUsedError;
  @JsonKey(name: 'part_of_reference')
  Reference? get partOfReference => throw _privateConstructorUsedError;
  List<ResearchStudyContact>? get contacts =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'keyword_concepts')
  List<CodeableConcept>? get keywordConcepts =>
      throw _privateConstructorUsedError;
  ResearchStudyPeriod? get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'enrollment_references')
  List<Reference>? get enrollmentReferences =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'sponsor_reference')
  Reference? get sponsorReference => throw _privateConstructorUsedError;
  @JsonKey(name: 'principal_investigator_reference')
  Reference? get principalInvestigatorReference =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'site_references')
  List<Reference>? get siteReferences => throw _privateConstructorUsedError;
  List<String>? get comments => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<ResearchStudyArm>? get arms => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_purpose_type')
  String? get primaryPurposeType => throw _privateConstructorUsedError;

  /// Serializes this ResearchStudy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchStudyCopyWith<ResearchStudy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchStudyCopyWith<$Res> {
  factory $ResearchStudyCopyWith(
          ResearchStudy value, $Res Function(ResearchStudy) then) =
      _$ResearchStudyCopyWithImpl<$Res, ResearchStudy>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'category_coding') Coding? categoryCoding,
      @JsonKey(name: 'focus_coding') Coding? focusCoding,
      @JsonKey(name: 'protocol_reference') Reference? protocolReference,
      @JsonKey(name: 'part_of_reference') Reference? partOfReference,
      List<ResearchStudyContact>? contacts,
      @JsonKey(name: 'keyword_concepts') List<CodeableConcept>? keywordConcepts,
      ResearchStudyPeriod? period,
      @JsonKey(name: 'enrollment_references')
      List<Reference>? enrollmentReferences,
      @JsonKey(name: 'sponsor_reference') Reference? sponsorReference,
      @JsonKey(name: 'principal_investigator_reference')
      Reference? principalInvestigatorReference,
      @JsonKey(name: 'site_references') List<Reference>? siteReferences,
      List<String>? comments,
      String? description,
      List<ResearchStudyArm>? arms,
      String? location,
      @JsonKey(name: 'primary_purpose_type') String? primaryPurposeType});

  $CodingCopyWith<$Res>? get categoryCoding;
  $CodingCopyWith<$Res>? get focusCoding;
  $ReferenceCopyWith<$Res>? get protocolReference;
  $ReferenceCopyWith<$Res>? get partOfReference;
  $ResearchStudyPeriodCopyWith<$Res>? get period;
  $ReferenceCopyWith<$Res>? get sponsorReference;
  $ReferenceCopyWith<$Res>? get principalInvestigatorReference;
}

/// @nodoc
class _$ResearchStudyCopyWithImpl<$Res, $Val extends ResearchStudy>
    implements $ResearchStudyCopyWith<$Res> {
  _$ResearchStudyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? categoryCoding = freezed,
    Object? focusCoding = freezed,
    Object? protocolReference = freezed,
    Object? partOfReference = freezed,
    Object? contacts = freezed,
    Object? keywordConcepts = freezed,
    Object? period = freezed,
    Object? enrollmentReferences = freezed,
    Object? sponsorReference = freezed,
    Object? principalInvestigatorReference = freezed,
    Object? siteReferences = freezed,
    Object? comments = freezed,
    Object? description = freezed,
    Object? arms = freezed,
    Object? location = freezed,
    Object? primaryPurposeType = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryCoding: freezed == categoryCoding
          ? _value.categoryCoding
          : categoryCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      focusCoding: freezed == focusCoding
          ? _value.focusCoding
          : focusCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      protocolReference: freezed == protocolReference
          ? _value.protocolReference
          : protocolReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      partOfReference: freezed == partOfReference
          ? _value.partOfReference
          : partOfReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      contacts: freezed == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ResearchStudyContact>?,
      keywordConcepts: freezed == keywordConcepts
          ? _value.keywordConcepts
          : keywordConcepts // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as ResearchStudyPeriod?,
      enrollmentReferences: freezed == enrollmentReferences
          ? _value.enrollmentReferences
          : enrollmentReferences // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      sponsorReference: freezed == sponsorReference
          ? _value.sponsorReference
          : sponsorReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      principalInvestigatorReference: freezed == principalInvestigatorReference
          ? _value.principalInvestigatorReference
          : principalInvestigatorReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      siteReferences: freezed == siteReferences
          ? _value.siteReferences
          : siteReferences // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arms: freezed == arms
          ? _value.arms
          : arms // ignore: cast_nullable_to_non_nullable
              as List<ResearchStudyArm>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryPurposeType: freezed == primaryPurposeType
          ? _value.primaryPurposeType
          : primaryPurposeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get categoryCoding {
    if (_value.categoryCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.categoryCoding!, (value) {
      return _then(_value.copyWith(categoryCoding: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get focusCoding {
    if (_value.focusCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.focusCoding!, (value) {
      return _then(_value.copyWith(focusCoding: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get protocolReference {
    if (_value.protocolReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.protocolReference!, (value) {
      return _then(_value.copyWith(protocolReference: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get partOfReference {
    if (_value.partOfReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.partOfReference!, (value) {
      return _then(_value.copyWith(partOfReference: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResearchStudyPeriodCopyWith<$Res>? get period {
    if (_value.period == null) {
      return null;
    }

    return $ResearchStudyPeriodCopyWith<$Res>(_value.period!, (value) {
      return _then(_value.copyWith(period: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get sponsorReference {
    if (_value.sponsorReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.sponsorReference!, (value) {
      return _then(_value.copyWith(sponsorReference: value) as $Val);
    });
  }

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get principalInvestigatorReference {
    if (_value.principalInvestigatorReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.principalInvestigatorReference!,
        (value) {
      return _then(
          _value.copyWith(principalInvestigatorReference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResearchStudyImplCopyWith<$Res>
    implements $ResearchStudyCopyWith<$Res> {
  factory _$$ResearchStudyImplCopyWith(
          _$ResearchStudyImpl value, $Res Function(_$ResearchStudyImpl) then) =
      __$$ResearchStudyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'category_coding') Coding? categoryCoding,
      @JsonKey(name: 'focus_coding') Coding? focusCoding,
      @JsonKey(name: 'protocol_reference') Reference? protocolReference,
      @JsonKey(name: 'part_of_reference') Reference? partOfReference,
      List<ResearchStudyContact>? contacts,
      @JsonKey(name: 'keyword_concepts') List<CodeableConcept>? keywordConcepts,
      ResearchStudyPeriod? period,
      @JsonKey(name: 'enrollment_references')
      List<Reference>? enrollmentReferences,
      @JsonKey(name: 'sponsor_reference') Reference? sponsorReference,
      @JsonKey(name: 'principal_investigator_reference')
      Reference? principalInvestigatorReference,
      @JsonKey(name: 'site_references') List<Reference>? siteReferences,
      List<String>? comments,
      String? description,
      List<ResearchStudyArm>? arms,
      String? location,
      @JsonKey(name: 'primary_purpose_type') String? primaryPurposeType});

  @override
  $CodingCopyWith<$Res>? get categoryCoding;
  @override
  $CodingCopyWith<$Res>? get focusCoding;
  @override
  $ReferenceCopyWith<$Res>? get protocolReference;
  @override
  $ReferenceCopyWith<$Res>? get partOfReference;
  @override
  $ResearchStudyPeriodCopyWith<$Res>? get period;
  @override
  $ReferenceCopyWith<$Res>? get sponsorReference;
  @override
  $ReferenceCopyWith<$Res>? get principalInvestigatorReference;
}

/// @nodoc
class __$$ResearchStudyImplCopyWithImpl<$Res>
    extends _$ResearchStudyCopyWithImpl<$Res, _$ResearchStudyImpl>
    implements _$$ResearchStudyImplCopyWith<$Res> {
  __$$ResearchStudyImplCopyWithImpl(
      _$ResearchStudyImpl _value, $Res Function(_$ResearchStudyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? categoryCoding = freezed,
    Object? focusCoding = freezed,
    Object? protocolReference = freezed,
    Object? partOfReference = freezed,
    Object? contacts = freezed,
    Object? keywordConcepts = freezed,
    Object? period = freezed,
    Object? enrollmentReferences = freezed,
    Object? sponsorReference = freezed,
    Object? principalInvestigatorReference = freezed,
    Object? siteReferences = freezed,
    Object? comments = freezed,
    Object? description = freezed,
    Object? arms = freezed,
    Object? location = freezed,
    Object? primaryPurposeType = freezed,
  }) {
    return _then(_$ResearchStudyImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryCoding: freezed == categoryCoding
          ? _value.categoryCoding
          : categoryCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      focusCoding: freezed == focusCoding
          ? _value.focusCoding
          : focusCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      protocolReference: freezed == protocolReference
          ? _value.protocolReference
          : protocolReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      partOfReference: freezed == partOfReference
          ? _value.partOfReference
          : partOfReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      contacts: freezed == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ResearchStudyContact>?,
      keywordConcepts: freezed == keywordConcepts
          ? _value._keywordConcepts
          : keywordConcepts // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as ResearchStudyPeriod?,
      enrollmentReferences: freezed == enrollmentReferences
          ? _value._enrollmentReferences
          : enrollmentReferences // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      sponsorReference: freezed == sponsorReference
          ? _value.sponsorReference
          : sponsorReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      principalInvestigatorReference: freezed == principalInvestigatorReference
          ? _value.principalInvestigatorReference
          : principalInvestigatorReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      siteReferences: freezed == siteReferences
          ? _value._siteReferences
          : siteReferences // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arms: freezed == arms
          ? _value._arms
          : arms // ignore: cast_nullable_to_non_nullable
              as List<ResearchStudyArm>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryPurposeType: freezed == primaryPurposeType
          ? _value.primaryPurposeType
          : primaryPurposeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchStudyImpl implements _ResearchStudy {
  _$ResearchStudyImpl(
      {this.id,
      this.title,
      this.status,
      @JsonKey(name: 'category_coding') this.categoryCoding,
      @JsonKey(name: 'focus_coding') this.focusCoding,
      @JsonKey(name: 'protocol_reference') this.protocolReference,
      @JsonKey(name: 'part_of_reference') this.partOfReference,
      final List<ResearchStudyContact>? contacts,
      @JsonKey(name: 'keyword_concepts')
      final List<CodeableConcept>? keywordConcepts,
      this.period,
      @JsonKey(name: 'enrollment_references')
      final List<Reference>? enrollmentReferences,
      @JsonKey(name: 'sponsor_reference') this.sponsorReference,
      @JsonKey(name: 'principal_investigator_reference')
      this.principalInvestigatorReference,
      @JsonKey(name: 'site_references') final List<Reference>? siteReferences,
      final List<String>? comments,
      this.description,
      final List<ResearchStudyArm>? arms,
      this.location,
      @JsonKey(name: 'primary_purpose_type') this.primaryPurposeType})
      : _contacts = contacts,
        _keywordConcepts = keywordConcepts,
        _enrollmentReferences = enrollmentReferences,
        _siteReferences = siteReferences,
        _comments = comments,
        _arms = arms;

  factory _$ResearchStudyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchStudyImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? status;
  @override
  @JsonKey(name: 'category_coding')
  final Coding? categoryCoding;
  @override
  @JsonKey(name: 'focus_coding')
  final Coding? focusCoding;
  @override
  @JsonKey(name: 'protocol_reference')
  final Reference? protocolReference;
  @override
  @JsonKey(name: 'part_of_reference')
  final Reference? partOfReference;
  final List<ResearchStudyContact>? _contacts;
  @override
  List<ResearchStudyContact>? get contacts {
    final value = _contacts;
    if (value == null) return null;
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _keywordConcepts;
  @override
  @JsonKey(name: 'keyword_concepts')
  List<CodeableConcept>? get keywordConcepts {
    final value = _keywordConcepts;
    if (value == null) return null;
    if (_keywordConcepts is EqualUnmodifiableListView) return _keywordConcepts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ResearchStudyPeriod? period;
  final List<Reference>? _enrollmentReferences;
  @override
  @JsonKey(name: 'enrollment_references')
  List<Reference>? get enrollmentReferences {
    final value = _enrollmentReferences;
    if (value == null) return null;
    if (_enrollmentReferences is EqualUnmodifiableListView)
      return _enrollmentReferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'sponsor_reference')
  final Reference? sponsorReference;
  @override
  @JsonKey(name: 'principal_investigator_reference')
  final Reference? principalInvestigatorReference;
  final List<Reference>? _siteReferences;
  @override
  @JsonKey(name: 'site_references')
  List<Reference>? get siteReferences {
    final value = _siteReferences;
    if (value == null) return null;
    if (_siteReferences is EqualUnmodifiableListView) return _siteReferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _comments;
  @override
  List<String>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? description;
  final List<ResearchStudyArm>? _arms;
  @override
  List<ResearchStudyArm>? get arms {
    final value = _arms;
    if (value == null) return null;
    if (_arms is EqualUnmodifiableListView) return _arms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? location;
  @override
  @JsonKey(name: 'primary_purpose_type')
  final String? primaryPurposeType;

  @override
  String toString() {
    return 'ResearchStudy(id: $id, title: $title, status: $status, categoryCoding: $categoryCoding, focusCoding: $focusCoding, protocolReference: $protocolReference, partOfReference: $partOfReference, contacts: $contacts, keywordConcepts: $keywordConcepts, period: $period, enrollmentReferences: $enrollmentReferences, sponsorReference: $sponsorReference, principalInvestigatorReference: $principalInvestigatorReference, siteReferences: $siteReferences, comments: $comments, description: $description, arms: $arms, location: $location, primaryPurposeType: $primaryPurposeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchStudyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.categoryCoding, categoryCoding) ||
                other.categoryCoding == categoryCoding) &&
            (identical(other.focusCoding, focusCoding) ||
                other.focusCoding == focusCoding) &&
            (identical(other.protocolReference, protocolReference) ||
                other.protocolReference == protocolReference) &&
            (identical(other.partOfReference, partOfReference) ||
                other.partOfReference == partOfReference) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            const DeepCollectionEquality()
                .equals(other._keywordConcepts, _keywordConcepts) &&
            (identical(other.period, period) || other.period == period) &&
            const DeepCollectionEquality()
                .equals(other._enrollmentReferences, _enrollmentReferences) &&
            (identical(other.sponsorReference, sponsorReference) ||
                other.sponsorReference == sponsorReference) &&
            (identical(other.principalInvestigatorReference,
                    principalInvestigatorReference) ||
                other.principalInvestigatorReference ==
                    principalInvestigatorReference) &&
            const DeepCollectionEquality()
                .equals(other._siteReferences, _siteReferences) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._arms, _arms) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.primaryPurposeType, primaryPurposeType) ||
                other.primaryPurposeType == primaryPurposeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        status,
        categoryCoding,
        focusCoding,
        protocolReference,
        partOfReference,
        const DeepCollectionEquality().hash(_contacts),
        const DeepCollectionEquality().hash(_keywordConcepts),
        period,
        const DeepCollectionEquality().hash(_enrollmentReferences),
        sponsorReference,
        principalInvestigatorReference,
        const DeepCollectionEquality().hash(_siteReferences),
        const DeepCollectionEquality().hash(_comments),
        description,
        const DeepCollectionEquality().hash(_arms),
        location,
        primaryPurposeType
      ]);

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchStudyImplCopyWith<_$ResearchStudyImpl> get copyWith =>
      __$$ResearchStudyImplCopyWithImpl<_$ResearchStudyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchStudyImplToJson(
      this,
    );
  }
}

abstract class _ResearchStudy implements ResearchStudy {
  factory _ResearchStudy(
      {final String? id,
      final String? title,
      final String? status,
      @JsonKey(name: 'category_coding') final Coding? categoryCoding,
      @JsonKey(name: 'focus_coding') final Coding? focusCoding,
      @JsonKey(name: 'protocol_reference') final Reference? protocolReference,
      @JsonKey(name: 'part_of_reference') final Reference? partOfReference,
      final List<ResearchStudyContact>? contacts,
      @JsonKey(name: 'keyword_concepts')
      final List<CodeableConcept>? keywordConcepts,
      final ResearchStudyPeriod? period,
      @JsonKey(name: 'enrollment_references')
      final List<Reference>? enrollmentReferences,
      @JsonKey(name: 'sponsor_reference') final Reference? sponsorReference,
      @JsonKey(name: 'principal_investigator_reference')
      final Reference? principalInvestigatorReference,
      @JsonKey(name: 'site_references') final List<Reference>? siteReferences,
      final List<String>? comments,
      final String? description,
      final List<ResearchStudyArm>? arms,
      final String? location,
      @JsonKey(name: 'primary_purpose_type')
      final String? primaryPurposeType}) = _$ResearchStudyImpl;

  factory _ResearchStudy.fromJson(Map<String, dynamic> json) =
      _$ResearchStudyImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get status;
  @override
  @JsonKey(name: 'category_coding')
  Coding? get categoryCoding;
  @override
  @JsonKey(name: 'focus_coding')
  Coding? get focusCoding;
  @override
  @JsonKey(name: 'protocol_reference')
  Reference? get protocolReference;
  @override
  @JsonKey(name: 'part_of_reference')
  Reference? get partOfReference;
  @override
  List<ResearchStudyContact>? get contacts;
  @override
  @JsonKey(name: 'keyword_concepts')
  List<CodeableConcept>? get keywordConcepts;
  @override
  ResearchStudyPeriod? get period;
  @override
  @JsonKey(name: 'enrollment_references')
  List<Reference>? get enrollmentReferences;
  @override
  @JsonKey(name: 'sponsor_reference')
  Reference? get sponsorReference;
  @override
  @JsonKey(name: 'principal_investigator_reference')
  Reference? get principalInvestigatorReference;
  @override
  @JsonKey(name: 'site_references')
  List<Reference>? get siteReferences;
  @override
  List<String>? get comments;
  @override
  String? get description;
  @override
  List<ResearchStudyArm>? get arms;
  @override
  String? get location;
  @override
  @JsonKey(name: 'primary_purpose_type')
  String? get primaryPurposeType;

  /// Create a copy of ResearchStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchStudyImplCopyWith<_$ResearchStudyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResearchStudyContact _$ResearchStudyContactFromJson(Map<String, dynamic> json) {
  return _ResearchStudyContact.fromJson(json);
}

/// @nodoc
mixin _$ResearchStudyContact {
  String? get name => throw _privateConstructorUsedError;
  List<Telecom>? get telecoms => throw _privateConstructorUsedError;

  /// Serializes this ResearchStudyContact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchStudyContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchStudyContactCopyWith<ResearchStudyContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchStudyContactCopyWith<$Res> {
  factory $ResearchStudyContactCopyWith(ResearchStudyContact value,
          $Res Function(ResearchStudyContact) then) =
      _$ResearchStudyContactCopyWithImpl<$Res, ResearchStudyContact>;
  @useResult
  $Res call({String? name, List<Telecom>? telecoms});
}

/// @nodoc
class _$ResearchStudyContactCopyWithImpl<$Res,
        $Val extends ResearchStudyContact>
    implements $ResearchStudyContactCopyWith<$Res> {
  _$ResearchStudyContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchStudyContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? telecoms = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      telecoms: freezed == telecoms
          ? _value.telecoms
          : telecoms // ignore: cast_nullable_to_non_nullable
              as List<Telecom>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResearchStudyContactImplCopyWith<$Res>
    implements $ResearchStudyContactCopyWith<$Res> {
  factory _$$ResearchStudyContactImplCopyWith(_$ResearchStudyContactImpl value,
          $Res Function(_$ResearchStudyContactImpl) then) =
      __$$ResearchStudyContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, List<Telecom>? telecoms});
}

/// @nodoc
class __$$ResearchStudyContactImplCopyWithImpl<$Res>
    extends _$ResearchStudyContactCopyWithImpl<$Res, _$ResearchStudyContactImpl>
    implements _$$ResearchStudyContactImplCopyWith<$Res> {
  __$$ResearchStudyContactImplCopyWithImpl(_$ResearchStudyContactImpl _value,
      $Res Function(_$ResearchStudyContactImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchStudyContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? telecoms = freezed,
  }) {
    return _then(_$ResearchStudyContactImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      telecoms: freezed == telecoms
          ? _value._telecoms
          : telecoms // ignore: cast_nullable_to_non_nullable
              as List<Telecom>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchStudyContactImpl implements _ResearchStudyContact {
  _$ResearchStudyContactImpl({this.name, final List<Telecom>? telecoms})
      : _telecoms = telecoms;

  factory _$ResearchStudyContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchStudyContactImplFromJson(json);

  @override
  final String? name;
  final List<Telecom>? _telecoms;
  @override
  List<Telecom>? get telecoms {
    final value = _telecoms;
    if (value == null) return null;
    if (_telecoms is EqualUnmodifiableListView) return _telecoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ResearchStudyContact(name: $name, telecoms: $telecoms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchStudyContactImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._telecoms, _telecoms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_telecoms));

  /// Create a copy of ResearchStudyContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchStudyContactImplCopyWith<_$ResearchStudyContactImpl>
      get copyWith =>
          __$$ResearchStudyContactImplCopyWithImpl<_$ResearchStudyContactImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchStudyContactImplToJson(
      this,
    );
  }
}

abstract class _ResearchStudyContact implements ResearchStudyContact {
  factory _ResearchStudyContact(
      {final String? name,
      final List<Telecom>? telecoms}) = _$ResearchStudyContactImpl;

  factory _ResearchStudyContact.fromJson(Map<String, dynamic> json) =
      _$ResearchStudyContactImpl.fromJson;

  @override
  String? get name;
  @override
  List<Telecom>? get telecoms;

  /// Create a copy of ResearchStudyContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchStudyContactImplCopyWith<_$ResearchStudyContactImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResearchStudyPeriod _$ResearchStudyPeriodFromJson(Map<String, dynamic> json) {
  return _ResearchStudyPeriod.fromJson(json);
}

/// @nodoc
mixin _$ResearchStudyPeriod {
  String? get start => throw _privateConstructorUsedError;
  String? get end => throw _privateConstructorUsedError;

  /// Serializes this ResearchStudyPeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchStudyPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchStudyPeriodCopyWith<ResearchStudyPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchStudyPeriodCopyWith<$Res> {
  factory $ResearchStudyPeriodCopyWith(
          ResearchStudyPeriod value, $Res Function(ResearchStudyPeriod) then) =
      _$ResearchStudyPeriodCopyWithImpl<$Res, ResearchStudyPeriod>;
  @useResult
  $Res call({String? start, String? end});
}

/// @nodoc
class _$ResearchStudyPeriodCopyWithImpl<$Res, $Val extends ResearchStudyPeriod>
    implements $ResearchStudyPeriodCopyWith<$Res> {
  _$ResearchStudyPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchStudyPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResearchStudyPeriodImplCopyWith<$Res>
    implements $ResearchStudyPeriodCopyWith<$Res> {
  factory _$$ResearchStudyPeriodImplCopyWith(_$ResearchStudyPeriodImpl value,
          $Res Function(_$ResearchStudyPeriodImpl) then) =
      __$$ResearchStudyPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? start, String? end});
}

/// @nodoc
class __$$ResearchStudyPeriodImplCopyWithImpl<$Res>
    extends _$ResearchStudyPeriodCopyWithImpl<$Res, _$ResearchStudyPeriodImpl>
    implements _$$ResearchStudyPeriodImplCopyWith<$Res> {
  __$$ResearchStudyPeriodImplCopyWithImpl(_$ResearchStudyPeriodImpl _value,
      $Res Function(_$ResearchStudyPeriodImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchStudyPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$ResearchStudyPeriodImpl(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchStudyPeriodImpl implements _ResearchStudyPeriod {
  _$ResearchStudyPeriodImpl({this.start, this.end});

  factory _$ResearchStudyPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchStudyPeriodImplFromJson(json);

  @override
  final String? start;
  @override
  final String? end;

  @override
  String toString() {
    return 'ResearchStudyPeriod(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchStudyPeriodImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of ResearchStudyPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchStudyPeriodImplCopyWith<_$ResearchStudyPeriodImpl> get copyWith =>
      __$$ResearchStudyPeriodImplCopyWithImpl<_$ResearchStudyPeriodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchStudyPeriodImplToJson(
      this,
    );
  }
}

abstract class _ResearchStudyPeriod implements ResearchStudyPeriod {
  factory _ResearchStudyPeriod({final String? start, final String? end}) =
      _$ResearchStudyPeriodImpl;

  factory _ResearchStudyPeriod.fromJson(Map<String, dynamic> json) =
      _$ResearchStudyPeriodImpl.fromJson;

  @override
  String? get start;
  @override
  String? get end;

  /// Create a copy of ResearchStudyPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchStudyPeriodImplCopyWith<_$ResearchStudyPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResearchStudyArm _$ResearchStudyArmFromJson(Map<String, dynamic> json) {
  return _ResearchStudyArm.fromJson(json);
}

/// @nodoc
mixin _$ResearchStudyArm {
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Coding? get coding => throw _privateConstructorUsedError;

  /// Serializes this ResearchStudyArm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResearchStudyArmCopyWith<ResearchStudyArm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResearchStudyArmCopyWith<$Res> {
  factory $ResearchStudyArmCopyWith(
          ResearchStudyArm value, $Res Function(ResearchStudyArm) then) =
      _$ResearchStudyArmCopyWithImpl<$Res, ResearchStudyArm>;
  @useResult
  $Res call({String? name, String? description, Coding? coding});

  $CodingCopyWith<$Res>? get coding;
}

/// @nodoc
class _$ResearchStudyArmCopyWithImpl<$Res, $Val extends ResearchStudyArm>
    implements $ResearchStudyArmCopyWith<$Res> {
  _$ResearchStudyArmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? coding = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coding: freezed == coding
          ? _value.coding
          : coding // ignore: cast_nullable_to_non_nullable
              as Coding?,
    ) as $Val);
  }

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get coding {
    if (_value.coding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.coding!, (value) {
      return _then(_value.copyWith(coding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResearchStudyArmImplCopyWith<$Res>
    implements $ResearchStudyArmCopyWith<$Res> {
  factory _$$ResearchStudyArmImplCopyWith(_$ResearchStudyArmImpl value,
          $Res Function(_$ResearchStudyArmImpl) then) =
      __$$ResearchStudyArmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? description, Coding? coding});

  @override
  $CodingCopyWith<$Res>? get coding;
}

/// @nodoc
class __$$ResearchStudyArmImplCopyWithImpl<$Res>
    extends _$ResearchStudyArmCopyWithImpl<$Res, _$ResearchStudyArmImpl>
    implements _$$ResearchStudyArmImplCopyWith<$Res> {
  __$$ResearchStudyArmImplCopyWithImpl(_$ResearchStudyArmImpl _value,
      $Res Function(_$ResearchStudyArmImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? coding = freezed,
  }) {
    return _then(_$ResearchStudyArmImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coding: freezed == coding
          ? _value.coding
          : coding // ignore: cast_nullable_to_non_nullable
              as Coding?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResearchStudyArmImpl implements _ResearchStudyArm {
  _$ResearchStudyArmImpl({this.name, this.description, this.coding});

  factory _$ResearchStudyArmImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResearchStudyArmImplFromJson(json);

  @override
  final String? name;
  @override
  final String? description;
  @override
  final Coding? coding;

  @override
  String toString() {
    return 'ResearchStudyArm(name: $name, description: $description, coding: $coding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResearchStudyArmImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coding, coding) || other.coding == coding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, coding);

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResearchStudyArmImplCopyWith<_$ResearchStudyArmImpl> get copyWith =>
      __$$ResearchStudyArmImplCopyWithImpl<_$ResearchStudyArmImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResearchStudyArmImplToJson(
      this,
    );
  }
}

abstract class _ResearchStudyArm implements ResearchStudyArm {
  factory _ResearchStudyArm(
      {final String? name,
      final String? description,
      final Coding? coding}) = _$ResearchStudyArmImpl;

  factory _ResearchStudyArm.fromJson(Map<String, dynamic> json) =
      _$ResearchStudyArmImpl.fromJson;

  @override
  String? get name;
  @override
  String? get description;
  @override
  Coding? get coding;

  /// Create a copy of ResearchStudyArm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResearchStudyArmImplCopyWith<_$ResearchStudyArmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
