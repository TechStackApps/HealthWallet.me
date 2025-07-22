import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for AllergyIntolerance resources
class AllergyIntoleranceDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'AllergyIntolerance';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final code = rawResource['code'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        code, 'Unknown Substance');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final reaction = rawResource['reaction'] as List<dynamic>?;
    final firstReaction = reaction != null && reaction.isNotEmpty
        ? reaction.first as Map<String, dynamic>
        : null;
    final manifestation = firstReaction?['manifestation'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(
        manifestation);
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
    return category != null && category.isNotEmpty
        ? category.first as String?
        : null;
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['onsetDateTime', 'recordedDate', 'assertedDate']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Criticality
    final criticality = rawResource['criticality'] as String?;
    if (criticality != null) {
      additionalInfo.add('Criticality: $criticality');
    }

    // Severity
    final reaction = rawResource['reaction'] as List<dynamic>?;
    final firstReaction = reaction != null && reaction.isNotEmpty
        ? reaction.first as Map<String, dynamic>
        : null;
    final severity = firstReaction?['severity'] as String?;
    if (severity != null) {
      additionalInfo.add('Severity: $severity');
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

    // Type (allergy vs intolerance)
    final type = rawResource['type'] as String?;
    if (type != null) {
      additionalInfo.add('Type: $type');
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

    // Note
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
