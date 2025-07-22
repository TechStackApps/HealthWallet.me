import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Procedure resources
class ProcedureDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Procedure';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final code = rawResource['code'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        code, 'Unknown Procedure');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final category = rawResource['category'] as Map<String, dynamic>?;
    final categoryText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(category);

    return BaseDisplayFactory.joinNonNull([status, categoryText], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final category = rawResource['category'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptTextNullable(category);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['performedDateTime', 'performedPeriod']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Outcome
    final outcome = rawResource['outcome'] as Map<String, dynamic>?;
    final outcomeText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(outcome);
    if (outcomeText != null) {
      additionalInfo.add('Outcome: $outcomeText');
    }

    // Body site
    final bodySite = rawResource['bodySite'] as List<dynamic>?;
    final siteText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(bodySite);
    if (siteText != null) {
      additionalInfo.add('Body site: $siteText');
    }

    // Performer
    final performer = rawResource['performer'] as List<dynamic>?;
    final performerDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(performer);
    if (performerDisplay != null) {
      additionalInfo.add('Performer: $performerDisplay');
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
