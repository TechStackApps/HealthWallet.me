import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'condition.freezed.dart';

@freezed
class Condition with _$Condition implements IFhirResource {
  const Condition._();

  factory Condition({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CodeableConcept? clinicalStatus,
    CodeableConcept? verificationStatus,
    List<CodeableConcept>? category,
    CodeableConcept? severity,
    CodeableConcept? code,
    List<CodeableConcept>? bodySite,
    Reference? subject,
    Reference? encounter,
    OnsetXCondition? onsetX,
    AbatementXCondition? abatementX,
    FhirDateTime? recordedDate,
    Reference? recorder,
    Reference? asserter,
    List<ConditionStage>? stage,
    List<ConditionEvidence>? evidence,
    List<Annotation>? note,
  }) = _Condition;

  @override
  FhirType get fhirType => FhirType.Condition;

  factory Condition.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirCondition = fhir_r4.Condition.fromJson(resourceJson);

    return Condition(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirCondition.text,
      identifier: fhirCondition.identifier,
      clinicalStatus: fhirCondition.clinicalStatus,
      verificationStatus: fhirCondition.verificationStatus,
      category: fhirCondition.category,
      severity: fhirCondition.severity,
      code: fhirCondition.code,
      bodySite: fhirCondition.bodySite,
      subject: fhirCondition.subject,
      encounter: fhirCondition.encounter,
      onsetX: fhirCondition.onsetX,
      abatementX: fhirCondition.abatementX,
      recordedDate: fhirCondition.recordedDate,
      recorder: fhirCondition.recorder,
      asserter: fhirCondition.asserter,
      stage: fhirCondition.stage,
      evidence: fhirCondition.evidence,
      note: fhirCondition.note,
    );
  }
}
