import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_condition.freezed.dart';

@freezed
class MappingCondition with _$MappingCondition implements MappingResource {
  const MappingCondition._();

  const factory MappingCondition({
    @Default(MappedProperty()) MappedProperty conditionName,
    @Default(MappedProperty()) MappedProperty onsetDateTime,
    @Default(MappedProperty()) MappedProperty clinicalStatus,
  }) = _MappingCondition;

  factory MappingCondition.fromJson(Map<String, dynamic> json) {
    return MappingCondition(
      conditionName: MappedProperty(value: json['conditionName'] ?? ''),
      onsetDateTime: MappedProperty(value: json['onsetDateTime'] ?? ''),
      clinicalStatus: MappedProperty(value: json['clinicalStatus'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const Condition();

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
