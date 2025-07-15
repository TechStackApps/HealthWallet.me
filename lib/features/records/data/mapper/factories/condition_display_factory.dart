import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Condition resources
class ConditionDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Condition';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final code = rawResource['code'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        code, 'Unknown Condition');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final severity = rawResource['severity'] as Map<String, dynamic>?;
    final severityText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(severity);

    final verificationStatus =
        rawResource['verificationStatus'] as Map<String, dynamic>?;
    final verificationText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(
            verificationStatus);

    return severityText ?? verificationText;
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    final clinicalStatus =
        rawResource['clinicalStatus'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptTextNullable(
        clinicalStatus);
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final category = rawResource['category'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['onsetDateTime', 'recordedDate']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Body site
    final bodySite = rawResource['bodySite'] as List<dynamic>?;
    final siteText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(bodySite);
    if (siteText != null) {
      additionalInfo.add('Body site: $siteText');
    }

    // Severity
    final severity = rawResource['severity'] as Map<String, dynamic>?;
    final severityText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(severity);
    if (severityText != null) {
      additionalInfo.add('Severity: $severityText');
    }

    // Verification status
    final verificationStatus =
        rawResource['verificationStatus'] as Map<String, dynamic>?;
    final verificationText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(
            verificationStatus);
    if (verificationText != null) {
      additionalInfo.add('Verification: $verificationText');
    }

    // Recorder
    final recorder = rawResource['recorder'] as Map<String, dynamic>?;
    final recorderDisplay =
        BaseDisplayFactory.extractReferenceDisplay(recorder);
    if (recorderDisplay != null) {
      additionalInfo.add('Recorder: $recorderDisplay');
    }

    // Asserter
    final asserter = rawResource['asserter'] as Map<String, dynamic>?;
    final asserterDisplay =
        BaseDisplayFactory.extractReferenceDisplay(asserter);
    if (asserterDisplay != null) {
      additionalInfo.add('Asserter: $asserterDisplay');
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
