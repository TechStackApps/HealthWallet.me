import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/attachment.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'diagnostic_report.freezed.dart';
part 'diagnostic_report.g.dart';

@freezed
class DiagnosticReport with _$DiagnosticReport {
  factory DiagnosticReport({
    required String id,
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
    @JsonKey(name: 'is_category_lab_report') bool? isCategoryLabReport,
  }) = _DiagnosticReport;

  factory DiagnosticReport.fromJson(Map<String, dynamic> json) =>
      _$DiagnosticReportFromJson(json);
}
