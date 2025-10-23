import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_observation.freezed.dart';

@freezed
class MappingObservation with _$MappingObservation implements MappingResource {
  const MappingObservation._();

  const factory MappingObservation({
    @Default(MappedProperty()) MappedProperty observationName,
    @Default(MappedProperty()) MappedProperty value,
    @Default(MappedProperty()) MappedProperty unit,
  }) = _MappingObservation;

  factory MappingObservation.fromJson(Map<String, dynamic> json) {
    return MappingObservation(
      observationName: MappedProperty(value: json['observationName'] ?? ''),
      value: MappedProperty(value: json['value'] ?? ''),
      unit: MappedProperty(value: json['unit'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const Observation();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'observationName': TextFieldDescriptor(
          label: 'Observation name',
          value: observationName.value,
          confidenceLevel: observationName.confidenceLevel,
        ),
        'value': TextFieldDescriptor(
          label: 'Value',
          value: value.value,
          confidenceLevel: value.confidenceLevel,
        ),
        'unit': TextFieldDescriptor(
          label: 'Unit',
          value: unit.value,
          confidenceLevel: unit.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingObservation(
        observationName: MappedProperty(
            value: newValues['observationName'] ?? observationName.value),
        value: MappedProperty(value: newValues['value'] ?? value.value),
        unit: MappedProperty(value: newValues['unit'] ?? unit.value),
      );

  @override
  String get label => 'Observation';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        observationName: observationName.calculateConfidence(inputText),
        value: value.calculateConfidence(inputText),
        unit: unit.calculateConfidence(inputText),
      );

  @override
  bool get isValid => observationName.isValid || value.isValid || unit.isValid;
}
