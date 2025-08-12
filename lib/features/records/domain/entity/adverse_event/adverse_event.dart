import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'adverse_event.freezed.dart';

@freezed
class AdverseEvent with _$AdverseEvent implements IFhirResource {
  const AdverseEvent._();

  const factory AdverseEvent({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    Identifier? identifier,
    AdverseEventActuality? actuality,
    List<CodeableConcept>? category,
    CodeableConcept? event,
    Reference? subject,
    Reference? encounter,
    FhirDateTime? fhirDate,
    FhirDateTime? detected,
    FhirDateTime? recordedDate,
    List<Reference>? resultingCondition,
    Reference? location,
    CodeableConcept? seriousness,
    CodeableConcept? severity,
    CodeableConcept? outcome,
    Reference? recorder,
    List<Reference>? contributor,
    List<AdverseEventSuspectEntity>? suspectEntity,
    List<Reference>? subjectMedicalHistory,
    List<Reference>? referenceDocument,
    List<Reference>? study,
  }) = _AdverseEvent;

  @override
  FhirType get fhirType => FhirType.AdverseEvent;

  factory AdverseEvent.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirAdverseEvent = fhir_r4.AdverseEvent.fromJson(resourceJson);

    return AdverseEvent(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirAdverseEvent.text,
      identifier: fhirAdverseEvent.identifier,
      actuality: fhirAdverseEvent.actuality,
      category: fhirAdverseEvent.category,
      event: fhirAdverseEvent.event,
      subject: fhirAdverseEvent.subject,
      encounter: fhirAdverseEvent.encounter,
      fhirDate: fhirAdverseEvent.date,
      detected: fhirAdverseEvent.detected,
      recordedDate: fhirAdverseEvent.recordedDate,
      resultingCondition: fhirAdverseEvent.resultingCondition,
      location: fhirAdverseEvent.location,
      seriousness: fhirAdverseEvent.seriousness,
      severity: fhirAdverseEvent.severity,
      outcome: fhirAdverseEvent.outcome,
      recorder: fhirAdverseEvent.recorder,
      contributor: fhirAdverseEvent.contributor,
      suspectEntity: fhirAdverseEvent.suspectEntity,
      subjectMedicalHistory: fhirAdverseEvent.subjectMedicalHistory,
      referenceDocument: fhirAdverseEvent.referenceDocument,
      study: fhirAdverseEvent.study,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText = FhirFieldExtractor.extractCodeableConceptText(event);
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
        icon: Assets.icons.timeline,
        info: categoryDisplay,
      ));
    }

    final severityDisplay =
        FhirFieldExtractor.extractCodeableConceptText(severity);
    if (severityDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.warning,
        info: "Severity: $severityDisplay",
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
      location?.reference?.valueString,
      recorder?.reference?.valueString,
      ...?resultingCondition
          ?.map((reference) => reference.reference?.valueString),
      ...?subjectMedicalHistory
          ?.map((reference) => reference.reference?.valueString),
      ...?referenceDocument
          ?.map((reference) => reference.reference?.valueString),
      ...?study?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => actuality?.valueString ?? '';
}
