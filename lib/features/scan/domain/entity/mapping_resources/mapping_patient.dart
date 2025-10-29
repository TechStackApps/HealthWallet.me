import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/validator.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:uuid/uuid.dart';

part 'mapping_patient.freezed.dart';

@freezed
class MappingPatient with _$MappingPatient implements MappingResource {
  const MappingPatient._();

  const factory MappingPatient({
    @Default('') String id,
    @Default(MappedProperty()) MappedProperty familyName,
    @Default(MappedProperty()) MappedProperty givenName,
    @Default(MappedProperty()) MappedProperty dateOfBirth,
    @Default(MappedProperty()) MappedProperty gender,
    @Default(MappedProperty()) MappedProperty patientId,
  }) = _MappingPatient;

  factory MappingPatient.fromJson(Map<String, dynamic> json) {
    return MappingPatient(
      id: const Uuid().v4(),
      familyName: MappedProperty(value: json['familyName'] ?? ''),
      givenName: MappedProperty(value: json['givenName'] ?? ''),
      dateOfBirth: MappedProperty(value: json['dateOfBirth'] ?? ''),
      gender: MappedProperty(value: json['gender'] ?? ''),
      patientId: MappedProperty(value: json['patientId'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource({
    String? sourceId,
    String? encounterId,
    String? subjectId,
  }) {
    const uuid = Uuid();

    fhir_r4.Patient patient = fhir_r4.Patient(
      name: [
        fhir_r4.HumanName(
          family: fhir_r4.FhirString(familyName.value),
          given: [fhir_r4.FhirString(givenName.value)],
        )
      ],
      birthDate: fhir_r4.FhirDate.fromString(dateOfBirth.value),
      gender: fhir_r4.AdministrativeGender(gender.value),
      identifier: [fhir_r4.Identifier(id: fhir_r4.FhirString(patientId.value))],
    );

    final rawResource = patient.toJson();

    return Patient(
      id: id,
      resourceId: uuid.v4(),
      title: "${givenName.value} ${familyName.value}",
      sourceId: sourceId ?? '',
      encounterId: encounterId ?? '',
      subjectId: subjectId ?? '',
      rawResource: rawResource,
      name: patient.name,
      birthDate: patient.birthDate,
      gender: patient.gender,
      identifier: patient.identifier,
    );
  }

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'givenName': TextFieldDescriptor(
          label: 'First name',
          value: givenName.value,
          confidenceLevel: givenName.confidenceLevel,
        ),
        'familyName': TextFieldDescriptor(
          label: 'Second name',
          value: familyName.value,
          confidenceLevel: familyName.confidenceLevel,
        ),
        'dateOfBirth': TextFieldDescriptor(
          label: 'Date of birth',
          value: dateOfBirth.value,
          confidenceLevel: dateOfBirth.confidenceLevel,
          validators: [nonEmptyValidator, dateValidator],
        ),
        'gender': TextFieldDescriptor(
          label: 'Gender',
          value: gender.value,
          confidenceLevel: gender.confidenceLevel,
        ),
        'patientId': TextFieldDescriptor(
          label: 'ID',
          value: patientId.value,
          confidenceLevel: patientId.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) => MappingPatient(
        givenName:
            MappedProperty(value: newValues['givenName'] ?? givenName.value),
        familyName:
            MappedProperty(value: newValues['familyName'] ?? familyName.value),
        dateOfBirth: MappedProperty(
            value: newValues['dateOfBirth'] ?? dateOfBirth.value),
        gender: MappedProperty(value: newValues['gender'] ?? gender.value),
        patientId:
            MappedProperty(value: newValues['patientId'] ?? patientId.value),
      );

  @override
  String get label => 'Patient';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        familyName: familyName.calculateConfidence(inputText),
        givenName: givenName.calculateConfidence(inputText),
        dateOfBirth: dateOfBirth.calculateConfidence(inputText),
        gender: gender.calculateConfidence(inputText),
        patientId: patientId.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      familyName.isValid ||
      givenName.isValid ||
      dateOfBirth.isValid ||
      gender.isValid ||
      patientId.isValid;
}
