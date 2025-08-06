import 'package:health_wallet/features/records/domain/entity/observation/observation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

/// Entity display factory for Observation resources
class ObservationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Observation';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final observation = entity as Observation;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(observation.code);
    if (displayText != null) return displayText;

    return 'Observation ${observation.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final observation = entity as Observation;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(observation.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);

    return FhirFieldExtractor.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final observation = entity as Observation;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(observation.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final observation = entity as Observation;
    // ✅ USE: Common pattern for CodeableConcept extraction
    return FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final observation = entity as Observation;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(observation.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final observation = entity as Observation;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(observation.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // ✅ KEEP: Resource-specific logic for valueX extraction
    final valueText = _extractObservationValue(observation);
    if (valueText != null) {
      additionalInfo.add('Value: $valueText');
    }

    // ✅ KEEP: Resource-specific logic for effective date
    final effectiveDate = _extractEffectiveDate(observation);
    if (effectiveDate != null) {
      additionalInfo.add('Effective: $effectiveDate');
    }

    // ✅ KEEP: Resource-specific logic for issued date
    final issuedDate = FhirFieldExtractor.extractDate(observation.issued);
    if (issuedDate != null) {
      additionalInfo.add('Issued: $issuedDate');
    }

    // ✅ KEEP: Resource-specific logic for multiple performers
    if (observation.performer?.isNotEmpty == true) {
      final performers = FhirFieldExtractor.extractMultipleReferenceDisplays(
          observation.performer);
      if (performers != null) {
        additionalInfo.add('Performers: $performers');
      }
    }

    // ✅ USE: Common pattern for reference display
    final subject =
        FhirFieldExtractor.extractReferenceDisplay(observation.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    // ✅ USE: Common pattern for reference display
    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(observation.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    return additionalInfo;
  }

  // ✅ KEEP: Resource-specific helper methods for complex field extraction
  String? _extractObservationValue(Observation observation) {
    final valueX = observation.valueX;
    if (valueX is fhir_r4.Quantity) {
      final unit = valueX.unit?.toString() ?? '';
      return '${valueX.value} $unit';
    } else if (valueX is fhir_r4.CodeableConcept) {
      return FhirFieldExtractor.extractCodeableConceptText(valueX);
    } else if (valueX is fhir_r4.FhirString) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirBoolean) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirInteger) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirDecimal) {
      return valueX.toString();
    }
    return valueX?.toString();
  }

  String? _extractEffectiveDate(Observation observation) {
    final effectiveX = observation.effectiveX;
    if (effectiveX is fhir_r4.FhirDateTime) {
      return effectiveX.toString();
    } else if (effectiveX is fhir_r4.Period) {
      if (effectiveX.start != null) {
        return effectiveX.start.toString();
      }
    } else if (effectiveX is fhir_r4.FhirDate) {
      return effectiveX.toString();
    }
    return null;
  }
}
