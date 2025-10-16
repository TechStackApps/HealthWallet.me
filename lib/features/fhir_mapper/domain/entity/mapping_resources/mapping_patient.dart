import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

part 'mapping_patient.freezed.dart';

@freezed
class MappingPatient with _$MappingPatient implements MappingResource {
  const MappingPatient._();

  const factory MappingPatient({
    @Default('') String familyName,
    @Default('') String givenName,
    @Default('') String dateOfBirth,
    @Default('') String gender,
    @Default('') String patientId,
  }) = _MappingPatient;

  factory MappingPatient.fromJson(Map<String, dynamic> json) {
    return MappingPatient(
      familyName: json['familyName'] ?? '',
      givenName: json['givenName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      patientId: json['patientId'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => Patient(
        name: [
          fhir_r4.HumanName(
            family: fhir_r4.FhirString(familyName),
            given: [fhir_r4.FhirString(givenName)],
          )
        ],
        birthDate: fhir_r4.FhirDate.fromString(dateOfBirth),
        gender: fhir_r4.AdministrativeGender(gender),
        identifier: [fhir_r4.Identifier(id: fhir_r4.FhirString(patientId))],
      );

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'givenName': TextFieldDescriptor(label: 'First name', value: givenName),
        'familyName':
            TextFieldDescriptor(label: 'Second name', value: familyName),
        'dateOfBirth':
            TextFieldDescriptor(label: 'Date of birth', value: dateOfBirth),
        'gender': TextFieldDescriptor(label: 'Gender', value: gender),
        'patientId': TextFieldDescriptor(label: 'ID', value: patientId),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingPatient(
        givenName: newValues['givenName'] ?? givenName,
        familyName: newValues['familyName'] ?? familyName,
        dateOfBirth: newValues['dateOfBirth'] ?? dateOfBirth,
        gender: newValues['gender'] ?? gender,
        patientId: newValues['patientId'] ?? patientId,
      );

  @override
  String get label => 'Patient';
}
