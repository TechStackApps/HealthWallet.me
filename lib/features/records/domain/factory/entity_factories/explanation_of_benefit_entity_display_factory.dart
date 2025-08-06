import 'package:health_wallet/features/records/domain/entity/explanation_of_benefit/explanation_of_benefit.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for ExplanationOfBenefit resources
class ExplanationOfBenefitEntityDisplayFactory
    extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'ExplanationOfBenefit';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final eob = entity as ExplanationOfBenefit;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(eob.type);
    if (displayText != null) return displayText;

    return 'Explanation of Benefit ${eob.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final eob = entity as ExplanationOfBenefit;

    final status = eob.status;
    final use = eob.use;

    return BaseEntityDisplayFactory.joinNonNull([status, use], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final eob = entity as ExplanationOfBenefit;
    return eob.status;
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // ExplanationOfBenefit doesn't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final eob = entity as ExplanationOfBenefit;
    // Use the date field from the entity
    return eob.date?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final eob = entity as ExplanationOfBenefit;
    final additionalInfo = <String>[];

    // Status
    final status = eob.status;
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Type
    final type =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(eob.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Use
    final use = eob.use;
    if (use != null) {
      additionalInfo.add('Use: $use');
    }

    // Created date
    final createdDate = extractDate(entity);
    if (createdDate != null) {
      additionalInfo.add('Created: $createdDate');
    }

    // Patient
    if (eob.patient?.display != null) {
      additionalInfo.add('Patient: ${eob.patient!.display}');
    }

    // Provider
    if (eob.provider?.display != null) {
      additionalInfo.add('Provider: ${eob.provider!.display}');
    }

    // Insurer
    if (eob.insurer?.display != null) {
      additionalInfo.add('Insurer: ${eob.insurer!.display}');
    }

    // Outcome
    final outcome = eob.outcome;
    if (outcome != null) {
      additionalInfo.add('Outcome: $outcome');
    }

    // Disposition
    final disposition = eob.disposition;
    if (disposition != null) {
      additionalInfo.add('Disposition: $disposition');
    }

    // Total amount
    if (eob.total != null && eob.total!.isNotEmpty) {
      final totalAmounts = eob.total!
          .where((t) => t.amount?.value != null)
          .map((t) =>
              '${t.amount!.value} ${t.amount!.currency?.toString() ?? 'USD'}')
          .join(', ');
      if (totalAmounts.isNotEmpty) {
        additionalInfo.add('Total: $totalAmounts');
      }
    }

    return additionalInfo;
  }
}
