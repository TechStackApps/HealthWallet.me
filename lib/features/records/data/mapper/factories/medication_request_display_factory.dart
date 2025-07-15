import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for MedicationRequest resources
class MedicationRequestDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'MedicationRequest';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final medication =
        rawResource['medicationCodeableConcept'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        medication, 'Unknown Medication');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final dosage = rawResource['dosageInstruction'] as List<dynamic>?;
    final dosageText = dosage != null && dosage.isNotEmpty
        ? (dosage.first as Map<String, dynamic>)['text'] as String?
        : null;

    return BaseDisplayFactory.joinNonNull([status, dosageText], ' • ');
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
        rawResource, ['authoredOn', 'dispenseRequest']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Priority
    final priority = rawResource['priority'] as String?;
    if (priority != null) {
      additionalInfo.add('Priority: $priority');
    }

    // Intent
    final intent = rawResource['intent'] as String?;
    if (intent != null) {
      additionalInfo.add('Intent: $intent');
    }

    // Requester
    final requester = rawResource['requester'] as Map<String, dynamic>?;
    final requesterDisplay =
        BaseDisplayFactory.extractReferenceDisplay(requester);
    if (requesterDisplay != null) {
      additionalInfo.add('Requester: $requesterDisplay');
    }

    // Recorder
    final recorder = rawResource['recorder'] as Map<String, dynamic>?;
    final recorderDisplay =
        BaseDisplayFactory.extractReferenceDisplay(recorder);
    if (recorderDisplay != null) {
      additionalInfo.add('Recorder: $recorderDisplay');
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
