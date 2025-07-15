import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for CarePlan resources
class CarePlanDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'CarePlan';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final title = rawResource['title'] as String?;
    if (title != null) return title;

    final category = rawResource['category'] as List<dynamic>?;
    final categoryText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);
    return categoryText ?? 'Care Plan';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final intent = rawResource['intent'] as String?;

    return BaseDisplayFactory.joinNonNull([status, intent], ' • ');
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
        rawResource, ['created', 'period']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Intent
    final intent = rawResource['intent'] as String?;
    if (intent != null) {
      additionalInfo.add('Intent: $intent');
    }

    // Description
    final description = rawResource['description'] as String?;
    if (description != null) {
      additionalInfo.add('Description: $description');
    }

    // Author
    final author = rawResource['author'] as Map<String, dynamic>?;
    final authorDisplay = BaseDisplayFactory.extractReferenceDisplay(author);
    if (authorDisplay != null) {
      additionalInfo.add('Author: $authorDisplay');
    }

    return additionalInfo;
  }
}
