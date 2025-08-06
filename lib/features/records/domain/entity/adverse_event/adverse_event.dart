import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'adverse_event.freezed.dart';

@freezed
class AdverseEvent with _$AdverseEvent implements IFhirResource {
  const AdverseEvent._();

  factory AdverseEvent({
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
}
