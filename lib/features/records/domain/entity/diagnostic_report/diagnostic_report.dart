import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'diagnostic_report.freezed.dart';

@freezed
class DiagnosticReport with _$DiagnosticReport implements IFhirResource {
  const DiagnosticReport._();

  factory DiagnosticReport({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    DiagnosticReportStatus? status,
    List<CodeableConcept>? category,
    CodeableConcept? code,
    Reference? subject,
    Reference? encounter,
    EffectiveXDiagnosticReport? effectiveX,
    FhirInstant? issued,
    List<Reference>? performer,
    List<Reference>? resultsInterpreter,
    List<Reference>? specimen,
    List<Reference>? result,
    List<Reference>? imagingStudy,
    List<DiagnosticReportMedia>? media,
    FhirString? conclusion,
    List<CodeableConcept>? conclusionCode,
    List<Attachment>? presentedForm,
  }) = _DiagnosticReport;

  @override
  FhirType get fhirType => FhirType.DiagnosticReport;

  factory DiagnosticReport.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirDiagnosticReport =
        fhir_r4.DiagnosticReport.fromJson(resourceJson);

    // Extract effective date from FHIR data
    DateTime? effectiveDate;
    if (fhirDiagnosticReport.effectiveX != null) {
      try {
        // Handle different effectiveX types
        final effectiveX = fhirDiagnosticReport.effectiveX;
        if (effectiveX is fhir_r4.FhirDateTime) {
          effectiveDate = DateTime.parse(effectiveX.toString());
        } else if (effectiveX is fhir_r4.Period) {
          final period = effectiveX as fhir_r4.Period;
          if (period.start != null) {
            effectiveDate = DateTime.parse(period.start!.toString());
          }
        }
      } catch (e) {
        // If parsing fails, use the date from DTO or null
        effectiveDate = data.date;
      }
    }

    // Fallback to issued date if no effective date
    if (effectiveDate == null && fhirDiagnosticReport.issued != null) {
      try {
        effectiveDate = DateTime.parse(fhirDiagnosticReport.issued!.toString());
      } catch (e) {
        effectiveDate = data.date;
      }
    }

    return DiagnosticReport(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: effectiveDate,
      text: fhirDiagnosticReport.text,
      identifier: fhirDiagnosticReport.identifier,
      basedOn: fhirDiagnosticReport.basedOn,
      status: fhirDiagnosticReport.status,
      category: fhirDiagnosticReport.category,
      code: fhirDiagnosticReport.code,
      subject: fhirDiagnosticReport.subject,
      encounter: fhirDiagnosticReport.encounter,
      effectiveX: fhirDiagnosticReport.effectiveX,
      issued: fhirDiagnosticReport.issued,
      performer: fhirDiagnosticReport.performer,
      resultsInterpreter: fhirDiagnosticReport.resultsInterpreter,
      specimen: fhirDiagnosticReport.specimen,
      result: fhirDiagnosticReport.result,
      imagingStudy: fhirDiagnosticReport.imagingStudy,
      media: fhirDiagnosticReport.media,
      conclusion: fhirDiagnosticReport.conclusion,
      conclusionCode: fhirDiagnosticReport.conclusionCode,
      presentedForm: fhirDiagnosticReport.presentedForm,
    );
  }
}
