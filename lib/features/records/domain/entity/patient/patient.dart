import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'patient.freezed.dart';

@freezed
class Patient with _$Patient implements IFhirResource {
  const Patient._();

  factory Patient({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    List<HumanName>? name,
    List<ContactPoint>? telecom,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    DeceasedXPatient? deceasedX,
    List<Address>? address,
    CodeableConcept? maritalStatus,
    MultipleBirthXPatient? multipleBirthX,
    List<Attachment>? photo,
    List<PatientContact>? contact,
    List<PatientCommunication>? communication,
    List<Reference>? generalPractitioner,
    Reference? managingOrganization,
    List<PatientLink>? link,
  }) = _Patient;

  @override
  FhirType get fhirType => FhirType.Patient;

  factory Patient.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPatient = fhir_r4.Patient.fromJson(resourceJson);

    return Patient(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirPatient.text,
      identifier: fhirPatient.identifier,
      active: fhirPatient.active,
      name: fhirPatient.name,
      telecom: fhirPatient.telecom,
      gender: fhirPatient.gender,
      birthDate: fhirPatient.birthDate,
      deceasedX: fhirPatient.deceasedX,
      address: fhirPatient.address,
      maritalStatus: fhirPatient.maritalStatus,
      multipleBirthX: fhirPatient.multipleBirthX,
      photo: fhirPatient.photo,
      contact: fhirPatient.contact,
      communication: fhirPatient.communication,
      generalPractitioner: fhirPatient.generalPractitioner,
      managingOrganization: fhirPatient.managingOrganization,
      link: fhirPatient.link,
    );
  }
}
