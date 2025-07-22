// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnostic_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiagnosticReport _$DiagnosticReportFromJson(Map<String, dynamic> json) {
  return _DiagnosticReport.fromJson(json);
}

/// @nodoc
mixin _$DiagnosticReport {
  String get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'effective_datetime')
  String? get effectiveDatetime => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_coding')
  List<CodeableConcept>? get categoryCoding =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'code_coding')
  List<Coding>? get codeCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_category_coding')
  bool? get hasCategoryCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_performer')
  bool? get hasPerformer => throw _privateConstructorUsedError;
  String? get conclusion => throw _privateConstructorUsedError;
  Reference? get performer => throw _privateConstructorUsedError;
  String? get issued => throw _privateConstructorUsedError;
  @JsonKey(name: 'presented_form')
  List<Attachment>? get presentedForm => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_category_lab_report')
  bool? get isCategoryLabReport => throw _privateConstructorUsedError;

  /// Serializes this DiagnosticReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosticReportCopyWith<DiagnosticReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosticReportCopyWith<$Res> {
  factory $DiagnosticReportCopyWith(
          DiagnosticReport value, $Res Function(DiagnosticReport) then) =
      _$DiagnosticReportCopyWithImpl<$Res, DiagnosticReport>;
  @useResult
  $Res call(
      {String id,
      CodeableConcept? code,
      String? title,
      String? status,
      @JsonKey(name: 'effective_datetime') String? effectiveDatetime,
      @JsonKey(name: 'category_coding') List<CodeableConcept>? categoryCoding,
      @JsonKey(name: 'code_coding') List<Coding>? codeCoding,
      @JsonKey(name: 'has_category_coding') bool? hasCategoryCoding,
      @JsonKey(name: 'has_performer') bool? hasPerformer,
      String? conclusion,
      Reference? performer,
      String? issued,
      @JsonKey(name: 'presented_form') List<Attachment>? presentedForm,
      @JsonKey(name: 'is_category_lab_report') bool? isCategoryLabReport});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get performer;
}

