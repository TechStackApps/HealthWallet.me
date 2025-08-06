import 'package:health_wallet/features/records/domain/entity/claim/claim.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';

/// Entity display factory for Claim resources
class ClaimEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Claim';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final claim = entity as Claim;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(claim.type);
    if (displayText != null) return displayText;

    return 'Claim ${claim.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final claim = entity as Claim;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(claim.status);
    final use = FhirFieldExtractor.extractStatus(claim.use);

    return FhirFieldExtractor.joinNonNull([status, use], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final claim = entity as Claim;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(claim.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Claims don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final claim = entity as Claim;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(claim.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final claim = entity as Claim;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(claim.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final type = FhirFieldExtractor.extractCodeableConceptText(claim.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // ✅ USE: Common pattern for status extraction
    final use = FhirFieldExtractor.extractStatus(claim.use);
    if (use != null) {
      additionalInfo.add('Use: $use');
    }

    // ✅ KEEP: Resource-specific logic for created date
    final createdDate = FhirFieldExtractor.extractDate(claim.date);
    if (createdDate != null) {
      additionalInfo.add('Created: $createdDate');
    }

    // ✅ USE: Common pattern for reference display
    final patient = FhirFieldExtractor.extractReferenceDisplay(claim.patient);
    if (patient != null) {
      additionalInfo.add('Patient: $patient');
    }

    // ✅ USE: Common pattern for reference display
    final provider = FhirFieldExtractor.extractReferenceDisplay(claim.provider);
    if (provider != null) {
      additionalInfo.add('Provider: $provider');
    }

    // ✅ USE: Common pattern for reference display
    final insurer = FhirFieldExtractor.extractReferenceDisplay(claim.insurer);
    if (insurer != null) {
      additionalInfo.add('Insurer: $insurer');
    }

    // ✅ KEEP: Resource-specific logic for total amount formatting
    if (claim.total?.value != null) {
      final currency = claim.total!.currency?.toString() ?? 'USD';
      additionalInfo.add('Total: ${claim.total!.value} $currency');
    }

    // ✅ KEEP: Resource-specific logic for priority
    final priority =
        FhirFieldExtractor.extractCodeableConceptText(claim.priority);
    if (priority != null) {
      additionalInfo.add('Priority: $priority');
    }

    // ✅ KEEP: Resource-specific logic for billable period
    if (claim.billablePeriod?.start != null) {
      additionalInfo.add('Billable Start: ${claim.billablePeriod!.start}');
    }

    return additionalInfo;
  }
}
