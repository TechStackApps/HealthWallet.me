import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'practitioner_role.freezed.dart';

@freezed
class PractitionerRole with _$PractitionerRole implements IFhirResource {
  const PractitionerRole._();

  factory PractitionerRole({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    Period? period,
    Reference? practitioner,
    Reference? organization,
    List<CodeableConcept>? code,
    List<CodeableConcept>? specialty,
    List<Reference>? location,
    List<Reference>? healthcareService,
    List<ContactPoint>? telecom,
    List<PractitionerRoleAvailableTime>? availableTime,
    List<PractitionerRoleNotAvailable>? notAvailable,
    FhirString? availabilityExceptions,
    List<Reference>? endpoint,
  }) = _PractitionerRole;

  @override
  FhirType get fhirType => FhirType.PractitionerRole;

  factory PractitionerRole.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPractitionerRole =
        fhir_r4.PractitionerRole.fromJson(resourceJson);

    return PractitionerRole(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      text: fhirPractitionerRole.text,
      identifier: fhirPractitionerRole.identifier,
      active: fhirPractitionerRole.active,
      period: fhirPractitionerRole.period,
      practitioner: fhirPractitionerRole.practitioner,
      organization: fhirPractitionerRole.organization,
      code: fhirPractitionerRole.code,
      specialty: fhirPractitionerRole.specialty,
      location: fhirPractitionerRole.location,
      healthcareService: fhirPractitionerRole.healthcareService,
      telecom: fhirPractitionerRole.telecom,
      availableTime: fhirPractitionerRole.availableTime,
      notAvailable: fhirPractitionerRole.notAvailable,
      availabilityExceptions: fhirPractitionerRole.availabilityExceptions,
      endpoint: fhirPractitionerRole.endpoint,
    );
  }
}
