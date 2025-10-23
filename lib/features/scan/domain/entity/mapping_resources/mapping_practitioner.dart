import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/practitioner/practitioner.dart';

part 'mapping_practitioner.freezed.dart';

@freezed
class MappingPractitioner
    with _$MappingPractitioner
    implements MappingResource {
  const MappingPractitioner._();

  const factory MappingPractitioner({
    @Default(MappedProperty()) MappedProperty practitionerName,
    @Default(MappedProperty()) MappedProperty specialty,
    @Default(MappedProperty()) MappedProperty identifier,
  }) = _MappingPractitioner;

  factory MappingPractitioner.fromJson(Map<String, dynamic> json) {
    return MappingPractitioner(
      practitionerName: MappedProperty(value: json['practitionerName'] ?? ''),
      specialty: MappedProperty(value: json['specialty'] ?? ''),
      identifier: MappedProperty(value: json['identifier'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const Practitioner();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'practitionerName': TextFieldDescriptor(
          label: 'Practitioner Name',
          value: practitionerName.value,
          confidenceLevel: practitionerName.confidenceLevel,
        ),
        'specialty': TextFieldDescriptor(
          label: 'Specialty',
          value: specialty.value,
          confidenceLevel: specialty.confidenceLevel,
        ),
        'identifier': TextFieldDescriptor(
          label: 'Identifier',
          value: identifier.value,
          confidenceLevel: identifier.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingPractitioner(
        practitionerName: MappedProperty(
            value: newValues['practitionerName'] ?? practitionerName.value),
        specialty:
            MappedProperty(value: newValues['specialty'] ?? specialty.value),
        identifier:
            MappedProperty(value: newValues['identifier'] ?? identifier.value),
      );

  @override
  String get label => 'Practitioner';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        practitionerName: practitionerName.calculateConfidence(inputText),
        specialty: specialty.calculateConfidence(inputText),
        identifier: identifier.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      practitionerName.isValid || specialty.isValid || identifier.isValid;
}
