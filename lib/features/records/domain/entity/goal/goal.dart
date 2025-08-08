import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'goal.freezed.dart';

@freezed
class Goal with _$Goal implements IFhirResource {
  const Goal._();

  const factory Goal({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    GoalLifecycleStatus? lifecycleStatus,
    CodeableConcept? achievementStatus,
    List<CodeableConcept>? category,
    CodeableConcept? priority,
    CodeableConcept? description,
    Reference? subject,
    StartXGoal? startX,
    List<GoalTarget>? target,
    FhirDate? statusDate,
    FhirString? statusReason,
    Reference? expressedBy,
    List<Reference>? addresses,
    List<Annotation>? note,
    List<CodeableConcept>? outcomeCode,
    List<Reference>? outcomeReference,
  }) = _Goal;

  @override
  FhirType get fhirType => FhirType.Goal;

  factory Goal.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirGoal = fhir_r4.Goal.fromJson(resourceJson);

    return Goal(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirGoal.text,
      identifier: fhirGoal.identifier,
      lifecycleStatus: fhirGoal.lifecycleStatus,
      achievementStatus: fhirGoal.achievementStatus,
      category: fhirGoal.category,
      priority: fhirGoal.priority,
      description: fhirGoal.description,
      subject: fhirGoal.subject,
      startX: fhirGoal.startX,
      target: fhirGoal.target,
      statusDate: fhirGoal.statusDate,
      statusReason: fhirGoal.statusReason,
      expressedBy: fhirGoal.expressedBy,
      addresses: fhirGoal.addresses,
      note: fhirGoal.note,
      outcomeCode: fhirGoal.outcomeCode,
      outcomeReference: fhirGoal.outcomeReference,
    );
  }
}
