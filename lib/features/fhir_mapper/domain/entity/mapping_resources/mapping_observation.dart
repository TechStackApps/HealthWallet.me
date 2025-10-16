import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_observation.freezed.dart';

@freezed
class MappingObservation with _$MappingObservation implements MappingResource {
  const MappingObservation._();

  const factory MappingObservation({
    @Default('') String observationName,
    @Default('') String value,
    @Default('') String unit,
  }) = _MappingObservation;

  factory MappingObservation.fromJson(Map<String, dynamic> json) {
    return MappingObservation(
      observationName: json['observationName'] ?? '',
      value: json['value'] ?? '',
      unit: json['unit'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Observation();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'observationName': TextFieldDescriptor(
            label: 'Observation name', value: observationName),
        'value': TextFieldDescriptor(label: 'Value', value: value),
        'unit': TextFieldDescriptor(label: 'Unit', value: unit),
      };
  
  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingObservation(
        observationName: newValues['observationName'] ?? observationName,
        value: newValues['value'] ?? value,
        unit: newValues['unit'] ?? unit,
      );

  @override
  String get label => 'Observation';
}
