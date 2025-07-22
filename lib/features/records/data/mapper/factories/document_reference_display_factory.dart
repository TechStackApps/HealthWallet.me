import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for DocumentReference resources
class DocumentReferenceDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'DocumentReference';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as Map<String, dynamic>?;
    if (type != null) {
      return BaseDisplayFactory.extractCodeableConceptText(type, 'Document');
    }

    final description = rawResource['description'] as String?;
    return description ?? 'Document';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final description = rawResource['description'] as String?;

    return BaseDisplayFactory.joinNonNull([status, description], ' • ');
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
        rawResource, ['date', 'created']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Description
    final description = rawResource['description'] as String?;
    if (description != null) {
      additionalInfo.add('Description: $description');
    }

    // Security label
    final securityLabel = rawResource['securityLabel'] as List<dynamic>?;
    final securityText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(securityLabel);
    if (securityText != null) {
      additionalInfo.add('Security: $securityText');
    }

    // Author
    final author = rawResource['author'] as List<dynamic>?;
    final authorDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(author);
    if (authorDisplay != null) {
      additionalInfo.add('Author: $authorDisplay');
    }

    // Content type
    final content = rawResource['content'] as List<dynamic>?;
    if (content != null && content.isNotEmpty) {
      final attachment = (content.first as Map<String, dynamic>)['attachment']
          as Map<String, dynamic>?;
      final contentType = attachment?['contentType'] as String?;
      if (contentType != null) {
        additionalInfo.add('Type: $contentType');
      }
    }

    return additionalInfo;
  }
}
