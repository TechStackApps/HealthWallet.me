import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_date_extractor.dart';

part 'observation.freezed.dart';

@freezed
class Observation with _$Observation implements IFhirResource {
  const Observation._();

  factory Observation({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    ObservationStatus? status,
    List<CodeableConcept>? category,
    CodeableConcept? code,
    Reference? subject,
    List<Reference>? focus,
    Reference? encounter,
    EffectiveXObservation? effectiveX,
    FhirInstant? issued,
    List<Reference>? performer,
    ValueXObservation? valueX,
    CodeableConcept? dataAbsentReason,
    List<CodeableConcept>? interpretation,
    List<Annotation>? note,
    CodeableConcept? bodySite,
    CodeableConcept? method,
    Reference? specimen,
    Reference? device,
    List<ObservationReferenceRange>? referenceRange,
    List<Reference>? hasMember,
    List<Reference>? derivedFrom,
    List<ObservationComponent>? component,
  }) = _Observation;

  @override
  FhirType get fhirType => FhirType.Observation;

  factory Observation.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirObservation = fhir_r4.Observation.fromJson(resourceJson);

    // ✅ REFACTORED: Use centralized date extraction utility
    final effectiveDate = FhirDateExtractor.extractWithFallback(
      primary: fhirObservation.effectiveX,
      secondary: fhirObservation.issued,
      fallback: data.date,
    );

    return Observation(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: effectiveDate,
      text: fhirObservation.text,
      identifier: fhirObservation.identifier,
      basedOn: fhirObservation.basedOn,
      partOf: fhirObservation.partOf,
      status: fhirObservation.status,
      category: fhirObservation.category,
      code: fhirObservation.code,
      subject: fhirObservation.subject,
      focus: fhirObservation.focus,
      encounter: fhirObservation.encounter,
      effectiveX: fhirObservation.effectiveX,
      issued: fhirObservation.issued,
      performer: fhirObservation.performer,
      valueX: fhirObservation.valueX,
      dataAbsentReason: fhirObservation.dataAbsentReason,
      interpretation: fhirObservation.interpretation,
      note: fhirObservation.note,
      bodySite: fhirObservation.bodySite,
      method: fhirObservation.method,
      specimen: fhirObservation.specimen,
      device: fhirObservation.device,
      referenceRange: fhirObservation.referenceRange,
      hasMember: fhirObservation.hasMember,
      derivedFrom: fhirObservation.derivedFrom,
      component: fhirObservation.component,
    );
  }
}
