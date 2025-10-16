import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_encounter.freezed.dart';

@freezed
class MappingEncounter with _$MappingEncounter implements MappingResource {
  const MappingEncounter._();

  const factory MappingEncounter({
    @Default('') String encounterType,
    @Default('') String location,
    @Default('') String periodStart,
  }) = _MappingEncounter;

  factory MappingEncounter.fromJson(Map<String, dynamic> json) {
    return MappingEncounter(
      encounterType: json['encounterType'] ?? '',
      location: json['location'] ?? '',
      periodStart: json['periodStart'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Encounter();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'encounterType':
            TextFieldDescriptor(label: 'Encounter Type', value: encounterType),
        'location': TextFieldDescriptor(label: 'Location', value: location),
        'periodStart':
            TextFieldDescriptor(label: 'Start Date', value: periodStart),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingEncounter(
        encounterType: newValues['encounterType'] ?? encounterType,
        location: newValues['location'] ?? location,
        periodStart: newValues['periodStart'] ?? periodStart,
      );

  @override
  String get label => 'Encounter';
}
