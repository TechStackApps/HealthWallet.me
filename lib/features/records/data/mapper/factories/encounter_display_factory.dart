import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Encounter resources
class EncounterDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Encounter';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    // Extract encounter type from the type field (like backup version)
    final type = rawResource['type'] as List<dynamic>?;
    if (type != null && type.isNotEmpty) {
      final firstType = type.first as Map<String, dynamic>;
      final text = firstType['text'] as String?;
      if (text != null && text.isNotEmpty) return text;

      final coding = firstType['coding'] as List<dynamic>?;
      if (coding != null && coding.isNotEmpty) {
        final firstCoding = coding.first as Map<String, dynamic>;
        final display = firstCoding['display'] as String?;
        if (display != null && display.isNotEmpty) return display;
      }
    }

    // Fallback to class display
    final classDisplay = rawResource['class']?['display'] as String?;
    return classDisplay ?? 'Encounter';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    // Use patient name as secondary display (like backup version)
    final resolvedPatient =
        rawResource['_resolved_patient'] as Map<String, dynamic>?;
    if (resolvedPatient != null) {
      final patientName = _extractPatientName(resolvedPatient);
      if (patientName != null) return patientName;
    }

    // Fallback to status
    final status = rawResource['status'] as String?;
    final period = rawResource['period'] as Map<String, dynamic>?;
    final startDate = period?['start'] as String?;

    return BaseDisplayFactory.joinNonNull([status, startDate], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final classInfo = rawResource['class'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptTextNullable(classInfo);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    final period = rawResource['period'] as Map<String, dynamic>?;
    return period?['start'] as String?;
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // End date
    final period = rawResource['period'] as Map<String, dynamic>?;
    final endDate = period?['end'] as String?;
    if (endDate != null) {
      additionalInfo.add('End Date: $endDate');
    }

    // Class
    final classCode = rawResource['class']?['display'] as String?;
    if (classCode != null) {
      additionalInfo.add('Class: $classCode');
    }

    // Priority
    final priority = rawResource['priority'] as Map<String, dynamic>?;
    final priorityText =
        BaseDisplayFactory.extractCodeableConceptTextNullable(priority);
    if (priorityText != null) {
      additionalInfo.add('Priority: $priorityText');
    }

    // Service provider
    final serviceProvider =
        rawResource['serviceProvider'] as Map<String, dynamic>?;
    final providerDisplay =
        BaseDisplayFactory.extractReferenceDisplay(serviceProvider);
    if (providerDisplay != null) {
      additionalInfo.add('Provider: $providerDisplay');
    }

    // Reason
    final reasonCode = rawResource['reasonCode'] as List<dynamic>?;
    final reasonText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(reasonCode);
    if (reasonText != null) {
      additionalInfo.add('Reason: $reasonText');
    }

    return additionalInfo;
  }

  /// Extract patient name from resolved patient resource
  String? _extractPatientName(Map<String, dynamic> patient) {
    final name = patient['name'] as List<dynamic>?;
    if (name != null && name.isNotEmpty) {
      final firstName = name.first as Map<String, dynamic>;
      final given = firstName['given'] as List<dynamic>?;
      final family = firstName['family'] as String?;

      final givenNames = given?.cast<String>().join(' ') ?? '';
      final fullName = '$givenNames $family'.trim();
      return fullName.isNotEmpty ? fullName : null;
    }
    return null;
  }
}
