import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_date_extractor.dart';

part 'encounter.freezed.dart';

@freezed
class Encounter with _$Encounter implements IFhirResource {
  const Encounter._();

  const factory Encounter({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    EncounterStatus? status,
    List<EncounterStatusHistory>? statusHistory,
    Coding? class_,
    List<EncounterClassHistory>? classHistory,
    List<CodeableConcept>? type,
    CodeableConcept? serviceType,
    CodeableConcept? priority,
    Reference? subject,
    List<Reference>? episodeOfCare,
    List<Reference>? basedOn,
    List<EncounterParticipant>? participant,
    List<Reference>? appointment,
    Period? period,
    FhirDuration? length,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<EncounterDiagnosis>? diagnosis,
    List<Reference>? account,
    EncounterHospitalization? hospitalization,
    List<EncounterLocation>? location,
    Reference? serviceProvider,
    Reference? partOf,
  }) = _Encounter;

  @override
  FhirType get fhirType => FhirType.Encounter;

  factory Encounter.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirEncounter = fhir_r4.Encounter.fromJson(resourceJson);

    return Encounter(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirEncounter.text,
      identifier: fhirEncounter.identifier,
      status: fhirEncounter.status,
      statusHistory: fhirEncounter.statusHistory,
      class_: fhirEncounter.class_,
      classHistory: fhirEncounter.classHistory,
      type: fhirEncounter.type,
      serviceType: fhirEncounter.serviceType,
      priority: fhirEncounter.priority,
      subject: fhirEncounter.subject,
      episodeOfCare: fhirEncounter.episodeOfCare,
      basedOn: fhirEncounter.basedOn,
      participant: fhirEncounter.participant,
      appointment: fhirEncounter.appointment,
      period: fhirEncounter.period,
      length: fhirEncounter.length,
      reasonCode: fhirEncounter.reasonCode,
      reasonReference: fhirEncounter.reasonReference,
      diagnosis: fhirEncounter.diagnosis,
      account: fhirEncounter.account,
      hospitalization: fhirEncounter.hospitalization,
      location: fhirEncounter.location,
      serviceProvider: fhirEncounter.serviceProvider,
      partOf: fhirEncounter.partOf,
    );
  }
}
