// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CarePlan _$CarePlanFromJson(Map<String, dynamic> json) {
  return _CarePlan.fromJson(json);
}

/// @nodoc
mixin _$CarePlan {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get expiry => throw _privateConstructorUsedError;
  List<CodeableConcept>? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_category')
  bool? get hasCategory => throw _privateConstructorUsedError;
  List<Reference>? get goals => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_goals')
  bool? get hasGoals => throw _privateConstructorUsedError;
  List<Reference>? get addresses => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_addresses')
  bool? get hasAddresses => throw _privateConstructorUsedError;
  bool? get hasActivity => throw _privateConstructorUsedError;
  String? get basedOn => throw _privateConstructorUsedError;
  String? get partOf => throw _privateConstructorUsedError;
  String? get intent => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Reference? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_start')
  String? get periodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_end')
  String? get periodEnd => throw _privateConstructorUsedError;
  Reference? get author => throw _privateConstructorUsedError;

  /// Serializes this CarePlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarePlanCopyWith<CarePlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarePlanCopyWith<$Res> {
  factory $CarePlanCopyWith(CarePlan value, $Res Function(CarePlan) then) =
      _$CarePlanCopyWithImpl<$Res, CarePlan>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? status,
      String? expiry,
      List<CodeableConcept>? category,
      @JsonKey(name: 'has_category') bool? hasCategory,
      List<Reference>? goals,
      @JsonKey(name: 'has_goals') bool? hasGoals,
      List<Reference>? addresses,
      @JsonKey(name: 'has_addresses') bool? hasAddresses,
      bool? hasActivity,
      String? basedOn,
      String? partOf,
      String? intent,
      String? description,
      Reference? subject,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'period_end') String? periodEnd,
      Reference? author});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get subject;
  $ReferenceCopyWith<$Res>? get author;
}

/// @nodoc
class _$CarePlanCopyWithImpl<$Res, $Val extends CarePlan>
    implements $CarePlanCopyWith<$Res> {
  _$CarePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? status = freezed,
    Object? expiry = freezed,
    Object? category = freezed,
    Object? hasCategory = freezed,
    Object? goals = freezed,
    Object? hasGoals = freezed,
    Object? addresses = freezed,
    Object? hasAddresses = freezed,
    Object? hasActivity = freezed,
    Object? basedOn = freezed,
    Object? partOf = freezed,
    Object? intent = freezed,
    Object? description = freezed,
    Object? subject = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
    Object? author = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      hasCategory: freezed == hasCategory
          ? _value.hasCategory
          : hasCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      goals: freezed == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      hasGoals: freezed == hasGoals
          ? _value.hasGoals
          : hasGoals // ignore: cast_nullable_to_non_nullable
              as bool?,
      addresses: freezed == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      hasAddresses: freezed == hasAddresses
          ? _value.hasAddresses
          : hasAddresses // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasActivity: freezed == hasActivity
          ? _value.hasActivity
          : hasActivity // ignore: cast_nullable_to_non_nullable
              as bool?,
      basedOn: freezed == basedOn
          ? _value.basedOn
          : basedOn // ignore: cast_nullable_to_non_nullable
              as String?,
      partOf: freezed == partOf
          ? _value.partOf
          : partOf // ignore: cast_nullable_to_non_nullable
              as String?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of CarePlan
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

  /// Create a copy of CarePlan
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

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CarePlanImplCopyWith<$Res>
    implements $CarePlanCopyWith<$Res> {
  factory _$$CarePlanImplCopyWith(
          _$CarePlanImpl value, $Res Function(_$CarePlanImpl) then) =
      __$$CarePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? status,
      String? expiry,
      List<CodeableConcept>? category,
      @JsonKey(name: 'has_category') bool? hasCategory,
      List<Reference>? goals,
      @JsonKey(name: 'has_goals') bool? hasGoals,
      List<Reference>? addresses,
      @JsonKey(name: 'has_addresses') bool? hasAddresses,
      bool? hasActivity,
      String? basedOn,
      String? partOf,
      String? intent,
      String? description,
      Reference? subject,
      @JsonKey(name: 'period_start') String? periodStart,
      @JsonKey(name: 'period_end') String? periodEnd,
      Reference? author});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get subject;
  @override
  $ReferenceCopyWith<$Res>? get author;
}

