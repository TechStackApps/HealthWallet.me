// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocumentReference _$DocumentReferenceFromJson(Map<String, dynamic> json) {
  return _DocumentReference.fromJson(json);
}

/// @nodoc
mixin _$DocumentReference {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  CodeableConcept? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_status')
  String? get docStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'class_coding')
  Coding? get classCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'security_label_coding')
  Coding? get securityLabelCoding => throw _privateConstructorUsedError;
  List<Attachment>? get content => throw _privateConstructorUsedError;
  DocumentReferenceContext? get context => throw _privateConstructorUsedError;

  /// Serializes this DocumentReference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentReferenceCopyWith<DocumentReference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentReferenceCopyWith<$Res> {
  factory $DocumentReferenceCopyWith(
          DocumentReference value, $Res Function(DocumentReference) then) =
      _$DocumentReferenceCopyWithImpl<$Res, DocumentReference>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? title,
      String? description,
      String? status,
      CodeableConcept? category,
      @JsonKey(name: 'doc_status') String? docStatus,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      @JsonKey(name: 'class_coding') Coding? classCoding,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'security_label_coding') Coding? securityLabelCoding,
      List<Attachment>? content,
      DocumentReferenceContext? context});

  $CodeableConceptCopyWith<$Res>? get code;
  $CodeableConceptCopyWith<$Res>? get category;
  $CodingCopyWith<$Res>? get typeCoding;
  $CodingCopyWith<$Res>? get classCoding;
  $CodingCopyWith<$Res>? get securityLabelCoding;
  $DocumentReferenceContextCopyWith<$Res>? get context;
}

/// @nodoc
class _$DocumentReferenceCopyWithImpl<$Res, $Val extends DocumentReference>
    implements $DocumentReferenceCopyWith<$Res> {
  _$DocumentReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? category = freezed,
    Object? docStatus = freezed,
    Object? typeCoding = freezed,
    Object? classCoding = freezed,
    Object? createdAt = freezed,
    Object? securityLabelCoding = freezed,
    Object? content = freezed,
    Object? context = freezed,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      docStatus: freezed == docStatus
          ? _value.docStatus
          : docStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      classCoding: freezed == classCoding
          ? _value.classCoding
          : classCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      securityLabelCoding: freezed == securityLabelCoding
          ? _value.securityLabelCoding
          : securityLabelCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as DocumentReferenceContext?,
    ) as $Val);
  }

  /// Create a copy of DocumentReference
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

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of DocumentReference
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

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get classCoding {
    if (_value.classCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.classCoding!, (value) {
      return _then(_value.copyWith(classCoding: value) as $Val);
    });
  }

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get securityLabelCoding {
    if (_value.securityLabelCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.securityLabelCoding!, (value) {
      return _then(_value.copyWith(securityLabelCoding: value) as $Val);
    });
  }

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentReferenceContextCopyWith<$Res>? get context {
    if (_value.context == null) {
      return null;
    }

    return $DocumentReferenceContextCopyWith<$Res>(_value.context!, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentReferenceImplCopyWith<$Res>
    implements $DocumentReferenceCopyWith<$Res> {
  factory _$$DocumentReferenceImplCopyWith(_$DocumentReferenceImpl value,
          $Res Function(_$DocumentReferenceImpl) then) =
      __$$DocumentReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? title,
      String? description,
      String? status,
      CodeableConcept? category,
      @JsonKey(name: 'doc_status') String? docStatus,
      @JsonKey(name: 'type_coding') Coding? typeCoding,
      @JsonKey(name: 'class_coding') Coding? classCoding,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'security_label_coding') Coding? securityLabelCoding,
      List<Attachment>? content,
      DocumentReferenceContext? context});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodingCopyWith<$Res>? get typeCoding;
  @override
  $CodingCopyWith<$Res>? get classCoding;
  @override
  $CodingCopyWith<$Res>? get securityLabelCoding;
  @override
  $DocumentReferenceContextCopyWith<$Res>? get context;
}

