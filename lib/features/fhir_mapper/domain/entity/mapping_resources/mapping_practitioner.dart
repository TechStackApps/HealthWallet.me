import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/practitioner/practitioner.dart';

part 'mapping_practitioner.freezed.dart';

@freezed
class MappingPractitioner
    with _$MappingPractitioner
    implements MappingResource {
  const MappingPractitioner._();

  const factory MappingPractitioner({
    @Default('') String practitionerName,
    @Default('') String specialty,
    @Default('') String identifier,
  }) = _MappingPractitioner;

  factory MappingPractitioner.fromJson(Map<String, dynamic> json) {
    return MappingPractitioner(
      practitionerName: json['practitionerName'] ?? '',
      specialty: json['specialty'] ?? '',
      identifier: json['identifier'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Practitioner();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'practitionerName': TextFieldDescriptor(
            label: 'Practitioner Name', value: practitionerName),
        'specialty': TextFieldDescriptor(label: 'Specialty', value: specialty),
        'identifier':
            TextFieldDescriptor(label: 'Identifier', value: identifier),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingPractitioner(
        practitionerName: newValues['practitionerName'] ?? practitionerName,
        specialty: newValues['specialty'] ?? specialty,
        identifier: newValues['identifier'] ?? identifier,
      );

  @override
  String get label => 'Practitioner';
}
