import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'related_person.freezed.dart';

@freezed
class RelatedPerson with _$RelatedPerson implements IFhirResource {
  const RelatedPerson._();

  factory RelatedPerson({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    Reference? patient,
    List<CodeableConcept>? relationship,
    List<HumanName>? name,
    List<ContactPoint>? telecom,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    List<Address>? address,
    List<Attachment>? photo,
    Period? period,
    List<RelatedPersonCommunication>? communication,
  }) = _RelatedPerson;

  @override
  FhirType get fhirType => FhirType.RelatedPerson;

  factory RelatedPerson.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirRelatedPerson = fhir_r4.RelatedPerson.fromJson(resourceJson);

    return RelatedPerson(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      text: fhirRelatedPerson.text,
      identifier: fhirRelatedPerson.identifier,
      active: fhirRelatedPerson.active,
      patient: fhirRelatedPerson.patient,
      relationship: fhirRelatedPerson.relationship,
      name: fhirRelatedPerson.name,
      telecom: fhirRelatedPerson.telecom,
      gender: fhirRelatedPerson.gender,
      birthDate: fhirRelatedPerson.birthDate,
      address: fhirRelatedPerson.address,
      photo: fhirRelatedPerson.photo,
      period: fhirRelatedPerson.period,
      communication: fhirRelatedPerson.communication,
    );
  }
}
