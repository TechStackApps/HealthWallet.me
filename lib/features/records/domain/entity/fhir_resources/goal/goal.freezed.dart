// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_status')
  bool? get hasStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_category')
  bool? get hasCategory => throw _privateConstructorUsedError;
  List<CodeableConcept>? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_udi')
  bool? get hasUdi => throw _privateConstructorUsedError;
  String? get udi => throw _privateConstructorUsedError;
  bool? get hasAddresses => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_reference')
  String? get outcomeReference => throw _privateConstructorUsedError;
  @JsonKey(name: 'achievement_status')
  Coding? get achievementStatus => throw _privateConstructorUsedError;
  Coding? get priority => throw _privateConstructorUsedError;
  Reference? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_date')
  String? get statusDate => throw _privateConstructorUsedError;

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'has_status') bool? hasStatus,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'has_category') bool? hasCategory,
      List<CodeableConcept>? category,
      @JsonKey(name: 'has_udi') bool? hasUdi,
      String? udi,
      bool? hasAddresses,
      String? author,
      String? description,
      @JsonKey(name: 'outcome_reference') String? outcomeReference,
      @JsonKey(name: 'achievement_status') Coding? achievementStatus,
      Coding? priority,
      Reference? subject,
      @JsonKey(name: 'status_date') String? statusDate});

  $CodingCopyWith<$Res>? get achievementStatus;
  $CodingCopyWith<$Res>? get priority;
  $ReferenceCopyWith<$Res>? get subject;
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? hasStatus = freezed,
    Object? startDate = freezed,
    Object? hasCategory = freezed,
    Object? category = freezed,
    Object? hasUdi = freezed,
    Object? udi = freezed,
    Object? hasAddresses = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? outcomeReference = freezed,
    Object? achievementStatus = freezed,
    Object? priority = freezed,
    Object? subject = freezed,
    Object? statusDate = freezed,
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
      hasStatus: freezed == hasStatus
          ? _value.hasStatus
          : hasStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      hasCategory: freezed == hasCategory
          ? _value.hasCategory
          : hasCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      hasUdi: freezed == hasUdi
          ? _value.hasUdi
          : hasUdi // ignore: cast_nullable_to_non_nullable
              as bool?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAddresses: freezed == hasAddresses
          ? _value.hasAddresses
          : hasAddresses // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      outcomeReference: freezed == outcomeReference
          ? _value.outcomeReference
          : outcomeReference // ignore: cast_nullable_to_non_nullable
              as String?,
      achievementStatus: freezed == achievementStatus
          ? _value.achievementStatus
          : achievementStatus // ignore: cast_nullable_to_non_nullable
              as Coding?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Coding?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      statusDate: freezed == statusDate
          ? _value.statusDate
          : statusDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get achievementStatus {
    if (_value.achievementStatus == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.achievementStatus!, (value) {
      return _then(_value.copyWith(achievementStatus: value) as $Val);
    });
  }

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get priority {
    if (_value.priority == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.priority!, (value) {
      return _then(_value.copyWith(priority: value) as $Val);
    });
  }

  /// Create a copy of Goal
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
}

