import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

/// Entity display factory for Procedure resources
class ProcedureEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Procedure';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final procedure = entity as Procedure;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(procedure.code);
    if (displayText != null) return displayText;

    return 'Procedure ${procedure.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final procedure = entity as Procedure;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(procedure.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final category =
        FhirFieldExtractor.extractCodeableConceptText(procedure.category);

    return FhirFieldExtractor.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final procedure = entity as Procedure;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(procedure.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final procedure = entity as Procedure;
    // ✅ USE: Common pattern for CodeableConcept extraction
    return FhirFieldExtractor.extractCodeableConceptText(procedure.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final procedure = entity as Procedure;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(procedure.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final procedure = entity as Procedure;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(procedure.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final category =
        FhirFieldExtractor.extractCodeableConceptText(procedure.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // ✅ KEEP: Resource-specific logic for performed date
    final performedDate = _extractPerformedDate(procedure);
    if (performedDate != null) {
      additionalInfo.add('Performed: $performedDate');
    }

    // ✅ USE: Common pattern for reference display
    final subject =
        FhirFieldExtractor.extractReferenceDisplay(procedure.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    // ✅ USE: Common pattern for reference display
    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(procedure.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    // ✅ KEEP: Resource-specific logic for multiple performers
    if (procedure.performer?.isNotEmpty == true) {
      for (final performer in procedure.performer!) {
        final actor =
            FhirFieldExtractor.extractReferenceDisplay(performer.actor);
        if (actor != null) {
          additionalInfo.add('Performer: $actor');
        }
      }
    }

    // ✅ KEEP: Resource-specific logic for reason codes
    if (procedure.reasonCode?.isNotEmpty == true) {
      final reasons = procedure.reasonCode!
          .map((r) => FhirFieldExtractor.extractCodeableConceptText(r))
          .where((r) => r != null)
          .join(', ');
      if (reasons.isNotEmpty) {
        additionalInfo.add('Reasons: $reasons');
      }
    }

    // ✅ KEEP: Resource-specific logic for outcome
    final outcome =
        FhirFieldExtractor.extractCodeableConceptText(procedure.outcome);
    if (outcome != null) {
      additionalInfo.add('Outcome: $outcome');
    }

    return additionalInfo;
  }

  // ✅ KEEP: Resource-specific helper methods for complex field extraction
  String? _extractPerformedDate(Procedure procedure) {
    final performedX = procedure.performedX;
    if (performedX is fhir_r4.FhirDateTime) {
      return performedX.toString();
    } else if (performedX is fhir_r4.Period) {
      if (performedX.start != null) {
        return performedX.start.toString();
      }
    } else if (performedX is fhir_r4.FhirDate) {
      return performedX.toString();
    }
    return null;
  }
}
