import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Immunization resources
class ImmunizationDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Immunization';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final vaccineCode = rawResource['vaccineCode'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        vaccineCode, 'Unknown Vaccine');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final lotNumber = rawResource['lotNumber'] as String?;

    return BaseDisplayFactory.joinNonNull([status, lotNumber], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    return null; // Immunizations don't typically have categories
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['occurrenceDateTime', 'recorded']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Lot number
    final lotNumber = rawResource['lotNumber'] as String?;
    if (lotNumber != null) {
      additionalInfo.add('Lot: $lotNumber');
    }

    // Manufacturer
    final manufacturer = rawResource['manufacturer'] as Map<String, dynamic>?;
    final manufacturerDisplay =
        BaseDisplayFactory.extractReferenceDisplay(manufacturer);
    if (manufacturerDisplay != null) {
      additionalInfo.add('Manufacturer: $manufacturerDisplay');
    }

    // Route
    final route = rawResource['route'] as Map<String, dynamic>?;
    final routeText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(route);
    if (routeText != null) {
      additionalInfo.add('Route: $routeText');
    }

    // Dose quantity
    final doseQuantity = rawResource['doseQuantity'] as Map<String, dynamic>?;
    if (doseQuantity != null) {
      final value = doseQuantity['value'];
      final unit = doseQuantity['unit'] ?? doseQuantity['code'];
      additionalInfo.add('Dose: $value $unit');
    }

    // Performer
    final performer = rawResource['performer'] as List<dynamic>?;
    final performerDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(performer);
    if (performerDisplay != null) {
      additionalInfo.add('Performer: $performerDisplay');
    }

    return additionalInfo;
  }
}