/// @nodoc
class _$DiagnosticReportCopyWithImpl<$Res, $Val extends DiagnosticReport>
    implements $DiagnosticReportCopyWith<$Res> {
  _$DiagnosticReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? effectiveDatetime = freezed,
    Object? categoryCoding = freezed,
    Object? codeCoding = freezed,
    Object? hasCategoryCoding = freezed,
    Object? hasPerformer = freezed,
    Object? conclusion = freezed,
    Object? performer = freezed,
    Object? issued = freezed,
    Object? presentedForm = freezed,
    Object? isCategoryLabReport = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      effectiveDatetime: freezed == effectiveDatetime
          ? _value.effectiveDatetime
          : effectiveDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryCoding: freezed == categoryCoding
          ? _value.categoryCoding
          : categoryCoding // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      codeCoding: freezed == codeCoding
          ? _value.codeCoding
          : codeCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasCategoryCoding: freezed == hasCategoryCoding
          ? _value.hasCategoryCoding
          : hasCategoryCoding // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPerformer: freezed == hasPerformer
          ? _value.hasPerformer
          : hasPerformer // ignore: cast_nullable_to_non_nullable
              as bool?,
      conclusion: freezed == conclusion
          ? _value.conclusion
          : conclusion // ignore: cast_nullable_to_non_nullable
              as String?,
      performer: freezed == performer
          ? _value.performer
          : performer // ignore: cast_nullable_to_non_nullable
              as Reference?,
      issued: freezed == issued
          ? _value.issued
          : issued // ignore: cast_nullable_to_non_nullable
              as String?,
      presentedForm: freezed == presentedForm
          ? _value.presentedForm
          : presentedForm // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      isCategoryLabReport: freezed == isCategoryLabReport
          ? _value.isCategoryLabReport
          : isCategoryLabReport // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of DiagnosticReport
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

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get performer {
    if (_value.performer == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.performer!, (value) {
      return _then(_value.copyWith(performer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiagnosticReportImplCopyWith<$Res>
    implements $DiagnosticReportCopyWith<$Res> {
  factory _$$DiagnosticReportImplCopyWith(_$DiagnosticReportImpl value,
          $Res Function(_$DiagnosticReportImpl) then) =
      __$$DiagnosticReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      CodeableConcept? code,
      String? title,
      String? status,
      @JsonKey(name: 'effective_datetime') String? effectiveDatetime,
      @JsonKey(name: 'category_coding') List<CodeableConcept>? categoryCoding,
      @JsonKey(name: 'code_coding') List<Coding>? codeCoding,
      @JsonKey(name: 'has_category_coding') bool? hasCategoryCoding,
      @JsonKey(name: 'has_performer') bool? hasPerformer,
      String? conclusion,
      Reference? performer,
      String? issued,
      @JsonKey(name: 'presented_form') List<Attachment>? presentedForm,
      @JsonKey(name: 'is_category_lab_report') bool? isCategoryLabReport});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get performer;
}

/// @nodoc
class __$$DiagnosticReportImplCopyWithImpl<$Res>
    extends _$DiagnosticReportCopyWithImpl<$Res, _$DiagnosticReportImpl>
    implements _$$DiagnosticReportImplCopyWith<$Res> {
  __$$DiagnosticReportImplCopyWithImpl(_$DiagnosticReportImpl _value,
      $Res Function(_$DiagnosticReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? effectiveDatetime = freezed,
    Object? categoryCoding = freezed,
    Object? codeCoding = freezed,
    Object? hasCategoryCoding = freezed,
    Object? hasPerformer = freezed,
    Object? conclusion = freezed,
    Object? performer = freezed,
    Object? issued = freezed,
    Object? presentedForm = freezed,
    Object? isCategoryLabReport = freezed,
  }) {
    return _then(_$DiagnosticReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      effectiveDatetime: freezed == effectiveDatetime
          ? _value.effectiveDatetime
          : effectiveDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryCoding: freezed == categoryCoding
          ? _value._categoryCoding
          : categoryCoding // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      codeCoding: freezed == codeCoding
          ? _value._codeCoding
          : codeCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasCategoryCoding: freezed == hasCategoryCoding
          ? _value.hasCategoryCoding
          : hasCategoryCoding // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPerformer: freezed == hasPerformer
          ? _value.hasPerformer
          : hasPerformer // ignore: cast_nullable_to_non_nullable
              as bool?,
      conclusion: freezed == conclusion
          ? _value.conclusion
          : conclusion // ignore: cast_nullable_to_non_nullable
              as String?,
      performer: freezed == performer
          ? _value.performer
          : performer // ignore: cast_nullable_to_non_nullable
              as Reference?,
      issued: freezed == issued
          ? _value.issued
          : issued // ignore: cast_nullable_to_non_nullable
              as String?,
      presentedForm: freezed == presentedForm
          ? _value._presentedForm
          : presentedForm // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      isCategoryLabReport: freezed == isCategoryLabReport
          ? _value.isCategoryLabReport
          : isCategoryLabReport // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosticReportImpl implements _DiagnosticReport {
  _$DiagnosticReportImpl(
      {required this.id,
      this.code,
      this.title,
      this.status,
      @JsonKey(name: 'effective_datetime') this.effectiveDatetime,
      @JsonKey(name: 'category_coding')
      final List<CodeableConcept>? categoryCoding,
      @JsonKey(name: 'code_coding') final List<Coding>? codeCoding,
      @JsonKey(name: 'has_category_coding') this.hasCategoryCoding,
      @JsonKey(name: 'has_performer') this.hasPerformer,
      this.conclusion,
      this.performer,
      this.issued,
      @JsonKey(name: 'presented_form') final List<Attachment>? presentedForm,
      @JsonKey(name: 'is_category_lab_report') this.isCategoryLabReport})
      : _categoryCoding = categoryCoding,
        _codeCoding = codeCoding,
        _presentedForm = presentedForm;

  factory _$DiagnosticReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosticReportImplFromJson(json);

  @override
  final String id;
  @override
  final CodeableConcept? code;
  @override
  final String? title;
  @override
  final String? status;
  @override
  @JsonKey(name: 'effective_datetime')
  final String? effectiveDatetime;
  final List<CodeableConcept>? _categoryCoding;
  @override
  @JsonKey(name: 'category_coding')
  List<CodeableConcept>? get categoryCoding {
    final value = _categoryCoding;
    if (value == null) return null;
    if (_categoryCoding is EqualUnmodifiableListView) return _categoryCoding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Coding>? _codeCoding;
  @override
  @JsonKey(name: 'code_coding')
  List<Coding>? get codeCoding {
    final value = _codeCoding;
    if (value == null) return null;
    if (_codeCoding is EqualUnmodifiableListView) return _codeCoding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_category_coding')
  final bool? hasCategoryCoding;
  @override
  @JsonKey(name: 'has_performer')
  final bool? hasPerformer;
  @override
  final String? conclusion;
  @override
  final Reference? performer;
  @override
  final String? issued;
  final List<Attachment>? _presentedForm;
  @override
  @JsonKey(name: 'presented_form')
  List<Attachment>? get presentedForm {
    final value = _presentedForm;
    if (value == null) return null;
    if (_presentedForm is EqualUnmodifiableListView) return _presentedForm;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_category_lab_report')
  final bool? isCategoryLabReport;

  @override
  String toString() {
    return 'DiagnosticReport(id: $id, code: $code, title: $title, status: $status, effectiveDatetime: $effectiveDatetime, categoryCoding: $categoryCoding, codeCoding: $codeCoding, hasCategoryCoding: $hasCategoryCoding, hasPerformer: $hasPerformer, conclusion: $conclusion, performer: $performer, issued: $issued, presentedForm: $presentedForm, isCategoryLabReport: $isCategoryLabReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosticReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.effectiveDatetime, effectiveDatetime) ||
                other.effectiveDatetime == effectiveDatetime) &&
            const DeepCollectionEquality()
                .equals(other._categoryCoding, _categoryCoding) &&
            const DeepCollectionEquality()
                .equals(other._codeCoding, _codeCoding) &&
            (identical(other.hasCategoryCoding, hasCategoryCoding) ||
                other.hasCategoryCoding == hasCategoryCoding) &&
            (identical(other.hasPerformer, hasPerformer) ||
                other.hasPerformer == hasPerformer) &&
            (identical(other.conclusion, conclusion) ||
                other.conclusion == conclusion) &&
            (identical(other.performer, performer) ||
                other.performer == performer) &&
            (identical(other.issued, issued) || other.issued == issued) &&
            const DeepCollectionEquality()
                .equals(other._presentedForm, _presentedForm) &&
            (identical(other.isCategoryLabReport, isCategoryLabReport) ||
                other.isCategoryLabReport == isCategoryLabReport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      title,
      status,
      effectiveDatetime,
      const DeepCollectionEquality().hash(_categoryCoding),
      const DeepCollectionEquality().hash(_codeCoding),
      hasCategoryCoding,
      hasPerformer,
      conclusion,
      performer,
      issued,
      const DeepCollectionEquality().hash(_presentedForm),
      isCategoryLabReport);

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosticReportImplCopyWith<_$DiagnosticReportImpl> get copyWith =>
      __$$DiagnosticReportImplCopyWithImpl<_$DiagnosticReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosticReportImplToJson(
      this,
    );
  }
}

abstract class _DiagnosticReport implements DiagnosticReport {
  factory _DiagnosticReport(
      {required final String id,
      final CodeableConcept? code,
      final String? title,
      final String? status,
      @JsonKey(name: 'effective_datetime') final String? effectiveDatetime,
      @JsonKey(name: 'category_coding')
      final List<CodeableConcept>? categoryCoding,
      @JsonKey(name: 'code_coding') final List<Coding>? codeCoding,
      @JsonKey(name: 'has_category_coding') final bool? hasCategoryCoding,
      @JsonKey(name: 'has_performer') final bool? hasPerformer,
      final String? conclusion,
      final Reference? performer,
      final String? issued,
      @JsonKey(name: 'presented_form') final List<Attachment>? presentedForm,
      @JsonKey(name: 'is_category_lab_report')
      final bool? isCategoryLabReport}) = _$DiagnosticReportImpl;

  factory _DiagnosticReport.fromJson(Map<String, dynamic> json) =
      _$DiagnosticReportImpl.fromJson;

  @override
  String get id;
  @override
  CodeableConcept? get code;
  @override
  String? get title;
  @override
  String? get status;
  @override
  @JsonKey(name: 'effective_datetime')
  String? get effectiveDatetime;
  @override
  @JsonKey(name: 'category_coding')
  List<CodeableConcept>? get categoryCoding;
  @override
  @JsonKey(name: 'code_coding')
  List<Coding>? get codeCoding;
  @override
  @JsonKey(name: 'has_category_coding')
  bool? get hasCategoryCoding;
  @override
  @JsonKey(name: 'has_performer')
  bool? get hasPerformer;
  @override
  String? get conclusion;
  @override
  Reference? get performer;
  @override
  String? get issued;
  @override
  @JsonKey(name: 'presented_form')
  List<Attachment>? get presentedForm;
  @override
  @JsonKey(name: 'is_category_lab_report')
  bool? get isCategoryLabReport;

  /// Create a copy of DiagnosticReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosticReportImplCopyWith<_$DiagnosticReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
