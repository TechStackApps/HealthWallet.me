import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';

part 'medication_dispense.freezed.dart';
part 'medication_dispense.g.dart';

@freezed
class MedicationDispense with _$MedicationDispense {
  factory MedicationDispense({
    String? id,
    CodeableConcept? code,
    @JsonKey(name: 'medication_title') String? medicationTitle,
    @JsonKey(name: 'medication_coding') Coding? medicationCoding,
    @JsonKey(name: 'type_coding') Coding? typeCoding,
    @JsonKey(name: 'has_dosage_instruction') bool? hasDosageInstruction,
    @JsonKey(name: 'dosage_instruction')
    List<DosageInstruction>? dosageInstruction,
    @JsonKey(name: 'dosage_instruction_data')
    List<DosageInstructionData>? dosageInstructionData,
    @JsonKey(name: 'when_prepared') String? whenPrepared,
  }) = _MedicationDispense;

  factory MedicationDispense.fromJson(Map<String, dynamic> json) =>
      _$MedicationDispenseFromJson(json);
}

@freezed
class DosageInstruction with _$DosageInstruction {
  factory DosageInstruction({
    String? text,
  }) = _DosageInstruction;

  factory DosageInstruction.fromJson(Map<String, dynamic> json) =>
      _$DosageInstructionFromJson(json);
}

@freezed
class DosageInstructionData with _$DosageInstructionData {
  factory DosageInstructionData({
    String? route,
    String? doseQuantity,
    String? additionalInstructions,
    String? timing,
  }) = _DosageInstructionData;

  factory DosageInstructionData.fromJson(Map<String, dynamic> json) =>
      _$DosageInstructionDataFromJson(json);
}
