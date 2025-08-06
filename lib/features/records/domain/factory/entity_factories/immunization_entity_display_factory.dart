import 'package:health_wallet/features/records/domain/entity/immunization/immunization.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

/// Entity display factory for Immunization resources
class ImmunizationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Immunization';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final immunization = entity as Immunization;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(immunization.vaccineCode);
    if (displayText != null) return displayText;

    return 'Immunization ${immunization.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final immunization = entity as Immunization;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(immunization.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final lotNumber = immunization.lotNumber?.toString();

    return FhirFieldExtractor.joinNonNull([status, lotNumber], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final immunization = entity as Immunization;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(immunization.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Immunizations don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final immunization = entity as Immunization;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(immunization.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final immunization = entity as Immunization;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(immunization.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final vaccineCode =
        FhirFieldExtractor.extractCodeableConceptText(immunization.vaccineCode);
    if (vaccineCode != null) {
      additionalInfo.add('Vaccine: $vaccineCode');
    }

    // ✅ KEEP: Resource-specific logic for occurrence date
    final occurrenceDate = _extractOccurrenceDate(immunization);
    if (occurrenceDate != null) {
      additionalInfo.add('Occurrence: $occurrenceDate');
    }

    // ✅ KEEP: Resource-specific logic for lot number
    final lotNumber = immunization.lotNumber?.toString();
    if (lotNumber != null) {
      additionalInfo.add('Lot Number: $lotNumber');
    }

    // ✅ USE: Common pattern for reference display
    final patient =
        FhirFieldExtractor.extractReferenceDisplay(immunization.patient);
    if (patient != null) {
      additionalInfo.add('Patient: $patient');
    }

    // ✅ USE: Common pattern for reference display
    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(immunization.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    // ✅ KEEP: Resource-specific logic for performer
    if (immunization.performer?.isNotEmpty == true) {
      for (final performer in immunization.performer!) {
        final actor =
            FhirFieldExtractor.extractReferenceDisplay(performer.actor);
        if (actor != null) {
          additionalInfo.add('Performer: $actor');
        }
      }
    }

    // ✅ KEEP: Resource-specific logic for manufacturer
    final manufacturer =
        FhirFieldExtractor.extractReferenceDisplay(immunization.manufacturer);
    if (manufacturer != null) {
      additionalInfo.add('Manufacturer: $manufacturer');
    }

    // ✅ KEEP: Resource-specific logic for expiration date
    final expirationDate =
        FhirFieldExtractor.extractDate(immunization.expirationDate);
    if (expirationDate != null) {
      additionalInfo.add('Expiration: $expirationDate');
    }

    return additionalInfo;
  }

  // ✅ KEEP: Resource-specific helper methods for complex field extraction
  String? _extractOccurrenceDate(Immunization immunization) {
    final occurrenceX = immunization.occurrenceX;
    if (occurrenceX is fhir_r4.FhirDateTime) {
      return occurrenceX.toString();
    } else if (occurrenceX is fhir_r4.FhirDate) {
      return occurrenceX.toString();
    } else if (occurrenceX is fhir_r4.FhirString) {
      return occurrenceX.toString();
    }
    return null;
  }
}
