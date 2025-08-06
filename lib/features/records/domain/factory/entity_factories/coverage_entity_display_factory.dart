import 'package:health_wallet/features/records/domain/entity/coverage/coverage.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Coverage resources
class CoverageEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Coverage';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final coverage = entity as Coverage;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            coverage.type);
    if (displayText != null) return displayText;

    return 'Coverage ${coverage.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final coverage = entity as Coverage;

    final status = coverage.status?.toString();
    final type = BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
        coverage.type);

    return BaseEntityDisplayFactory.joinNonNull([status, type], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final coverage = entity as Coverage;
    return coverage.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Coverage doesn't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final coverage = entity as Coverage;
    // Use the date field from the entity
    return coverage.date?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final coverage = entity as Coverage;
    final additionalInfo = <String>[];

    // Status
    final status = coverage.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Type
    final type = BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
        coverage.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Subscriber
    if (coverage.subscriber?.display != null) {
      additionalInfo.add('Subscriber: ${coverage.subscriber!.display}');
    }

    // Beneficiary
    if (coverage.beneficiary?.display != null) {
      additionalInfo.add('Beneficiary: ${coverage.beneficiary!.display}');
    }

    // Payor
    if (coverage.payor != null && coverage.payor!.isNotEmpty) {
      final payorNames = coverage.payor!
          .where((p) => p.display != null)
          .map((p) => p.display!)
          .join(', ');
      if (payorNames.isNotEmpty) {
        additionalInfo.add('Payor: $payorNames');
      }
    }

    // Period
    if (coverage.period?.start != null) {
      additionalInfo.add('Start: ${coverage.period!.start}');
    }

    // Cost to beneficiary
    if (coverage.costToBeneficiary != null &&
        coverage.costToBeneficiary!.isNotEmpty) {
      final costInfo = coverage.costToBeneficiary!
          .where((c) => c.type?.text != null)
          .map((c) => c.type!.text!)
          .join(', ');
      if (costInfo.isNotEmpty) {
        additionalInfo.add('Cost: $costInfo');
      }
    }

    return additionalInfo;
  }
}
