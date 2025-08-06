import 'package:health_wallet/features/records/domain/entity/condition/condition.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

/// Entity display factory for Condition resources
class ConditionEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Condition';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final condition = entity as Condition;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(condition.code);
    if (displayText != null) return displayText;

    return 'Condition ${condition.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final condition = entity as Condition;

    // ✅ USE: Common pattern for status extraction
    final clinicalStatus =
        FhirFieldExtractor.extractCodeableConceptText(condition.clinicalStatus);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        condition.category);

    return FhirFieldExtractor.joinNonNull([clinicalStatus, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final condition = entity as Condition;
    // ✅ USE: Common pattern for CodeableConcept extraction
    return FhirFieldExtractor.extractCodeableConceptText(
        condition.clinicalStatus);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final condition = entity as Condition;
    // ✅ USE: Common pattern for CodeableConcept extraction
    return FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        condition.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final condition = entity as Condition;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(condition.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final condition = entity as Condition;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for CodeableConcept extraction
    final clinicalStatus =
        FhirFieldExtractor.extractCodeableConceptText(condition.clinicalStatus);
    if (clinicalStatus != null) {
      additionalInfo.add('Clinical Status: $clinicalStatus');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final verificationStatus = FhirFieldExtractor.extractCodeableConceptText(
        condition.verificationStatus);
    if (verificationStatus != null) {
      additionalInfo.add('Verification Status: $verificationStatus');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        condition.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final severity =
        FhirFieldExtractor.extractCodeableConceptText(condition.severity);
    if (severity != null) {
      additionalInfo.add('Severity: $severity');
    }

    // ✅ USE: Common pattern for reference display
    final subject =
        FhirFieldExtractor.extractReferenceDisplay(condition.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    // ✅ USE: Common pattern for reference display
    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(condition.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    // ✅ KEEP: Resource-specific logic for onset date
    final onsetDate = _extractOnsetDate(condition);
    if (onsetDate != null) {
      additionalInfo.add('Onset: $onsetDate');
    }

    // ✅ KEEP: Resource-specific logic for abatement date
    final abatementDate = _extractAbatementDate(condition);
    if (abatementDate != null) {
      additionalInfo.add('Abatement: $abatementDate');
    }

    // ✅ KEEP: Resource-specific logic for multiple body sites
    if (condition.bodySite?.isNotEmpty == true) {
      final bodySites = condition.bodySite!
          .map((s) => FhirFieldExtractor.extractCodeableConceptText(s))
          .where((s) => s != null)
          .join(', ');
      if (bodySites.isNotEmpty) {
        additionalInfo.add('Body Sites: $bodySites');
      }
    }

    return additionalInfo;
  }

  // ✅ KEEP: Resource-specific helper methods for complex field extraction
  String? _extractOnsetDate(Condition condition) {
    final onsetX = condition.onsetX;
    if (onsetX is fhir_r4.FhirDateTime) {
      return onsetX.toString();
    } else if (onsetX is fhir_r4.FhirDate) {
      return onsetX.toString();
    } else if (onsetX is fhir_r4.Period) {
      if (onsetX.start != null) {
        return onsetX.start.toString();
      }
    }
    return null;
  }

  String? _extractAbatementDate(Condition condition) {
    final abatementX = condition.abatementX;
    if (abatementX is fhir_r4.FhirDateTime) {
      return abatementX.toString();
    } else if (abatementX is fhir_r4.FhirDate) {
      return abatementX.toString();
    } else if (abatementX is fhir_r4.Period) {
      if (abatementX.start != null) {
        return abatementX.start.toString();
      }
    }
    return null;
  }
}
