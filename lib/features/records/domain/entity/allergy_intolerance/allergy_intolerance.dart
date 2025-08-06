import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'allergy_intolerance.freezed.dart';

@freezed
class AllergyIntolerance with _$AllergyIntolerance implements IFhirResource {
  const AllergyIntolerance._();

  factory AllergyIntolerance({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CodeableConcept? clinicalStatus,
    CodeableConcept? verificationStatus,
    AllergyIntoleranceType? type,
    List<AllergyIntoleranceCategory>? category,
    AllergyIntoleranceCriticality? criticality,
    CodeableConcept? code,
    Reference? patient,
    OnsetXAllergyIntolerance? onsetX,
    FhirDateTime? recordedDate,
    Reference? recorder,
    Reference? asserter,
    FhirDateTime? lastOccurrence,
    List<Annotation>? note,
    List<AllergyIntoleranceReaction>? reaction,
  }) = _AllergyIntolerance;

  @override
  FhirType get fhirType => FhirType.AllergyIntolerance;

  factory AllergyIntolerance.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirAllergyIntolerance =
        fhir_r4.AllergyIntolerance.fromJson(resourceJson);

    return AllergyIntolerance(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirAllergyIntolerance.text,
      identifier: fhirAllergyIntolerance.identifier,
      clinicalStatus: fhirAllergyIntolerance.clinicalStatus,
      verificationStatus: fhirAllergyIntolerance.verificationStatus,
      type: fhirAllergyIntolerance.type,
      category: fhirAllergyIntolerance.category,
      criticality: fhirAllergyIntolerance.criticality,
      code: fhirAllergyIntolerance.code,
      patient: fhirAllergyIntolerance.patient,
      onsetX: fhirAllergyIntolerance.onsetX,
      recordedDate: fhirAllergyIntolerance.recordedDate,
      recorder: fhirAllergyIntolerance.recorder,
      asserter: fhirAllergyIntolerance.asserter,
      lastOccurrence: fhirAllergyIntolerance.lastOccurrence,
      note: fhirAllergyIntolerance.note,
      reaction: fhirAllergyIntolerance.reaction,
    );
  }
}
