import 'package:health_wallet/features/records/domain/entity/observation/observation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/features/records/domain/utils/vital_codes.dart';

class ObservationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Observation';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final observation = entity as Observation;

    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(observation.code);
    if (displayText != null) return displayText;

    return 'Observation ${observation.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final observation = entity as Observation;

    final status = FhirFieldExtractor.extractStatus(observation.status);
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);

    return FhirFieldExtractor.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final observation = entity as Observation;
    return FhirFieldExtractor.extractStatus(observation.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final observation = entity as Observation;
    return FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final observation = entity as Observation;
    return FhirFieldExtractor.extractDate(observation.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final observation = entity as Observation;
    final additionalInfo = <String>[];

    final status = FhirFieldExtractor.extractStatus(observation.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        observation.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    final valueText = _extractObservationValue(observation);
    if (valueText != null) {
      additionalInfo.add('Value: $valueText');
    }

    final effectiveDate = _extractEffectiveDate(observation);
    if (effectiveDate != null) {
      additionalInfo.add('Effective: $effectiveDate');
    }

    final issuedDate = FhirFieldExtractor.extractDate(observation.issued);
    if (issuedDate != null) {
      additionalInfo.add('Issued: $issuedDate');
    }

    if (observation.performer?.isNotEmpty == true) {
      final performers = FhirFieldExtractor.extractMultipleReferenceDisplays(
          observation.performer);
      if (performers != null) {
        additionalInfo.add('Performers: $performers');
      }
    }

    final subject =
        FhirFieldExtractor.extractReferenceDisplay(observation.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(observation.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    return additionalInfo;
  }

  String? _extractObservationValue(Observation observation) {
    final valueX = observation.valueX;
    if (valueX is fhir_r4.Quantity) {
      final unit = valueX.unit?.toString() ?? '';
      return '${valueX.value} $unit';
    } else if (valueX is fhir_r4.CodeableConcept) {
      return FhirFieldExtractor.extractCodeableConceptText(valueX);
    } else if (valueX is fhir_r4.FhirString) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirBoolean) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirInteger) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirDecimal) {
      return valueX.toString();
    }
    return valueX?.toString();
  }

  String? _extractEffectiveDate(Observation observation) {
    final effectiveX = observation.effectiveX;
    if (effectiveX is fhir_r4.FhirDateTime) {
      return effectiveX.toString();
    } else if (effectiveX is fhir_r4.Period) {
      if (effectiveX.start != null) {
        return effectiveX.start.toString();
      }
    } else if (effectiveX is fhir_r4.FhirDate) {
      return effectiveX.toString();
    }
    return null;
  }

  // Vital sign specific methods
  bool isVitalSign(Observation observation) {
    final primaryCoding = observation.code?.coding;
    if (primaryCoding != null && primaryCoding.isNotEmpty) {
      for (final coding in primaryCoding) {
        if (coding.code != null && isVitalLoinc(coding.code.toString())) {
          return true;
        }
      }
    }

    if (observation.component != null) {
      for (final component in observation.component!) {
        final compCoding = component.code.coding;
        if (compCoding != null) {
          for (final coding in compCoding) {
            if (coding.code != null && isVitalLoinc(coding.code.toString())) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  String extractVitalSignTitle(Observation observation) {
    if (observation.code?.text != null) {
      return observation.code!.text.toString();
    }

    if (observation.code?.coding != null &&
        observation.code!.coding!.isNotEmpty) {
      final coding = observation.code!.coding!.first;
      if (coding.display != null) {
        return coding.display.toString();
      }
      if (coding.code != null) {
        return _mapLoincCodeToTitle(coding.code.toString());
      }
    }

    return 'Vital Sign';
  }

  String extractVitalSignValue(Observation observation) {
    final valueX = observation.valueX;

    if (valueX is fhir_r4.Quantity) {
      final code = observation.code?.coding?.isNotEmpty == true
          ? observation.code!.coding!.first.code?.toString()
          : null;
      return _formatQuantityValueByCode(code, valueX);
    } else if (valueX is fhir_r4.FhirString) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirInteger) {
      return valueX.toString();
    } else if (valueX is fhir_r4.FhirDecimal) {
      return _formatDecimal(valueX.toString());
    } else if (valueX is fhir_r4.CodeableConcept) {
      return valueX.text?.toString() ?? 'N/A';
    }

    return 'N/A';
  }

  String extractVitalSignUnit(Observation observation) {
    final valueX = observation.valueX;

    if (valueX is fhir_r4.Quantity) {
      return valueX.unit?.toString() ?? '';
    }

    if (observation.code?.coding != null &&
        observation.code!.coding!.isNotEmpty) {
      final coding = observation.code!.coding!.first;
      if (coding.code != null) {
        return _mapLoincCodeToUnit(coding.code.toString());
      }
    }

    return '';
  }

  String extractVitalSignStatus(Observation observation) {
    if (observation.interpretation != null &&
        observation.interpretation!.isNotEmpty) {
      final interpretation = observation.interpretation!.first;
      if (interpretation.coding != null && interpretation.coding!.isNotEmpty) {
        final coding = interpretation.coding!.first;
        if (coding.code != null) {
          return _mapInterpretationCodeToStatus(coding.code.toString());
        }
      }
    }

    if (observation.referenceRange != null &&
        observation.referenceRange!.isNotEmpty) {
      return 'Normal';
    }

    return 'Unknown';
  }

  // ===== PRIVATE HELPER METHODS =====

  String _mapLoincCodeToTitle(String code) {
    switch (code) {
      case kLoincHeartRate:
        return 'Heart Rate';
      case kLoincBloodPressurePanel:
        return 'Blood Pressure';
      case kLoincTemperature:
        return 'Temperature';
      case kLoincBloodOxygen:
      case kLoincBloodOxygenPulseOx:
        return 'Blood Oxygen';
      case kLoincWeight:
        return 'Weight';
      case kLoincHeight:
        return 'Height';
      case kLoincBmi:
        return 'BMI';
      case kLoincSystolic:
        return 'Systolic Blood Pressure';
      case kLoincDiastolic:
        return 'Diastolic Blood Pressure';
      case kLoincRespiratoryRate:
        return 'Respiratory Rate';
      case kLoincBloodGlucose:
        return 'Blood Glucose';
      default:
        return 'Vital Sign';
    }
  }

  String _mapLoincCodeToUnit(String code) {
    switch (code) {
      case kLoincHeartRate:
        return 'BPM';
      case kLoincBloodPressurePanel:
        return 'mmHg';
      case kLoincTemperature:
        return '°F';
      case kLoincBloodOxygen:
        return '%';
      case kLoincWeight:
        return 'kg';
      case kLoincHeight:
        return 'cm';
      case kLoincBmi:
        return 'kg/m²';
      case kLoincSystolic:
        return 'mmHg';
      case kLoincDiastolic:
        return 'mmHg';
      case kLoincRespiratoryRate:
        return '/min';
      case kLoincBloodGlucose:
        return 'mg/dL';
      default:
        return '';
    }
  }

  // Map FHIR interpretation codes to status
  String _mapInterpretationCodeToStatus(String code) {
    switch (code) {
      case 'H':
        return 'High';
      case 'L':
        return 'Low';
      case 'N':
        return 'Normal';
      case 'A':
        return 'Abnormal';
      case 'AA':
        return 'Critically Abnormal';
      case 'HH':
        return 'Critically High';
      case 'LL':
        return 'Critically Low';
      default:
        return 'Unknown';
    }
  }

  String _formatQuantityValueByCode(String? code, fhir_r4.Quantity quantity) {
    final String? raw = quantity.value?.toString();
    if (raw == null) return 'N/A';
    final double? num = double.tryParse(raw);
    if (num == null) return raw;

    int decimals = 1;
    switch (code) {
      case '8867-4': // Heart Rate
      case '8480-6': // Systolic BP
      case '8462-4': // Diastolic BP
      case '2708-6': // SpO2
        decimals = 0;
        break;
      case '8310-5': // Temperature
      case '29463-7': // Weight
      case '39156-5': // BMI
        decimals = 1;
        break;
      case '8302-2': // Height
        decimals = 0;
        break;
      default:
        decimals = num.abs() >= 100 ? 0 : 1;
    }
    return decimals == 0
        ? num.round().toString()
        : num.toStringAsFixed(decimals);
  }

  String _formatDecimal(String s) {
    final d = double.tryParse(s);
    if (d == null) return s;
    return d.abs() >= 100 ? d.round().toString() : d.toStringAsFixed(1);
  }
}
