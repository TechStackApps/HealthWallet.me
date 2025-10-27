import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

part 'mapping_allergy_intolerance.freezed.dart';

@freezed
class MappingAllergyIntolerance
    with _$MappingAllergyIntolerance
    implements MappingResource {
  const MappingAllergyIntolerance._();

  const factory MappingAllergyIntolerance({
    @Default(MappedProperty()) MappedProperty substance,
    @Default(MappedProperty()) MappedProperty manifestation,
    @Default(MappedProperty()) MappedProperty category,
  }) = _MappingAllergyIntolerance;

  factory MappingAllergyIntolerance.fromJson(Map<String, dynamic> json) {
    return MappingAllergyIntolerance(
      substance: MappedProperty(value: json['substance'] ?? ''),
      manifestation: MappedProperty(value: json['manifestation'] ?? ''),
      category: MappedProperty(value: json['category'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => AllergyIntolerance(
        title: substance.value,
        code:
            fhir_r4.CodeableConcept(text: fhir_r4.FhirString(substance.value)),
        reaction: [
          fhir_r4.AllergyIntoleranceReaction(
            manifestation: [
              fhir_r4.CodeableConcept(
                  text: fhir_r4.FhirString(manifestation.value))
            ],
          ),
        ],
        category: [fhir_r4.AllergyIntoleranceCategory.food],
      );

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'substance': TextFieldDescriptor(
          label: 'Substance',
          value: substance.value,
          confidenceLevel: substance.confidenceLevel,
        ),
        'manifestation': TextFieldDescriptor(
          label: 'Manifestation',
          value: manifestation.value,
          confidenceLevel: manifestation.confidenceLevel,
        ),
        'category': TextFieldDescriptor(
          label: 'Category',
          value: category.value,
          confidenceLevel: category.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingAllergyIntolerance(
        substance:
            MappedProperty(value: newValues['substance'] ?? substance.value),
        manifestation: MappedProperty(
            value: newValues['manifestation'] ?? manifestation.value),
        category:
            MappedProperty(value: newValues['category'] ?? category.value),
      );

  @override
  String get label => 'Allergy Intolerance';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        substance: substance.calculateConfidence(inputText),
        manifestation: manifestation.calculateConfidence(inputText),
        category: category.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      substance.isValid || manifestation.isValid || category.isValid;
}
