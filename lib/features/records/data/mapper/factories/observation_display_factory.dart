import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Observation resources
class ObservationDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Observation';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final code = rawResource['code'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        code, 'Unknown Observation');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final valueQuantity = rawResource['valueQuantity'] as Map<String, dynamic>?;
    if (valueQuantity != null) {
      final value = valueQuantity['value'];
      final unit = valueQuantity['unit'] ?? valueQuantity['code'];
      return '$value $unit';
    }

    final valueString = rawResource['valueString'] as String?;
    if (valueString != null) {
      return valueString;
    }

    final valueCodeableConcept =
        rawResource['valueCodeableConcept'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptTextNullable(
        valueCodeableConcept);
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final category = rawResource['category'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['effectiveDateTime', 'issued']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Reference range
    final referenceRange = rawResource['referenceRange'] as List<dynamic>?;
    if (referenceRange != null && referenceRange.isNotEmpty) {
      final range = referenceRange.first as Map<String, dynamic>;
      final low = range['low']?['value'];
      final high = range['high']?['value'];
      final unit = range['low']?['unit'] ?? range['high']?['unit'];
      if (low != null && high != null) {
        additionalInfo.add('Reference: $low-$high $unit');
      }
    }

    // Interpretation
    final interpretation = rawResource['interpretation'] as List<dynamic>?;
    final interpretationText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(interpretation);
    if (interpretationText != null) {
      additionalInfo.add('Interpretation: $interpretationText');
    }

    // Performer
    final performer = rawResource['performer'] as List<dynamic>?;
    final performerDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(performer);
    if (performerDisplay != null) {
      additionalInfo.add('Performer: $performerDisplay');
    }

    // Method
    final method = rawResource['method'] as Map<String, dynamic>?;
    final methodText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(method);
    if (methodText != null) {
      additionalInfo.add('Method: $methodText');
    }

    // Notes
    final note = rawResource['note'] as List<dynamic>?;
    if (note != null && note.isNotEmpty) {
      final noteText = (note.first as Map<String, dynamic>)['text'] as String?;
      if (noteText != null) {
        additionalInfo.add('Note: $noteText');
      }
    }

    return additionalInfo;
  }
}
