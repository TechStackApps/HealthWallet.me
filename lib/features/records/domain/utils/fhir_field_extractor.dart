import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

class FhirFieldExtractor {
  static String? extractStatus(dynamic status) {
    return status?.toString();
  }

  static String? extractCodeableConceptText(dynamic codeableConcept) {
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

  static String? extractReferenceDisplay(dynamic reference) {
    if (reference is fhir_r4.Reference) {
      return reference.display?.toString();
    }
    return null;
  }

  static String? extractDate(dynamic date) {
    return date?.toString();
  }

  static String? extractFirstCodeableConceptFromArray(
      List<dynamic>? codeableConceptArray) {
    if (codeableConceptArray == null || codeableConceptArray.isEmpty) {
      return null;
    }

    final firstConcept = codeableConceptArray.first;
    return extractCodeableConceptText(firstConcept);
  }

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

  static String? extractFirstHumanNameFromArray(List<dynamic>? nameArray) {
    if (nameArray != null &&
        nameArray.isNotEmpty &&
        nameArray.first is fhir_r4.HumanName) {
      return extractHumanName(nameArray.first);
    }
    return null;
  }

  static String? joinNullable(List<String?> values, String separator) {
    final nonNullStrings =
        values.where((s) => s != null && s.isNotEmpty).toList();
    return nonNullStrings.isEmpty ? null : nonNullStrings.join(separator);
  }

  static String? formatAddress(fhir_r4.Address? address) {
    if (address == null) return null;
    final city = address.city?.toString();
    final state = address.state?.toString();
    final country = address.country?.toString();
    return joinNullable([city, state, country], ', ');
  }

  static String? extractMultipleReferenceDisplays(List<dynamic>? references) {
    if (references == null || references.isEmpty) return null;

    final displays = references
        .where((r) => r is fhir_r4.Reference && r.display != null)
        .map((r) => r.display!)
        .join(', ');

    return displays.isNotEmpty ? displays : null;
  }

  static String? extractObservationValue(dynamic valueX) {
    final valueQuantity = valueX?.isAs<fhir_r4.Quantity>();
    if (valueQuantity != null) {
      return "${valueQuantity.value?.valueDouble?.toStringAsFixed(2)} ${valueQuantity.unit}";
    }

    final valueCodeableConcept = valueX?.isAs<fhir_r4.CodeableConcept>();
    if (valueCodeableConcept != null) {
      return extractCodeableConceptText(valueCodeableConcept);
    }

    final valueString = valueX?.isAs<fhir_r4.FhirString>();
    if (valueString != null) {
      return valueString.valueString;
    }

    final valueBoolean = valueX?.isAs<fhir_r4.FhirBoolean>();
    if (valueBoolean != null) {
      return valueBoolean.valueString;
    }

    final valueInteger = valueX?.isAs<fhir_r4.FhirInteger>();
    if (valueInteger != null) {
      return valueInteger.valueString;
    }

    final valueRange = valueX?.isAs<fhir_r4.Range>();
    if (valueRange != null) {
      return "${valueRange.low?.value?.valueDouble?.toStringAsFixed(2)} - ${valueRange.high?.value?.valueDouble?.toStringAsFixed(2)}";
    }

    final valueRatio = valueX?.isAs<fhir_r4.Ratio>();
    if (valueRatio != null) {
      return "${valueRatio.numerator?.value?.valueDouble?.toStringAsFixed(2)} / ${valueRatio.denominator?.value?.valueDouble?.toStringAsFixed(2)}";
    }

    final valueTime = valueX?.isAs<fhir_r4.FhirTime>();
    if (valueTime != null) {
      return valueTime.valueString;
    }

    final valueDateTime = valueX?.isAs<fhir_r4.FhirDateTime>();
    if (valueDateTime != null) {
      return valueDateTime.valueString;
    }

    final valuePeriod = valueX?.isAs<fhir_r4.Period>();
    if (valuePeriod != null) {
      return "${valuePeriod.start} - ${valuePeriod.end}";
    }

    return null;
  }
}
