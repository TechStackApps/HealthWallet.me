import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_encounter.freezed.dart';

@freezed
class MappingEncounter with _$MappingEncounter implements MappingResource {
  const MappingEncounter._();

  const factory MappingEncounter({
    @Default(MappedProperty()) MappedProperty encounterType,
    @Default(MappedProperty()) MappedProperty location,
    @Default(MappedProperty()) MappedProperty periodStart,
  }) = _MappingEncounter;

  factory MappingEncounter.fromJson(Map<String, dynamic> json) {
    return MappingEncounter(
      encounterType: MappedProperty(value: json['encounterType'] ?? ''),
      location: MappedProperty(value: json['location'] ?? ''),
      periodStart: MappedProperty(value: json['periodStart'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const Encounter();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'encounterType': TextFieldDescriptor(
          label: 'Encounter Type',
          value: encounterType.value,
          confidenceLevel: encounterType.confidenceLevel,
        ),
        'location': TextFieldDescriptor(
          label: 'Location',
          value: location.value,
          confidenceLevel: location.confidenceLevel,
        ),
        'periodStart': TextFieldDescriptor(
          label: 'Start Date',
          value: periodStart.value,
          confidenceLevel: periodStart.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingEncounter(
        encounterType: MappedProperty(
            value: newValues['encounterType'] ?? encounterType.value),
        location:
            MappedProperty(value: newValues['location'] ?? location.value),
        periodStart: MappedProperty(
            value: newValues['periodStart'] ?? periodStart.value),
      );

  @override
  String get label => 'Encounter';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        encounterType: encounterType.calculateConfidence(inputText),
        location: location.calculateConfidence(inputText),
        periodStart: periodStart.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      encounterType.isValid || location.isValid || periodStart.isValid;
}
