import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/medication_statement/medication_statement.dart';

part 'mapping_medication_statement.freezed.dart';

@freezed
class MappingMedicationStatement
    with _$MappingMedicationStatement
    implements MappingResource {
  const MappingMedicationStatement._();

  const factory MappingMedicationStatement({
    @Default(MappedProperty()) MappedProperty medicationName,
    @Default(MappedProperty()) MappedProperty dosage,
    @Default(MappedProperty()) MappedProperty reason,
  }) = _MappingMedicationStatement;

  factory MappingMedicationStatement.fromJson(Map<String, dynamic> json) {
    return MappingMedicationStatement(
      medicationName: MappedProperty(value: json['medicationName'] ?? ''),
      dosage: MappedProperty(value: json['dosage'] ?? ''),
      reason: MappedProperty(value: json['reason'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const MedicationStatement();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'medicationName': TextFieldDescriptor(
          label: 'Medication Name',
          value: medicationName.value,
          confidenceLevel: medicationName.confidenceLevel,
        ),
        'dosage': TextFieldDescriptor(
          label: 'Dosage',
          value: dosage.value,
          confidenceLevel: dosage.confidenceLevel,
        ),
        'reason': TextFieldDescriptor(
          label: 'Reason',
          value: reason.value,
          confidenceLevel: reason.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingMedicationStatement(
        medicationName: MappedProperty(
            value: newValues['medicationName'] ?? medicationName.value),
        dosage: MappedProperty(value: newValues['dosage'] ?? dosage.value),
        reason: MappedProperty(value: newValues['reason'] ?? reason.value),
      );

  @override
  String get label => 'Medication Statement';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        medicationName: medicationName.calculateConfidence(inputText),
        dosage: dosage.calculateConfidence(inputText),
        reason: reason.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      medicationName.isValid || dosage.isValid || reason.isValid;
}
