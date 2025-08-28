import 'package:health_wallet/features/records/domain/entity/observation/observation.dart';
import 'package:health_wallet/core/constants/blood_types.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir;

class BloodObservationUtils {
  static Observation createBloodTypeObservation({
    required String bloodType,
    required String patientSourceId,
    required String patientResourceId,
    String? customId,
  }) {
    if (bloodType == 'N/A') {
      throw ArgumentError('Blood type cannot be N/A');
    }

    final observationId =
        customId ?? 'blood_type_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    return Observation(
      id: observationId,
      sourceId: patientSourceId,
      resourceId: patientResourceId,
      title: 'Blood Type: $bloodType',
      date: now,
      status: fhir.ObservationStatus.final_,
      category: [
        fhir.CodeableConcept(
          coding: [
            fhir.Coding(
              system: fhir.FhirUri(
                  'http://terminology.hl7.org/CodeSystem/observation-category'),
              code: fhir.FhirCode('laboratory'),
              display: fhir.FhirString('Laboratory'),
            ),
          ],
        ),
      ],
      code: fhir.CodeableConcept(
        coding: [
          fhir.Coding(
            system: fhir.FhirUri('http://loinc.org'),
            code: fhir.FhirCode(BloodTypes.combinedLoincCode),
            display: fhir.FhirString('ABO and Rh group [Type] in Blood'),
          ),
        ],
        text: fhir.FhirString('Blood Type'),
      ),
      subject: fhir.Reference(
        reference: fhir.FhirString('Patient/$patientResourceId'),
      ),
      valueX: fhir.CodeableConcept(
        coding: [
          fhir.Coding(
            system: fhir.FhirUri('http://snomed.info/sct'),
            code: fhir.FhirCode(BloodTypes.getSnomedCode(bloodType)),
            display: fhir.FhirString(BloodTypes.getDisplayName(bloodType)),
          ),
        ],
        text: fhir.FhirString(bloodType),
      ),
      issued: fhir.FhirInstant.fromDateTime(now),
      effectiveX: fhir.FhirDateTime.fromDateTime(now),
    );
  }

  static bool isValidBloodType(String bloodType) {
    return bloodType != 'N/A' &&
        BloodTypes.getAllBloodTypes().contains(bloodType);
  }

  static String getBloodTypeDisplayName(String bloodType) {
    if (bloodType == 'N/A') return 'Not Available';
    return BloodTypes.getDisplayName(bloodType);
  }

  static fhir.CodeableConcept createBloodTypeValue(String bloodType) {
    return fhir.CodeableConcept(
      coding: [
        fhir.Coding(
          system: fhir.FhirUri('http://snomed.info/sct'),
          code: fhir.FhirCode(BloodTypes.getSnomedCode(bloodType)),
          display: fhir.FhirString(BloodTypes.getDisplayName(bloodType)),
        ),
      ],
      text: fhir.FhirString(bloodType),
    );
  }
}
