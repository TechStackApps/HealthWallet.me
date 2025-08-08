import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'immunization.freezed.dart';

@freezed
class Immunization with _$Immunization implements IFhirResource {
  const Immunization._();

  const factory Immunization({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    ImmunizationStatusCodes? status,
    CodeableConcept? statusReason,
    CodeableConcept? vaccineCode,
    Reference? patient,
    Reference? encounter,
    OccurrenceXImmunization? occurrenceX,
    FhirDateTime? recorded,
    FhirBoolean? primarySource,
    CodeableConcept? reportOrigin,
    Reference? location,
    Reference? manufacturer,
    FhirString? lotNumber,
    FhirDate? expirationDate,
    CodeableConcept? site,
    CodeableConcept? route,
    Quantity? doseQuantity,
    List<ImmunizationPerformer>? performer,
    List<Annotation>? note,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    FhirBoolean? isSubpotent,
    List<CodeableConcept>? subpotentReason,
    List<ImmunizationEducation>? education,
    List<CodeableConcept>? programEligibility,
    CodeableConcept? fundingSource,
    List<ImmunizationReaction>? reaction,
    List<ImmunizationProtocolApplied>? protocolApplied,
  }) = _Immunization;

  @override
  FhirType get fhirType => FhirType.Immunization;

  factory Immunization.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirImmunization = fhir_r4.Immunization.fromJson(resourceJson);

    return Immunization(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirImmunization.text,
      identifier: fhirImmunization.identifier,
      status: fhirImmunization.status,
      statusReason: fhirImmunization.statusReason,
      vaccineCode: fhirImmunization.vaccineCode,
      patient: fhirImmunization.patient,
      encounter: fhirImmunization.encounter,
      recorded: fhirImmunization.recorded,
      primarySource: fhirImmunization.primarySource,
      reportOrigin: fhirImmunization.reportOrigin,
      location: fhirImmunization.location,
      manufacturer: fhirImmunization.manufacturer,
      lotNumber: fhirImmunization.lotNumber,
      expirationDate: fhirImmunization.expirationDate,
      site: fhirImmunization.site,
      route: fhirImmunization.route,
      doseQuantity: fhirImmunization.doseQuantity,
      performer: fhirImmunization.performer,
      note: fhirImmunization.note,
      reasonCode: fhirImmunization.reasonCode,
      reasonReference: fhirImmunization.reasonReference,
      isSubpotent: fhirImmunization.isSubpotent,
      subpotentReason: fhirImmunization.subpotentReason,
      education: fhirImmunization.education,
      programEligibility: fhirImmunization.programEligibility,
      fundingSource: fhirImmunization.fundingSource,
      reaction: fhirImmunization.reaction,
      protocolApplied: fhirImmunization.protocolApplied,
    );
  }
}