/// @nodoc
class __$$DocumentReferenceImplCopyWithImpl<$Res>
    extends _$DocumentReferenceCopyWithImpl<$Res, _$DocumentReferenceImpl>
    implements _$$DocumentReferenceImplCopyWith<$Res> {
  __$$DocumentReferenceImplCopyWithImpl(_$DocumentReferenceImpl _value,
      $Res Function(_$DocumentReferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? category = freezed,
    Object? docStatus = freezed,
    Object? typeCoding = freezed,
    Object? classCoding = freezed,
    Object? createdAt = freezed,
    Object? securityLabelCoding = freezed,
    Object? content = freezed,
    Object? context = freezed,
  }) {
    return _then(_$DocumentReferenceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      docStatus: freezed == docStatus
          ? _value.docStatus
          : docStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      typeCoding: freezed == typeCoding
          ? _value.typeCoding
          : typeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      classCoding: freezed == classCoding
          ? _value.classCoding
          : classCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      securityLabelCoding: freezed == securityLabelCoding
          ? _value.securityLabelCoding
          : securityLabelCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as DocumentReferenceContext?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentReferenceImpl implements _DocumentReference {
  _$DocumentReferenceImpl(
      {this.id,
      this.code,
      this.title,
      this.description,
      this.status,
      this.category,
      @JsonKey(name: 'doc_status') this.docStatus,
      @JsonKey(name: 'type_coding') this.typeCoding,
      @JsonKey(name: 'class_coding') this.classCoding,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'security_label_coding') this.securityLabelCoding,
      final List<Attachment>? content,
      this.context})
      : _content = content;

  factory _$DocumentReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentReferenceImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? status;
  @override
  final CodeableConcept? category;
  @override
  @JsonKey(name: 'doc_status')
  final String? docStatus;
  @override
  @JsonKey(name: 'type_coding')
  final Coding? typeCoding;
  @override
  @JsonKey(name: 'class_coding')
  final Coding? classCoding;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'security_label_coding')
  final Coding? securityLabelCoding;
  final List<Attachment>? _content;
  @override
  List<Attachment>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DocumentReferenceContext? context;

  @override
  String toString() {
    return 'DocumentReference(id: $id, code: $code, title: $title, description: $description, status: $status, category: $category, docStatus: $docStatus, typeCoding: $typeCoding, classCoding: $classCoding, createdAt: $createdAt, securityLabelCoding: $securityLabelCoding, content: $content, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentReferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.docStatus, docStatus) ||
                other.docStatus == docStatus) &&
            (identical(other.typeCoding, typeCoding) ||
                other.typeCoding == typeCoding) &&
            (identical(other.classCoding, classCoding) ||
                other.classCoding == classCoding) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.securityLabelCoding, securityLabelCoding) ||
                other.securityLabelCoding == securityLabelCoding) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.context, context) || other.context == context));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      title,
      description,
      status,
      category,
      docStatus,
      typeCoding,
      classCoding,
      createdAt,
      securityLabelCoding,
      const DeepCollectionEquality().hash(_content),
      context);

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentReferenceImplCopyWith<_$DocumentReferenceImpl> get copyWith =>
      __$$DocumentReferenceImplCopyWithImpl<_$DocumentReferenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentReferenceImplToJson(
      this,
    );
  }
}

