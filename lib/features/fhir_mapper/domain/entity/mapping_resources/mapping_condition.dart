import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_condition.freezed.dart';

@freezed
class MappingCondition with _$MappingCondition implements MappingResource {
  const MappingCondition._();

  const factory MappingCondition({
    @Default('') String conditionName,
    @Default('') String onsetDateTime,
    @Default('') String clinicalStatus,
  }) = _MappingCondition;

  factory MappingCondition.fromJson(Map<String, dynamic> json) {
    return MappingCondition(
      conditionName: json['conditionName'] ?? '',
      onsetDateTime: json['onsetDateTime'] ?? '',
      clinicalStatus: json['clinicalStatus'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Condition();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'conditionName':
            TextFieldDescriptor(label: 'Condition Name', value: conditionName),
        'onsetDateTime':
            TextFieldDescriptor(label: 'Onset Date', value: onsetDateTime),
        'clinicalStatus': TextFieldDescriptor(
            label: 'Clinical Status', value: clinicalStatus),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingCondition(
        conditionName: newValues['conditionName'] ?? conditionName,
        onsetDateTime: newValues['onsetDateTime'] ?? onsetDateTime,
        clinicalStatus: newValues['clinicalStatus'] ?? clinicalStatus,
      );

  @override
  String get label => 'Condition';
}
