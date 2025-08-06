import 'package:health_wallet/features/records/domain/entity/medication/medication.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';

/// Entity display factory for Medication resources
class MedicationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Medication';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final medication = entity as Medication;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(medication.code);
    if (displayText != null) return displayText;

    return 'Medication ${medication.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final medication = entity as Medication;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(medication.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final form = FhirFieldExtractor.extractCodeableConceptText(medication.form);

    return FhirFieldExtractor.joinNonNull([status, form], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final medication = entity as Medication;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(medication.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Medications don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Medications don't have a specific date
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final medication = entity as Medication;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(medication.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final form = FhirFieldExtractor.extractCodeableConceptText(medication.form);
    if (form != null) {
      additionalInfo.add('Form: $form');
    }

    // ✅ USE: Common pattern for reference display
    final manufacturer =
        FhirFieldExtractor.extractReferenceDisplay(medication.manufacturer);
    if (manufacturer != null) {
      additionalInfo.add('Manufacturer: $manufacturer');
    }

    // ✅ KEEP: Resource-specific logic for multiple ingredients
    if (medication.ingredient?.isNotEmpty == true) {
      for (final ingredient in medication.ingredient!) {
        final item = FhirFieldExtractor.extractCodeableConceptText(
            ingredient.itemCodeableConcept);
        final strength = ingredient.strength?.toString();
        if (item != null || strength != null) {
          final ingredientText =
              FhirFieldExtractor.joinNonNull([item, strength], ' - ');
          if (ingredientText != null) {
            additionalInfo.add('Ingredient: $ingredientText');
          }
        }
      }
    }

    // ✅ KEEP: Resource-specific logic for batch information
    if (medication.batch?.lotNumber != null) {
      additionalInfo.add('Batch: ${medication.batch!.lotNumber}');
    }

    return additionalInfo;
  }
}
