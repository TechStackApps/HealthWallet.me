import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

class FhirFieldExtractor {
  /// Extract status from any status field
  /// Pattern: entity.status?.toString()
  static String? extractStatus(dynamic status) {
    return status?.toString();
  }

  /// Extract CodeableConcept text
  /// Pattern: BaseEntityDisplayFactory.extractCodeableConceptTextNullable(field)
  static String? extractCodeableConceptText(dynamic codeableConcept) {
    return BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
        codeableConcept);
  }

  /// Extract Reference display
  /// Pattern: entity.field?.display?.toString()
  static String? extractReferenceDisplay(dynamic reference) {
    if (reference is fhir_r4.Reference) {
      return reference.display?.toString();
    }
    return null;
  }

  /// Extract date from any date field
  /// Pattern: entity.dateField?.toString()
  static String? extractDate(dynamic date) {
    return date?.toString();
  }

  /// Extract first CodeableConcept from array
  /// Pattern: BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(field)
  static String? extractFirstCodeableConceptFromArray(
      List<dynamic>? codeableConceptArray) {
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        codeableConceptArray);
  }

  /// Extract HumanName
  /// Pattern: BaseEntityDisplayFactory.extractHumanName(field)
  static String? extractHumanName(dynamic name) {
    return BaseEntityDisplayFactory.extractHumanName(name);
  }

  /// Extract first HumanName from array
  /// Pattern: BaseEntityDisplayFactory.extractHumanName(field.first)
  static String? extractFirstHumanNameFromArray(List<dynamic>? nameArray) {
    if (nameArray != null &&
        nameArray.isNotEmpty &&
        nameArray.first is fhir_r4.HumanName) {
      return BaseEntityDisplayFactory.extractHumanName(nameArray.first);
    }
    return null;
  }

  /// Join non-null values with separator
  /// Pattern: BaseEntityDisplayFactory.joinNonNull([value1, value2], ' • ')
  static String? joinNonNull(List<String?> values, String separator) {
    return BaseEntityDisplayFactory.joinNonNull(values, separator);
  }

  /// Format address components
  /// Pattern: joinNonNull([city, state, country], ', ')
  static String? formatAddress(dynamic address) {
    if (address is fhir_r4.Address) {
      final city = address.city?.toString();
      final state = address.state?.toString();
      final country = address.country?.toString();
      return joinNonNull([city, state, country], ', ');
    }
    return null;
  }

  /// Extract multiple reference displays from array
  /// Pattern: references.where((r) => r.display != null).map((r) => r.display!).join(', ')
  static String? extractMultipleReferenceDisplays(List<dynamic>? references) {
    if (references == null || references.isEmpty) return null;

    final displays = references
        .where((r) => r is fhir_r4.Reference && r.display != null)
        .map((r) => r.display!)
        .join(', ');

    return displays.isNotEmpty ? displays : null;
  }
}
