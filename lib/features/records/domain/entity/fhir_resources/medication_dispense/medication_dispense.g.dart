// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_dispense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationDispenseImpl _$$MedicationDispenseImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationDispenseImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      medicationTitle: json['medication_title'] as String?,
      medicationCoding: json['medication_coding'] == null
          ? null
          : Coding.fromJson(json['medication_coding'] as Map<String, dynamic>),
      typeCoding: json['type_coding'] == null
          ? null
          : Coding.fromJson(json['type_coding'] as Map<String, dynamic>),
      hasDosageInstruction: json['has_dosage_instruction'] as bool?,
      dosageInstruction: (json['dosage_instruction'] as List<dynamic>?)
          ?.map((e) => DosageInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      dosageInstructionData: (json['dosage_instruction_data'] as List<dynamic>?)
          ?.map(
              (e) => DosageInstructionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      whenPrepared: json['when_prepared'] as String?,
    );

Map<String, dynamic> _$$MedicationDispenseImplToJson(
        _$MedicationDispenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'medication_title': instance.medicationTitle,
      'medication_coding': instance.medicationCoding,
      'type_coding': instance.typeCoding,
      'has_dosage_instruction': instance.hasDosageInstruction,
      'dosage_instruction': instance.dosageInstruction,
      'dosage_instruction_data': instance.dosageInstructionData,
      'when_prepared': instance.whenPrepared,
    };

_$DosageInstructionImpl _$$DosageInstructionImplFromJson(
        Map<String, dynamic> json) =>
    _$DosageInstructionImpl(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$DosageInstructionImplToJson(
        _$DosageInstructionImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

_$DosageInstructionDataImpl _$$DosageInstructionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DosageInstructionDataImpl(
      route: json['route'] as String?,
      doseQuantity: json['doseQuantity'] as String?,
      additionalInstructions: json['additionalInstructions'] as String?,
      timing: json['timing'] as String?,
    );

Map<String, dynamic> _$$DosageInstructionDataImplToJson(
        _$DosageInstructionDataImpl instance) =>
    <String, dynamic>{
      'route': instance.route,
      'doseQuantity': instance.doseQuantity,
      'additionalInstructions': instance.additionalInstructions,
      'timing': instance.timing,
    };
