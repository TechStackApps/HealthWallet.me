import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/validator.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:uuid/uuid.dart';

part 'mapping_condition.freezed.dart';

@freezed
class MappingCondition with _$MappingCondition implements MappingResource {
  const MappingCondition._();

  const factory MappingCondition({
    @Default('') String id,
    @Default(MappedProperty()) MappedProperty conditionName,
    @Default(MappedProperty()) MappedProperty onsetDateTime,
    @Default(MappedProperty()) MappedProperty clinicalStatus,
  }) = _MappingCondition;

  factory MappingCondition.fromJson(Map<String, dynamic> json) {
    return MappingCondition(
      id: const Uuid().v4(),
      conditionName: MappedProperty(value: json['conditionName'] ?? ''),
      onsetDateTime: MappedProperty(value: json['onsetDateTime'] ?? ''),
      clinicalStatus: MappedProperty(value: json['clinicalStatus'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource({
    String? sourceId,
    String? encounterId,
    String? subjectId,
  }) {
    const uuid = Uuid();

    fhir_r4.Condition condition = fhir_r4.Condition(
      code: fhir_r4.CodeableConcept(
          text: fhir_r4.FhirString(conditionName.value)),
      onsetX: fhir_r4.FhirDateTime.fromString(onsetDateTime.value),
      clinicalStatus: fhir_r4.CodeableConcept(
          text: fhir_r4.FhirString(clinicalStatus.value)),
      subject: fhir_r4.Reference(id: fhir_r4.FhirString(subjectId)),
    );

    Map<String, dynamic> rawResource = condition.toJson();

    return Condition(
      id: id,
      resourceId: uuid.v4(),
      title: conditionName.value,
      date: DateTime.tryParse(onsetDateTime.value),
      sourceId: sourceId ?? '',
      encounterId: encounterId ?? '',
      subjectId: subjectId ?? '',
      rawResource: rawResource,
      code: condition.code,
      onsetX: condition.onsetX,
      clinicalStatus: condition.clinicalStatus,
    );
  }

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'conditionName': TextFieldDescriptor(
          label: 'Condition Name',
          value: conditionName.value,
          confidenceLevel: conditionName.confidenceLevel,
        ),
        'onsetDateTime': TextFieldDescriptor(
          label: 'Onset Date',
          value: onsetDateTime.value,
          confidenceLevel: onsetDateTime.confidenceLevel,
          validators: [nonEmptyValidator, dateValidator],
        ),
        'clinicalStatus': TextFieldDescriptor(
          label: 'Clinical Status',
          value: clinicalStatus.value,
          confidenceLevel: clinicalStatus.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingCondition(
        conditionName: MappedProperty(
            value: newValues['conditionName'] ?? conditionName.value),
        onsetDateTime: MappedProperty(
            value: newValues['onsetDateTime'] ?? onsetDateTime.value),
        clinicalStatus: MappedProperty(
            value: newValues['clinicalStatus'] ?? clinicalStatus.value),
      );

  @override
  String get label => 'Condition';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        conditionName: conditionName.calculateConfidence(inputText),
        onsetDateTime: onsetDateTime.calculateConfidence(inputText),
        clinicalStatus: clinicalStatus.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      conditionName.isValid || onsetDateTime.isValid || clinicalStatus.isValid;
}