abstract class _DocumentReference implements DocumentReference {
  factory _DocumentReference(
      {final String? id,
      final CodeableConcept? code,
      final String? title,
      final String? description,
      final String? status,
      final CodeableConcept? category,
      @JsonKey(name: 'doc_status') final String? docStatus,
      @JsonKey(name: 'type_coding') final Coding? typeCoding,
      @JsonKey(name: 'class_coding') final Coding? classCoding,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'security_label_coding') final Coding? securityLabelCoding,
      final List<Attachment>? content,
      final DocumentReferenceContext? context}) = _$DocumentReferenceImpl;

  factory _DocumentReference.fromJson(Map<String, dynamic> json) =
      _$DocumentReferenceImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get status;
  @override
  CodeableConcept? get category;
  @override
  @JsonKey(name: 'doc_status')
  String? get docStatus;
  @override
  @JsonKey(name: 'type_coding')
  Coding? get typeCoding;
  @override
  @JsonKey(name: 'class_coding')
  Coding? get classCoding;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'security_label_coding')
  Coding? get securityLabelCoding;
  @override
  List<Attachment>? get content;
  @override
  DocumentReferenceContext? get context;

  /// Create a copy of DocumentReference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentReferenceImplCopyWith<_$DocumentReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentReferenceContext _$DocumentReferenceContextFromJson(
    Map<String, dynamic> json) {
  return _DocumentReferenceContext.fromJson(json);
}

/// @nodoc
mixin _$DocumentReferenceContext {
  Coding? get eventCoding => throw _privateConstructorUsedError;
  Coding? get facilityTypeCoding => throw _privateConstructorUsedError;
  Coding? get practiceSettingCoding => throw _privateConstructorUsedError;
  String? get periodStart => throw _privateConstructorUsedError;
  String? get periodEnd => throw _privateConstructorUsedError;

  /// Serializes this DocumentReferenceContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentReferenceContextCopyWith<DocumentReferenceContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentReferenceContextCopyWith<$Res> {
  factory $DocumentReferenceContextCopyWith(DocumentReferenceContext value,
          $Res Function(DocumentReferenceContext) then) =
      _$DocumentReferenceContextCopyWithImpl<$Res, DocumentReferenceContext>;
  @useResult
  $Res call(
      {Coding? eventCoding,
      Coding? facilityTypeCoding,
      Coding? practiceSettingCoding,
      String? periodStart,
      String? periodEnd});

  $CodingCopyWith<$Res>? get eventCoding;
  $CodingCopyWith<$Res>? get facilityTypeCoding;
  $CodingCopyWith<$Res>? get practiceSettingCoding;
}