/// @nodoc
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'has_status') bool? hasStatus,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'has_category') bool? hasCategory,
      List<CodeableConcept>? category,
      @JsonKey(name: 'has_udi') bool? hasUdi,
      String? udi,
      bool? hasAddresses,
      String? author,
      String? description,
      @JsonKey(name: 'outcome_reference') String? outcomeReference,
      @JsonKey(name: 'achievement_status') Coding? achievementStatus,
      Coding? priority,
      Reference? subject,
      @JsonKey(name: 'status_date') String? statusDate});

  @override
  $CodingCopyWith<$Res>? get achievementStatus;
  @override
  $CodingCopyWith<$Res>? get priority;
  @override
  $ReferenceCopyWith<$Res>? get subject;
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? hasStatus = freezed,
    Object? startDate = freezed,
    Object? hasCategory = freezed,
    Object? category = freezed,
    Object? hasUdi = freezed,
    Object? udi = freezed,
    Object? hasAddresses = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? outcomeReference = freezed,
    Object? achievementStatus = freezed,
    Object? priority = freezed,
    Object? subject = freezed,
    Object? statusDate = freezed,
  }) {
    return _then(_$GoalImpl(
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
      hasStatus: freezed == hasStatus
          ? _value.hasStatus
          : hasStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      hasCategory: freezed == hasCategory
          ? _value.hasCategory
          : hasCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      category: freezed == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      hasUdi: freezed == hasUdi
          ? _value.hasUdi
          : hasUdi // ignore: cast_nullable_to_non_nullable
              as bool?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as String?,
      hasAddresses: freezed == hasAddresses
          ? _value.hasAddresses
          : hasAddresses // ignore: cast_nullable_to_non_nullable
              as bool?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      outcomeReference: freezed == outcomeReference
          ? _value.outcomeReference
          : outcomeReference // ignore: cast_nullable_to_non_nullable
              as String?,
      achievementStatus: freezed == achievementStatus
          ? _value.achievementStatus
          : achievementStatus // ignore: cast_nullable_to_non_nullable
              as Coding?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as Coding?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as Reference?,
      statusDate: freezed == statusDate
          ? _value.statusDate
          : statusDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalImpl implements _Goal {
  const _$GoalImpl(
      {this.id,
      this.title,
      this.status,
      @JsonKey(name: 'has_status') this.hasStatus,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'has_category') this.hasCategory,
      final List<CodeableConcept>? category,
      @JsonKey(name: 'has_udi') this.hasUdi,
      this.udi,
      this.hasAddresses,
      this.author,
      this.description,
      @JsonKey(name: 'outcome_reference') this.outcomeReference,
      @JsonKey(name: 'achievement_status') this.achievementStatus,
      this.priority,
      this.subject,
      @JsonKey(name: 'status_date') this.statusDate})
      : _category = category;

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? status;
  @override
  @JsonKey(name: 'has_status')
  final bool? hasStatus;
  @override
  @JsonKey(name: 'start_date')
  final String? startDate;
  @override
  @JsonKey(name: 'has_category')
  final bool? hasCategory;
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
  @JsonKey(name: 'has_udi')
  final bool? hasUdi;
  @override
  final String? udi;
  @override
  final bool? hasAddresses;
  @override
  final String? author;
  @override
  final String? description;
  @override
  @JsonKey(name: 'outcome_reference')
  final String? outcomeReference;
  @override
  @JsonKey(name: 'achievement_status')
  final Coding? achievementStatus;
  @override
  final Coding? priority;
  @override
  final Reference? subject;
  @override
  @JsonKey(name: 'status_date')
  final String? statusDate;

  @override
  String toString() {
    return 'Goal(id: $id, title: $title, status: $status, hasStatus: $hasStatus, startDate: $startDate, hasCategory: $hasCategory, category: $category, hasUdi: $hasUdi, udi: $udi, hasAddresses: $hasAddresses, author: $author, description: $description, outcomeReference: $outcomeReference, achievementStatus: $achievementStatus, priority: $priority, subject: $subject, statusDate: $statusDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hasStatus, hasStatus) ||
                other.hasStatus == hasStatus) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.hasCategory, hasCategory) ||
                other.hasCategory == hasCategory) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.hasUdi, hasUdi) || other.hasUdi == hasUdi) &&
            (identical(other.udi, udi) || other.udi == udi) &&
            (identical(other.hasAddresses, hasAddresses) ||
                other.hasAddresses == hasAddresses) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.outcomeReference, outcomeReference) ||
                other.outcomeReference == outcomeReference) &&
            (identical(other.achievementStatus, achievementStatus) ||
                other.achievementStatus == achievementStatus) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.statusDate, statusDate) ||
                other.statusDate == statusDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      status,
      hasStatus,
      startDate,
      hasCategory,
      const DeepCollectionEquality().hash(_category),
      hasUdi,
      udi,
      hasAddresses,
      author,
      description,
      outcomeReference,
      achievementStatus,
      priority,
      subject,
      statusDate);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {final String? id,
      final String? title,
      final String? status,
      @JsonKey(name: 'has_status') final bool? hasStatus,
      @JsonKey(name: 'start_date') final String? startDate,
      @JsonKey(name: 'has_category') final bool? hasCategory,
      final List<CodeableConcept>? category,
      @JsonKey(name: 'has_udi') final bool? hasUdi,
      final String? udi,
      final bool? hasAddresses,
      final String? author,
      final String? description,
      @JsonKey(name: 'outcome_reference') final String? outcomeReference,
      @JsonKey(name: 'achievement_status') final Coding? achievementStatus,
      final Coding? priority,
      final Reference? subject,
      @JsonKey(name: 'status_date') final String? statusDate}) = _$GoalImpl;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get status;
  @override
  @JsonKey(name: 'has_status')
  bool? get hasStatus;
  @override
  @JsonKey(name: 'start_date')
  String? get startDate;
  @override
  @JsonKey(name: 'has_category')
  bool? get hasCategory;
  @override
  List<CodeableConcept>? get category;
  @override
  @JsonKey(name: 'has_udi')
  bool? get hasUdi;
  @override
  String? get udi;
  @override
  bool? get hasAddresses;
  @override
  String? get author;
  @override
  String? get description;
  @override
  @JsonKey(name: 'outcome_reference')
  String? get outcomeReference;
  @override
  @JsonKey(name: 'achievement_status')
  Coding? get achievementStatus;
  @override
  Coding? get priority;
  @override
  Reference? get subject;
  @override
  @JsonKey(name: 'status_date')
  String? get statusDate;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
