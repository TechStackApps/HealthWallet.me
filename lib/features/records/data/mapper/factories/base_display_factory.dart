import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

/// Base class for all display factories to eliminate duplicate code
abstract class BaseDisplayFactory {
  /// The resource type this factory handles
  String get resourceType;

  /// Template method for building display models
  FhirResourceDisplayModel buildFromRaw(Map<String, dynamic> rawResource) {
    final id = rawResource['id'] as String? ?? '';
    final status = extractStatus(rawResource);
    final primaryDisplay = extractPrimaryDisplay(rawResource);
    final secondaryDisplay = extractSecondaryDisplay(rawResource);
    final category = extractCategory(rawResource);
    final date = extractDate(rawResource);
    final additionalInfo = buildAdditionalInfo(rawResource);

    return FhirResourceDisplayModel(
      id: id,
      resourceType: resourceType,
      primaryDisplay: primaryDisplay,
      secondaryDisplay: secondaryDisplay,
      status: status,
      category: category,
      date: date,
      additionalInfo: additionalInfo,
      rawResource: rawResource,
    );
  }

  /// Extract the primary display text (e.g., resource name)
  String extractPrimaryDisplay(Map<String, dynamic> rawResource);

  /// Extract the secondary display text (e.g., status + category)
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource);

  /// Extract the status (e.g., active, inactive)
  String? extractStatus(Map<String, dynamic> rawResource);

  /// Extract the category (e.g., encounter-diagnosis, problem-list-item)
  String? extractCategory(Map<String, dynamic> rawResource);

  /// Extract the relevant date
  String? extractDate(Map<String, dynamic> rawResource);

  /// Build additional information list
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource);

  // Static utility methods for common extraction patterns

  /// Extract text from CodeableConcept with default fallback
  static String extractCodeableConceptText(
      Map<String, dynamic>? codeableConcept, String defaultText) {
    if (codeableConcept == null) return defaultText;

    // Try text field first
    final text = codeableConcept['text'] as String?;
    if (text != null && text.isNotEmpty) return text;

    // Try first coding display
    final coding = codeableConcept['coding'] as List<dynamic>?;
    if (coding != null && coding.isNotEmpty) {
      final firstCoding = coding.first as Map<String, dynamic>?;
      final display = firstCoding?['display'] as String?;
      if (display != null && display.isNotEmpty) return display;
    }

    return defaultText;
  }

  /// Extract text from CodeableConcept with nullable return
  static String? extractCodeableConceptTextNullable(
      Map<String, dynamic>? codeableConcept) {
    if (codeableConcept == null) return null;

    // Try text field first
    final text = codeableConcept['text'] as String?;
    if (text != null && text.isNotEmpty) return text;

    // Try first coding display
    final coding = codeableConcept['coding'] as List<dynamic>?;
    if (coding != null && coding.isNotEmpty) {
      final firstCoding = coding.first as Map<String, dynamic>?;
      final display = firstCoding?['display'] as String?;
      if (display != null && display.isNotEmpty) return display;
    }

    return null;
  }

  /// Extract array of CodeableConcept and return first display text
  static String? extractFirstCodeableConceptFromArray(
      List<dynamic>? codeableConceptArray) {
    if (codeableConceptArray == null || codeableConceptArray.isEmpty) {
      return null;
    }

    final firstConcept = codeableConceptArray.first as Map<String, dynamic>?;
    return extractCodeableConceptTextNullable(firstConcept);
  }

  /// Join non-null strings with separator
  static String? joinNonNull(List<String?> strings, String separator) {
    final nonNullStrings =
        strings.where((s) => s != null && s.isNotEmpty).toList();
    return nonNullStrings.isEmpty ? null : nonNullStrings.join(separator);
  }

  /// Extract first available date from a list of date fields
  static String? extractFirstAvailableDate(
      Map<String, dynamic> rawResource, List<String> dateFields) {
    for (final field in dateFields) {
      final fieldValue = rawResource[field];

      // Handle String dates directly
      if (fieldValue is String && fieldValue.isNotEmpty) {
        return fieldValue;
      }

      // Handle Map objects (like Period objects)
      if (fieldValue is Map<String, dynamic>) {
        // Try common date fields in order of preference
        final possibleDateFields = ['start', 'end', 'value', 'low', 'high'];
        for (final subField in possibleDateFields) {
          final subValue = fieldValue[subField];
          if (subValue is String && subValue.isNotEmpty) {
            return subValue;
          }
        }
      }
    }
    return null;
  }

  /// Extract display text from a reference
  static String? extractReferenceDisplay(Map<String, dynamic>? reference) {
    return reference?['display'] as String?;
  }

  /// Extract first display from performer/actor array
  static String? extractFirstPerformerDisplay(List<dynamic>? performers) {
    if (performers == null || performers.isEmpty) return null;

    final firstPerformer = performers.first as Map<String, dynamic>?;

    // Try actor.display first (for procedures)
    final actor = firstPerformer?['actor'] as Map<String, dynamic>?;
    final actorDisplay = actor?['display'] as String?;
    if (actorDisplay != null) return actorDisplay;

    // Try direct display (for observations)
    return firstPerformer?['display'] as String?;
  }
}
