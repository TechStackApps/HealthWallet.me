import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'care_team.freezed.dart';

@freezed
class CareTeam with _$CareTeam implements IFhirResource {
  const CareTeam._();

  const factory CareTeam({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CareTeamStatus? status,
    List<CodeableConcept>? category,
    FhirString? name,
    Reference? subject,
    Reference? encounter,
    Period? period,
    List<CareTeamParticipant>? participant,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<Reference>? managingOrganization,
    List<ContactPoint>? telecom,
    List<Annotation>? note,
  }) = _CareTeam;

  @override
  FhirType get fhirType => FhirType.CareTeam;

  factory CareTeam.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirCareTeam = fhir_r4.CareTeam.fromJson(resourceJson);

    return CareTeam(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirCareTeam.text,
      identifier: fhirCareTeam.identifier,
      status: fhirCareTeam.status,
      category: fhirCareTeam.category,
      name: fhirCareTeam.name,
      subject: fhirCareTeam.subject,
      encounter: fhirCareTeam.encounter,
      period: fhirCareTeam.period,
      participant: fhirCareTeam.participant,
      reasonCode: fhirCareTeam.reasonCode,
      reasonReference: fhirCareTeam.reasonReference,
      managingOrganization: fhirCareTeam.managingOrganization,
      telecom: fhirCareTeam.telecom,
      note: fhirCareTeam.note,
    );
  }
}
