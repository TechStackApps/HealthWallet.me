import 'package:freezed_annotation/freezed_annotation.dart';
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
    @Default('') String medicationName,
    @Default('') String dosage,
    @Default('') String reason,
  }) = _MappingMedicationStatement;

  factory MappingMedicationStatement.fromJson(Map<String, dynamic> json) {
    return MappingMedicationStatement(
      medicationName: json['medicationName'] ?? '',
      dosage: json['dosage'] ?? '',
      reason: json['reason'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const MedicationStatement();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'medicationName': TextFieldDescriptor(
            label: 'Medication Name', value: medicationName),
        'dosage': TextFieldDescriptor(label: 'Dosage', value: dosage),
        'reason': TextFieldDescriptor(label: 'Reason', value: reason),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingMedicationStatement(
        medicationName: newValues['medicationName'] ?? medicationName,
        dosage: newValues['dosage'] ?? dosage,
        reason: newValues['reason'] ?? reason,
      );

  @override
  String get label => 'Medication Statement';
}
