// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy_intolerance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllergyIntolerance _$AllergyIntoleranceFromJson(Map<String, dynamic> json) {
  return _AllergyIntolerance.fromJson(json);
}

/// @nodoc
mixin _$AllergyIntolerance {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'recorded_date')
  String? get recordedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'substance_coding')
  List<Coding>? get substanceCoding => throw _privateConstructorUsedError;
  Reference? get asserter => throw _privateConstructorUsedError;
  List<Note>? get note => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  List<String>? get category => throw _privateConstructorUsedError;
  Reference? get patient => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;

  /// Serializes this AllergyIntolerance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyIntoleranceCopyWith<AllergyIntolerance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyIntoleranceCopyWith<$Res> {
  factory $AllergyIntoleranceCopyWith(
          AllergyIntolerance value, $Res Function(AllergyIntolerance) then) =
      _$AllergyIntoleranceCopyWithImpl<$Res, AllergyIntolerance>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? status,
      @JsonKey(name: 'recorded_date') String? recordedDate,
      @JsonKey(name: 'substance_coding') List<Coding>? substanceCoding,
      Reference? asserter,
      List<Note>? note,
      String? type,
      List<String>? category,
      Reference? patient,
      CodeableConcept? code});

  $ReferenceCopyWith<$Res>? get asserter;
  $ReferenceCopyWith<$Res>? get patient;
  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class _$AllergyIntoleranceCopyWithImpl<$Res, $Val extends AllergyIntolerance>
    implements $AllergyIntoleranceCopyWith<$Res> {
  _$AllergyIntoleranceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? status = freezed,
    Object? recordedDate = freezed,
    Object? substanceCoding = freezed,
    Object? asserter = freezed,
    Object? note = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? patient = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedDate: freezed == recordedDate
          ? _value.recordedDate
          : recordedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      substanceCoding: freezed == substanceCoding
          ? _value.substanceCoding
          : substanceCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      asserter: freezed == asserter
          ? _value.asserter
          : asserter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ) as $Val);
  }

  /// Create a copy of AllergyIntolerance
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

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }

  /// Create a copy of AllergyIntolerance
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
abstract class _$$AllergyIntoleranceImplCopyWith<$Res>
    implements $AllergyIntoleranceCopyWith<$Res> {
  factory _$$AllergyIntoleranceImplCopyWith(_$AllergyIntoleranceImpl value,
          $Res Function(_$AllergyIntoleranceImpl) then) =
      __$$AllergyIntoleranceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? status,
      @JsonKey(name: 'recorded_date') String? recordedDate,
      @JsonKey(name: 'substance_coding') List<Coding>? substanceCoding,
      Reference? asserter,
      List<Note>? note,
      String? type,
      List<String>? category,
      Reference? patient,
      CodeableConcept? code});

  @override
  $ReferenceCopyWith<$Res>? get asserter;
  @override
  $ReferenceCopyWith<$Res>? get patient;
  @override
  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class __$$AllergyIntoleranceImplCopyWithImpl<$Res>
    extends _$AllergyIntoleranceCopyWithImpl<$Res, _$AllergyIntoleranceImpl>
    implements _$$AllergyIntoleranceImplCopyWith<$Res> {
  __$$AllergyIntoleranceImplCopyWithImpl(_$AllergyIntoleranceImpl _value,
      $Res Function(_$AllergyIntoleranceImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? status = freezed,
    Object? recordedDate = freezed,
    Object? substanceCoding = freezed,
    Object? asserter = freezed,
    Object? note = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? patient = freezed,
    Object? code = freezed,
  }) {
    return _then(_$AllergyIntoleranceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedDate: freezed == recordedDate
          ? _value.recordedDate
          : recordedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      substanceCoding: freezed == substanceCoding
          ? _value._substanceCoding
          : substanceCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      asserter: freezed == asserter
          ? _value.asserter
          : asserter // ignore: cast_nullable_to_non_nullable
              as Reference?,
      note: freezed == note
          ? _value._note
          : note // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllergyIntoleranceImpl implements _AllergyIntolerance {
  _$AllergyIntoleranceImpl(
      {required this.id,
      this.title,
      this.status,
      @JsonKey(name: 'recorded_date') this.recordedDate,
      @JsonKey(name: 'substance_coding') final List<Coding>? substanceCoding,
      this.asserter,
      final List<Note>? note,
      this.type,
      final List<String>? category,
      this.patient,
      this.code})
      : _substanceCoding = substanceCoding,
        _note = note,
        _category = category;

  factory _$AllergyIntoleranceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergyIntoleranceImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? status;
  @override
  @JsonKey(name: 'recorded_date')
  final String? recordedDate;
  final List<Coding>? _substanceCoding;
  @override
  @JsonKey(name: 'substance_coding')
  List<Coding>? get substanceCoding {
    final value = _substanceCoding;
    if (value == null) return null;
    if (_substanceCoding is EqualUnmodifiableListView) return _substanceCoding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Reference? asserter;
  final List<Note>? _note;
  @override
  List<Note>? get note {
    final value = _note;
    if (value == null) return null;
    if (_note is EqualUnmodifiableListView) return _note;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? type;
  final List<String>? _category;
  @override
  List<String>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Reference? patient;
  @override
  final CodeableConcept? code;

  @override
  String toString() {
    return 'AllergyIntolerance(id: $id, title: $title, status: $status, recordedDate: $recordedDate, substanceCoding: $substanceCoding, asserter: $asserter, note: $note, type: $type, category: $category, patient: $patient, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyIntoleranceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.recordedDate, recordedDate) ||
                other.recordedDate == recordedDate) &&
            const DeepCollectionEquality()
                .equals(other._substanceCoding, _substanceCoding) &&
            (identical(other.asserter, asserter) ||
                other.asserter == asserter) &&
            const DeepCollectionEquality().equals(other._note, _note) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      status,
      recordedDate,
      const DeepCollectionEquality().hash(_substanceCoding),
      asserter,
      const DeepCollectionEquality().hash(_note),
      type,
      const DeepCollectionEquality().hash(_category),
      patient,
      code);

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyIntoleranceImplCopyWith<_$AllergyIntoleranceImpl> get copyWith =>
      __$$AllergyIntoleranceImplCopyWithImpl<_$AllergyIntoleranceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergyIntoleranceImplToJson(
      this,
    );
  }
}

abstract class _AllergyIntolerance implements AllergyIntolerance {
  factory _AllergyIntolerance(
      {required final String id,
      final String? title,
      final String? status,
      @JsonKey(name: 'recorded_date') final String? recordedDate,
      @JsonKey(name: 'substance_coding') final List<Coding>? substanceCoding,
      final Reference? asserter,
      final List<Note>? note,
      final String? type,
      final List<String>? category,
      final Reference? patient,
      final CodeableConcept? code}) = _$AllergyIntoleranceImpl;

  factory _AllergyIntolerance.fromJson(Map<String, dynamic> json) =
      _$AllergyIntoleranceImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get status;
  @override
  @JsonKey(name: 'recorded_date')
  String? get recordedDate;
  @override
  @JsonKey(name: 'substance_coding')
  List<Coding>? get substanceCoding;
  @override
  Reference? get asserter;
  @override
  List<Note>? get note;
  @override
  String? get type;
  @override
  List<String>? get category;
  @override
  Reference? get patient;
  @override
  CodeableConcept? get code;

  /// Create a copy of AllergyIntolerance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyIntoleranceImplCopyWith<_$AllergyIntoleranceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
