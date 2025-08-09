import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'practitioner.freezed.dart';

@freezed
class Practitioner with _$Practitioner implements IFhirResource {
  const Practitioner._();

  const factory Practitioner({
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
    List<Address>? address,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    List<PractitionerQualification>? qualification,
    List<CodeableConcept>? communication,
  }) = _Practitioner;

  @override
  FhirType get fhirType => FhirType.Practitioner;

  factory Practitioner.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPractitioner = fhir_r4.Practitioner.fromJson(resourceJson);

    return Practitioner(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirPractitioner.text,
      identifier: fhirPractitioner.identifier,
      active: fhirPractitioner.active,
      name: fhirPractitioner.name,
      telecom: fhirPractitioner.telecom,
      address: fhirPractitioner.address,
      gender: fhirPractitioner.gender,
      birthDate: fhirPractitioner.birthDate,
      qualification: fhirPractitioner.qualification,
      communication: fhirPractitioner.communication,
    );
  }
}