/// @nodoc
class _$DocumentReferenceContextCopyWithImpl<$Res,
        $Val extends DocumentReferenceContext>
    implements $DocumentReferenceContextCopyWith<$Res> {
  _$DocumentReferenceContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCoding = freezed,
    Object? facilityTypeCoding = freezed,
    Object? practiceSettingCoding = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
  }) {
    return _then(_value.copyWith(
      eventCoding: freezed == eventCoding
          ? _value.eventCoding
          : eventCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      facilityTypeCoding: freezed == facilityTypeCoding
          ? _value.facilityTypeCoding
          : facilityTypeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      practiceSettingCoding: freezed == practiceSettingCoding
          ? _value.practiceSettingCoding
          : practiceSettingCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
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

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get eventCoding {
    if (_value.eventCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.eventCoding!, (value) {
      return _then(_value.copyWith(eventCoding: value) as $Val);
    });
  }

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get facilityTypeCoding {
    if (_value.facilityTypeCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.facilityTypeCoding!, (value) {
      return _then(_value.copyWith(facilityTypeCoding: value) as $Val);
    });
  }

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get practiceSettingCoding {
    if (_value.practiceSettingCoding == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.practiceSettingCoding!, (value) {
      return _then(_value.copyWith(practiceSettingCoding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentReferenceContextImplCopyWith<$Res>
    implements $DocumentReferenceContextCopyWith<$Res> {
  factory _$$DocumentReferenceContextImplCopyWith(
          _$DocumentReferenceContextImpl value,
          $Res Function(_$DocumentReferenceContextImpl) then) =
      __$$DocumentReferenceContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Coding? eventCoding,
      Coding? facilityTypeCoding,
      Coding? practiceSettingCoding,
      String? periodStart,
      String? periodEnd});

  @override
  $CodingCopyWith<$Res>? get eventCoding;
  @override
  $CodingCopyWith<$Res>? get facilityTypeCoding;
  @override
  $CodingCopyWith<$Res>? get practiceSettingCoding;
}

/// @nodoc
class __$$DocumentReferenceContextImplCopyWithImpl<$Res>
    extends _$DocumentReferenceContextCopyWithImpl<$Res,
        _$DocumentReferenceContextImpl>
    implements _$$DocumentReferenceContextImplCopyWith<$Res> {
  __$$DocumentReferenceContextImplCopyWithImpl(
      _$DocumentReferenceContextImpl _value,
      $Res Function(_$DocumentReferenceContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventCoding = freezed,
    Object? facilityTypeCoding = freezed,
    Object? practiceSettingCoding = freezed,
    Object? periodStart = freezed,
    Object? periodEnd = freezed,
  }) {
    return _then(_$DocumentReferenceContextImpl(
      eventCoding: freezed == eventCoding
          ? _value.eventCoding
          : eventCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      facilityTypeCoding: freezed == facilityTypeCoding
          ? _value.facilityTypeCoding
          : facilityTypeCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
      practiceSettingCoding: freezed == practiceSettingCoding
          ? _value.practiceSettingCoding
          : practiceSettingCoding // ignore: cast_nullable_to_non_nullable
              as Coding?,
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
class _$DocumentReferenceContextImpl implements _DocumentReferenceContext {
  _$DocumentReferenceContextImpl(
      {this.eventCoding,
      this.facilityTypeCoding,
      this.practiceSettingCoding,
      this.periodStart,
      this.periodEnd});

  factory _$DocumentReferenceContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentReferenceContextImplFromJson(json);

  @override
  final Coding? eventCoding;
  @override
  final Coding? facilityTypeCoding;
  @override
  final Coding? practiceSettingCoding;
  @override
  final String? periodStart;
  @override
  final String? periodEnd;

  @override
  String toString() {
    return 'DocumentReferenceContext(eventCoding: $eventCoding, facilityTypeCoding: $facilityTypeCoding, practiceSettingCoding: $practiceSettingCoding, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentReferenceContextImpl &&
            (identical(other.eventCoding, eventCoding) ||
                other.eventCoding == eventCoding) &&
            (identical(other.facilityTypeCoding, facilityTypeCoding) ||
                other.facilityTypeCoding == facilityTypeCoding) &&
            (identical(other.practiceSettingCoding, practiceSettingCoding) ||
                other.practiceSettingCoding == practiceSettingCoding) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, eventCoding, facilityTypeCoding,
      practiceSettingCoding, periodStart, periodEnd);

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentReferenceContextImplCopyWith<_$DocumentReferenceContextImpl>
      get copyWith => __$$DocumentReferenceContextImplCopyWithImpl<
          _$DocumentReferenceContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentReferenceContextImplToJson(
      this,
    );
  }
}

abstract class _DocumentReferenceContext implements DocumentReferenceContext {
  factory _DocumentReferenceContext(
      {final Coding? eventCoding,
      final Coding? facilityTypeCoding,
      final Coding? practiceSettingCoding,
      final String? periodStart,
      final String? periodEnd}) = _$DocumentReferenceContextImpl;

  factory _DocumentReferenceContext.fromJson(Map<String, dynamic> json) =
      _$DocumentReferenceContextImpl.fromJson;

  @override
  Coding? get eventCoding;
  @override
  Coding? get facilityTypeCoding;
  @override
  Coding? get practiceSettingCoding;
  @override
  String? get periodStart;
  @override
  String? get periodEnd;

  /// Create a copy of DocumentReferenceContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentReferenceContextImplCopyWith<_$DocumentReferenceContextImpl>
      get copyWith => throw _privateConstructorUsedError;
}
