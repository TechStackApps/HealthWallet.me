import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_allergy_intolerance.freezed.dart';

@freezed
class MappingAllergyIntolerance
    with _$MappingAllergyIntolerance
    implements MappingResource {
  const MappingAllergyIntolerance._();

  const factory MappingAllergyIntolerance({
    @Default('') String substance,
    @Default('') String manifestation,
    @Default('') String category,
  }) = _MappingAllergyIntolerance;

  factory MappingAllergyIntolerance.fromJson(Map<String, dynamic> json) {
    return MappingAllergyIntolerance(
      substance: json['substance'] ?? '',
      manifestation: json['manifestation'] ?? '',
      category: json['category'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const AllergyIntolerance();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'substance': TextFieldDescriptor(label: 'Substance', value: substance),
        'manifestation':
            TextFieldDescriptor(label: 'Manifestation', value: manifestation),
        'category': TextFieldDescriptor(label: 'Category', value: category),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingAllergyIntolerance(
        substance: newValues['substance'] ?? substance,
        manifestation: newValues['manifestation'] ?? manifestation,
        category: newValues['category'] ?? category,
      );

  @override
  String get label => 'Allergy Intolerance';
}
