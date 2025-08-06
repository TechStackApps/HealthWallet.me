import 'package:health_wallet/features/records/domain/entity/encounter/encounter.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

/// Entity display factory for Encounter resources
class EncounterEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Encounter';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final encounter = entity as Encounter;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(encounter.type);
    if (displayText != null) return displayText;

    return 'Encounter ${encounter.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final encounter = entity as Encounter;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(encounter.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final class_ =
        FhirFieldExtractor.extractCodeableConceptText(encounter.class_);

    return FhirFieldExtractor.joinNonNull([status, class_], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final encounter = entity as Encounter;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(encounter.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Encounters don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final encounter = entity as Encounter;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(encounter.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final encounter = entity as Encounter;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(encounter.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final class_ =
        FhirFieldExtractor.extractCodeableConceptText(encounter.class_);
    if (class_ != null) {
      additionalInfo.add('Class: $class_');
    }

    // ✅ KEEP: Resource-specific logic for period formatting
    final periodText = _formatEncounterPeriod(encounter);
    if (periodText != null) {
      additionalInfo.add('Period: $periodText');
    }

    // ✅ USE: Common pattern for reference display
    final subject =
        FhirFieldExtractor.extractReferenceDisplay(encounter.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    // ✅ USE: Common pattern for reference display
    final serviceProvider =
        FhirFieldExtractor.extractReferenceDisplay(encounter.serviceProvider);
    if (serviceProvider != null) {
      additionalInfo.add('Service Provider: $serviceProvider');
    }

    // ✅ KEEP: Resource-specific logic for multiple participants
    if (encounter.participant?.isNotEmpty == true) {
      for (final participant in encounter.participant!) {
        final individual =
            FhirFieldExtractor.extractReferenceDisplay(participant.individual);
        final type = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
            participant.type);
        if (individual != null || type != null) {
          final participantText =
              FhirFieldExtractor.joinNonNull([individual, type], ' - ');
          if (participantText != null) {
            additionalInfo.add('Participant: $participantText');
          }
        }
      }
    }

    // ✅ KEEP: Resource-specific logic for reason codes
    if (encounter.reasonCode?.isNotEmpty == true) {
      final reasons = encounter.reasonCode!
          .map((r) => FhirFieldExtractor.extractCodeableConceptText(r))
          .where((r) => r != null)
          .join(', ');
      if (reasons.isNotEmpty) {
        additionalInfo.add('Reasons: $reasons');
      }
    }

    return additionalInfo;
  }

  // ✅ KEEP: Resource-specific helper methods for complex field extraction
  String? _formatEncounterPeriod(Encounter encounter) {
    final period = encounter.period;
    if (period?.start != null && period?.end != null) {
      return '${period!.start} - ${period.end}';
    } else if (period?.start != null) {
      return 'From ${period!.start}';
    }
    return null;
  }
}
