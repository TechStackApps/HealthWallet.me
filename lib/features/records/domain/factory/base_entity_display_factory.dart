import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

/// Base class for all entity display factories
/// Provides common utilities for display model creation
abstract class BaseEntityDisplayFactory {
  /// The resource type this factory handles
  String get resourceType;

  /// Template method for building display models from entities
  FhirResourceDisplayModel buildFromEntity(IFhirResource entity) {
    final status = extractStatus(entity);
    final primaryDisplay = extractPrimaryDisplay(entity);
    final secondaryDisplay = extractSecondaryDisplay(entity);
    final category = extractCategory(entity);
    final date = extractDate(entity);
    final additionalInfo = buildAdditionalInfo(entity);

    return FhirResourceDisplayModel(
      id: entity.id,
      resourceType: resourceType,
      primaryDisplay: primaryDisplay,
      secondaryDisplay: secondaryDisplay,
      status: status,
      category: category,
      date: date,
      additionalInfo: additionalInfo,
      rawResource: _entityToMap(entity),
    );
  }

  /// Extract the primary display text (e.g., resource name)
  String extractPrimaryDisplay(IFhirResource entity);

  /// Extract the secondary display text (e.g., status + category)
  String? extractSecondaryDisplay(IFhirResource entity);

  /// Extract the status (e.g., active, inactive)
  String? extractStatus(IFhirResource entity);

  /// Extract the category (e.g., encounter-diagnosis, problem-list-item)
  String? extractCategory(IFhirResource entity);

  /// Extract the relevant date
  String? extractDate(IFhirResource entity);

  /// Build additional information list
  List<String> buildAdditionalInfo(IFhirResource entity);

  /// Convert entity to map for rawResource field
  Map<String, dynamic> _entityToMap(IFhirResource entity) {
    return {
      'id': entity.id,
      'resourceType': entity.fhirType.display,
      'title': entity.title,
      'date': entity.date?.toIso8601String(),
    };
  }

  // ===== UTILITY METHODS =====

  /// Extract text from CodeableConcept with default fallback
  static String extractCodeableConceptText(
      dynamic codeableConcept, String defaultText) {
    if (codeableConcept == null) return defaultText;

    // Try text field first
    final text = codeableConcept.text?.toString();
    if (text != null && text.isNotEmpty) return text;

    // Try first coding display
    final coding = codeableConcept.coding;
    if (coding?.isNotEmpty == true) {
      final display = coding!.first.display?.toString();
      if (display != null && display.isNotEmpty) return display;
    }

    return defaultText;
  }

  /// Extract text from CodeableConcept with nullable return
  static String? extractCodeableConceptTextNullable(dynamic codeableConcept) {
    if (codeableConcept == null) return null;

    // Try text field first
    final text = codeableConcept.text?.toString();
    if (text != null && text.isNotEmpty) return text;

    // Try first coding display
    final coding = codeableConcept.coding;
    if (coding?.isNotEmpty == true) {
      final display = coding!.first.display?.toString();
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

    final firstConcept = codeableConceptArray.first;
    return extractCodeableConceptTextNullable(firstConcept);
  }

  /// Join non-null strings with separator
  static String? joinNonNull(List<String?> strings, String separator) {
    final nonNullStrings =
        strings.where((s) => s != null && s.isNotEmpty).toList();
    return nonNullStrings.isEmpty ? null : nonNullStrings.join(separator);
  }

  /// Extract human name from HumanName object
  static String? extractHumanName(dynamic name) {
    if (name == null) return null;

    final given = name.given?.map((g) => g.toString()).join(' ') ?? '';
    final family = name.family?.toString() ?? '';
    final prefix = name.prefix?.map((p) => p.toString()).join(' ') ?? '';

    final title = prefix.isNotEmpty ? '$prefix ' : '';

    if (given.isNotEmpty && family.isNotEmpty) {
      return '$title$given $family';
    } else if (given.isNotEmpty) {
      return '$title$given';
    } else if (family.isNotEmpty) {
      return '$title$family';
    }

    return null;
  }
}
