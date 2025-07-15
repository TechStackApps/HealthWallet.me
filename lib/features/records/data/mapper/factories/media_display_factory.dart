import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Media resources
class MediaDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Media';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final content = rawResource['content'] as Map<String, dynamic>?;
    final title = content?['title'] as String?;
    if (title != null) return title;

    final type = rawResource['type'] as Map<String, dynamic>?;
    if (type != null) {
      return BaseDisplayFactory.extractCodeableConceptText(type, 'Media');
    }

    return 'Media';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final content = rawResource['content'] as Map<String, dynamic>?;
    final contentType = content?['contentType'] as String?;

    return BaseDisplayFactory.joinNonNull([status, contentType], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptTextNullable(type);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return BaseDisplayFactory.extractFirstAvailableDate(
        rawResource, ['createdDateTime', 'issued']);
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Content type
    final content = rawResource['content'] as Map<String, dynamic>?;
    final contentType = content?['contentType'] as String?;
    if (contentType != null) {
      additionalInfo.add('Type: $contentType');
    }

    // Size
    final size = content?['size'] as int?;
    if (size != null) {
      additionalInfo.add('Size: ${_formatBytes(size)}');
    }

    // Duration
    final duration = content?['duration'] as int?;
    if (duration != null) {
      additionalInfo.add('Duration: ${duration}s');
    }

    // Device
    final device = rawResource['device'] as Map<String, dynamic>?;
    final deviceDisplay = BaseDisplayFactory.extractReferenceDisplay(device);
    if (deviceDisplay != null) {
      additionalInfo.add('Device: $deviceDisplay');
    }

    // Operator
    final operator = rawResource['operator'] as Map<String, dynamic>?;
    final operatorDisplay =
        BaseDisplayFactory.extractReferenceDisplay(operator);
    if (operatorDisplay != null) {
      additionalInfo.add('Operator: $operatorDisplay');
    }

    return additionalInfo;
  }

  /// Format bytes to human readable string
  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
