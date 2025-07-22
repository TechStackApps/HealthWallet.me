import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for DiagnosticReport resources
class DiagnosticReportDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'DiagnosticReport';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final code = rawResource['code'] as Map<String, dynamic>?;
    return BaseDisplayFactory.extractCodeableConceptText(
        code, 'Diagnostic Report');
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final status = rawResource['status'] as String?;
    final category = rawResource['category'] as List<dynamic>?;
    final categoryText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(category);

    return BaseDisplayFactory.joinNonNull([status, categoryText], ' • ');
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

    // Conclusion
    final conclusion = rawResource['conclusion'] as String?;
    if (conclusion != null) {
      additionalInfo.add('Conclusion: $conclusion');
    }

    // Performer
    final performer = rawResource['performer'] as List<dynamic>?;
    final performerDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(performer);
    if (performerDisplay != null) {
      additionalInfo.add('Performer: $performerDisplay');
    }

    // Result interpreter
    final resultsInterpreter =
        rawResource['resultsInterpreter'] as List<dynamic>?;
    final interpreterDisplay =
        BaseDisplayFactory.extractFirstPerformerDisplay(resultsInterpreter);
    if (interpreterDisplay != null) {
      additionalInfo.add('Interpreter: $interpreterDisplay');
    }

    return additionalInfo;
  }
}
