import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Goal resources
class GoalDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Goal';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final description = rawResource['description'] as Map<String, dynamic>?;
    if (description != null) {
      return BaseDisplayFactory.extractCodeableConceptText(description, 'Goal');
    }

    final category = rawResource['category'] as List<dynamic>?;
    final categoryText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);
    return categoryText ?? 'Goal';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['lifecycleStatus'] as String?;
    final priority = rawResource['priority'] as Map<String, dynamic>?;
    final priorityText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(priority);

    return BaseDisplayFactory.joinNonNull([status, priorityText], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['lifecycleStatus'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final category = rawResource['category'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['startDate', 'statusDate']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Priority
    final priority = rawResource['priority'] as Map<String, dynamic>?;
    final priorityText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(priority);
    if (priorityText != null) {
      additionalInfo.add('Priority: $priorityText');
    }

    // Achievement status
    final achievementStatus =
        rawResource['achievementStatus'] as Map<String, dynamic>?;
    final achievementText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(
            achievementStatus);
    if (achievementText != null) {
      additionalInfo.add('Achievement: $achievementText');
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