/// @nodoc
class __$$CarePlanImplCopyWithImpl<$Res>
    extends _$CarePlanCopyWithImpl<$Res, _$CarePlanImpl>
    implements _$$CarePlanImplCopyWith<$Res> {
  __$$CarePlanImplCopyWithImpl(
      _$CarePlanImpl _value, $Res Function(_$CarePlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? status = freezed,
    Object? expiry = freezed,
    Object? category = freezed,
    Object? hasCategory = freezed,
    Object? goals = freezed,
    Object? hasGoals = freezed,
    Object? addresses = freezed,
    Object? hasAddresses = freezed,
    Object? hasActivity = freezed,
    Object? basedOn = freezed,
    Object? partOf = freezed,
    Object? intent = freezed,
    Object? description = freezed,
    Object? subject = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
    Object? author = freezed,
  }) {
    return _then(_$CarePlanImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      hasCategory: freezed == hasCategory
          ? _value.hasCategory
          : hasCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      goals: freezed == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      hasGoals: freezed == hasGoals
          ? _value.hasGoals
          : hasGoals // ignore: cast_nullable_to_non_nullable
              as bool?,
      addresses: freezed == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      hasAddresses: freezed == hasAddresses
          ? _value.hasAddresses
          : hasAddresses // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasActivity: freezed == hasActivity
          ? _value.hasActivity
          : hasActivity // ignore: cast_nullable_to_non_nullable
              as bool?,
      basedOn: freezed == basedOn
          ? _value.basedOn
          : basedOn // ignore: cast_nullable_to_non_nullable
              as String?,
      partOf: freezed == partOf
          ? _value.partOf
          : partOf // ignore: cast_nullable_to_non_nullable
              as String?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      periodStart: freezed == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as String?,
      periodEnd: freezed == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarePlanImpl implements _CarePlan {
  _$CarePlanImpl(
      {this.id,
      this.code,
      this.status,
      this.expiry,
      final List<CodeableConcept>? category,
      @JsonKey(name: 'has_category') this.hasCategory,
      final List<Reference>? goals,
      @JsonKey(name: 'has_goals') this.hasGoals,
      final List<Reference>? addresses,
      @JsonKey(name: 'has_addresses') this.hasAddresses,
      this.hasActivity,
      this.basedOn,
      this.partOf,
      this.intent,
      this.description,
      this.subject,
      @JsonKey(name: 'period_start') this.periodStart,
      @JsonKey(name: 'period_end') this.periodEnd,
      this.author})
      : _category = category,
        _goals = goals,
        _addresses = addresses;

  factory _$CarePlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarePlanImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final String? status;
  @override
  final String? expiry;
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
  @JsonKey(name: 'has_category')
  final bool? hasCategory;
  final List<Reference>? _goals;
  @override
  List<Reference>? get goals {
    final value = _goals;
    if (value == null) return null;
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_goals')
  final bool? hasGoals;
  final List<Reference>? _addresses;
  @override
  List<Reference>? get addresses {
    final value = _addresses;
    if (value == null) return null;
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_addresses')
  final bool? hasAddresses;
  @override
  final bool? hasActivity;
  @override
  final String? basedOn;
  @override
  final String? partOf;
  @override
  final String? intent;
  @override
  final String? description;
  @override
  final Reference? subject;
  @override
  @JsonKey(name: 'period_start')
  final String? periodStart;
  @override
  @JsonKey(name: 'period_end')
  final String? periodEnd;
  @override
  final Reference? author;

  @override
  String toString() {
    return 'CarePlan(id: $id, code: $code, status: $status, expiry: $expiry, category: $category, hasCategory: $hasCategory, goals: $goals, hasGoals: $hasGoals, addresses: $addresses, hasAddresses: $hasAddresses, hasActivity: $hasActivity, basedOn: $basedOn, partOf: $partOf, intent: $intent, description: $description, subject: $subject, periodStart: $periodStart, periodEnd: $periodEnd, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarePlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.hasCategory, hasCategory) ||
                other.hasCategory == hasCategory) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            (identical(other.hasGoals, hasGoals) ||
                other.hasGoals == hasGoals) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            (identical(other.hasAddresses, hasAddresses) ||
                other.hasAddresses == hasAddresses) &&
            (identical(other.hasActivity, hasActivity) ||
                other.hasActivity == hasActivity) &&
            (identical(other.basedOn, basedOn) || other.basedOn == basedOn) &&
            (identical(other.partOf, partOf) || other.partOf == partOf) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        code,
        status,
        expiry,
        const DeepCollectionEquality().hash(_category),
        hasCategory,
        const DeepCollectionEquality().hash(_goals),
        hasGoals,
        const DeepCollectionEquality().hash(_addresses),
        hasAddresses,
        hasActivity,
        basedOn,
        partOf,
        intent,
        description,
        subject,
        periodStart,
        periodEnd,
        author
      ]);

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarePlanImplCopyWith<_$CarePlanImpl> get copyWith =>
      __$$CarePlanImplCopyWithImpl<_$CarePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarePlanImplToJson(
      this,
    );
  }
}

abstract class _CarePlan implements CarePlan {
  factory _CarePlan(
      {final String? id,
      final CodeableConcept? code,
      final String? status,
      final String? expiry,
      final List<CodeableConcept>? category,
      @JsonKey(name: 'has_category') final bool? hasCategory,
      final List<Reference>? goals,
      @JsonKey(name: 'has_goals') final bool? hasGoals,
      final List<Reference>? addresses,
      @JsonKey(name: 'has_addresses') final bool? hasAddresses,
      final bool? hasActivity,
      final String? basedOn,
      final String? partOf,
      final String? intent,
      final String? description,
      final Reference? subject,
      @JsonKey(name: 'period_start') final String? periodStart,
      @JsonKey(name: 'period_end') final String? periodEnd,
      final Reference? author}) = _$CarePlanImpl;

  factory _CarePlan.fromJson(Map<String, dynamic> json) =
      _$CarePlanImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  String? get status;
  @override
  String? get expiry;
  @override
  List<CodeableConcept>? get category;
  @override
  @JsonKey(name: 'has_category')
  bool? get hasCategory;
  @override
  List<Reference>? get goals;
  @override
  @JsonKey(name: 'has_goals')
  bool? get hasGoals;
  @override
  List<Reference>? get addresses;
  @override
  @JsonKey(name: 'has_addresses')
  bool? get hasAddresses;
  @override
  bool? get hasActivity;
  @override
  String? get basedOn;
  @override
  String? get partOf;
  @override
  String? get intent;
  @override
  String? get description;
  @override
  Reference? get subject;
  @override
  @JsonKey(name: 'period_start')
  String? get periodStart;
  @override
  @JsonKey(name: 'period_end')
  String? get periodEnd;
  @override
  Reference? get author;

  /// Create a copy of CarePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarePlanImplCopyWith<_$CarePlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
