import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/core/utils/performance_monitor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'diagnostic_report.freezed.dart';

@freezed
class DiagnosticReport with _$DiagnosticReport implements IFhirResource {
  const DiagnosticReport._();

  const factory DiagnosticReport({
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

    return DiagnosticReport(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
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

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText = FhirFieldExtractor.extractCodeableConceptText(code);
    if (displayText != null) return displayText;

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final categoryDisplay =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(category);
    if (categoryDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: categoryDisplay,
      ));
    }

    final performerDisplay = performer?.firstOrNull?.display?.valueString;
    if (performerDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.user,
        info: performerDisplay,
      ));
    }

    if (date != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.calendar,
        info: DateFormat.yMMMMd().format(date!),
      ));
    }

    return infoLines;
  }

  @override
  List<String?> get resourceReferences {
    return {
      subject?.reference?.valueString,
      encounter?.reference?.valueString,
      ...?basedOn?.map((reference) => reference.reference?.valueString),
      ...?performer?.map((reference) => reference.reference?.valueString),
      ...?resultsInterpreter
          ?.map((reference) => reference.reference?.valueString),
      ...?specimen?.map((reference) => reference.reference?.valueString),
      ...?result?.map((reference) => reference.reference?.valueString),
      ...?imagingStudy?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }
}
