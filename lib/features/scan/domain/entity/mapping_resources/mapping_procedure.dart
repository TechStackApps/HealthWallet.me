import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/validator.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:uuid/uuid.dart';

part 'mapping_procedure.freezed.dart';

@freezed
class MappingProcedure with _$MappingProcedure implements MappingResource {
  const MappingProcedure._();

  const factory MappingProcedure({
    @Default('') String id,
    @Default(MappedProperty()) MappedProperty procedureName,
    @Default(MappedProperty()) MappedProperty performedDateTime,
    @Default(MappedProperty()) MappedProperty reason,
  }) = _MappingProcedure;

  factory MappingProcedure.fromJson(Map<String, dynamic> json) {
    return MappingProcedure(
      id: const Uuid().v4(),
      procedureName: MappedProperty(value: json['procedureName'] ?? ''),
      performedDateTime: MappedProperty(value: json['performedDateTime'] ?? ''),
      reason: MappedProperty(value: json['reason'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource({
    String? sourceId,
    String? encounterId,
    String? subjectId,
  }) {
    const uuid = Uuid();

    fhir_r4.Procedure procedure = fhir_r4.Procedure(
      code: fhir_r4.CodeableConcept(
          text: fhir_r4.FhirString(procedureName.value)),
      performedX: fhir_r4.FhirDateTime.fromString(performedDateTime.value),
      reasonCode: [
        fhir_r4.CodeableConcept(text: fhir_r4.FhirString(reason.value))
      ],
      subject: fhir_r4.Reference(id: fhir_r4.FhirString(subjectId)),
      status: fhir_r4.EventStatus.unknown,
    );

    Map<String, dynamic> rawResource = procedure.toJson();

    return Procedure(
      id: id,
      resourceId: uuid.v4(),
      title: procedureName.value,
      date: DateTime.tryParse(performedDateTime.value),
      sourceId: sourceId ?? '',
      encounterId: encounterId ?? '',
      subjectId: subjectId ?? '',
      rawResource: rawResource,
      code: procedure.code,
      performedX: procedure.performedX,
      reasonCode: procedure.reasonCode,
    );
  }

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'procedureName': TextFieldDescriptor(
          label: 'Procedure Name',
          value: procedureName.value,
          confidenceLevel: procedureName.confidenceLevel,
        ),
        'performedDateTime': TextFieldDescriptor(
          label: 'Performed Date',
          value: performedDateTime.value,
          confidenceLevel: performedDateTime.confidenceLevel,
          validators: [nonEmptyValidator, dateValidator],
        ),
        'reason': TextFieldDescriptor(
          label: 'Reason',
          value: reason.value,
          confidenceLevel: reason.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingProcedure(
        procedureName: MappedProperty(
            value: newValues['procedureName'] ?? procedureName.value),
        performedDateTime: MappedProperty(
            value: newValues['performedDateTime'] ?? performedDateTime.value),
        reason: MappedProperty(value: newValues['reason'] ?? reason.value),
      );

  @override
  String get label => 'Procedure';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        procedureName: procedureName.calculateConfidence(inputText),
        performedDateTime: performedDateTime.calculateConfidence(inputText),
        reason: reason.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      performedDateTime.isValid || performedDateTime.isValid || reason.isValid;
}
