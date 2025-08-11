import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/observation/observation.dart';
import 'package:health_wallet/features/records/domain/factory/entity_factories/observation_entity_display_factory.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

class PatientVitalFactory {
  PatientVitalFactory()
      : _observationFactory = ObservationEntityDisplayFactory();

  final ObservationEntityDisplayFactory _observationFactory;

  List<PatientVital> buildFromResources(List<IFhirResource> resources) {
    final Map<String, PatientVital> latestByTitle = <String, PatientVital>{};

    for (final resource in resources) {
      if (resource is! Observation) continue;

      final List<PatientVital> extracted =
          _extractVitalSignsFromObservation(resource);
      for (final vital in extracted) {
        final String normalizedTitle = _normalizeTitle(vital.title);
        final PatientVital normalizedVital = (normalizedTitle == vital.title)
            ? vital
            : PatientVital(
                title: normalizedTitle,
                value: vital.value,
                unit: vital.unit,
                status: vital.status,
                observationId: vital.observationId,
                effectiveDate: vital.effectiveDate,
                category: vital.category,
              );
        final String key = normalizedTitle;
        final PatientVital? existing = latestByTitle[key];
        if (existing == null) {
          latestByTitle[key] = normalizedVital;
          continue;
        }
        final DateTime? existingDate = existing.effectiveDate;
        final DateTime? newDate = normalizedVital.effectiveDate;
        if (existingDate == null && newDate != null) {
          latestByTitle[key] = normalizedVital;
        } else if (existingDate != null && newDate != null) {
          if (newDate.isAfter(existingDate)) {
            latestByTitle[key] = normalizedVital;
          }
        }
      }
    }

    _combineBloodPressure(latestByTitle);

    // Ensure placeholders (N/A) for all expected vitals
    final List<String> expectedOrder = [
      PatientVitalType.heartRate.title,
      PatientVitalType.bloodPressure.title,
      PatientVitalType.temperature.title,
      PatientVitalType.bloodOxygen.title,
      PatientVitalType.respiratoryRate.title,
      PatientVitalType.weight.title,
      PatientVitalType.height.title,
      PatientVitalType.bmi.title,
      PatientVitalType.bloodGlucose.title,
    ];

    for (final title in expectedOrder) {
      latestByTitle.putIfAbsent(
        title,
        () => PatientVital(
          title: title,
          value: 'N/A',
          unit: (PatientVitalTypeX.fromTitle(title)?.defaultUnit ?? ''),
          status: 'Unknown',
          observationId: null,
          effectiveDate: null,
          category: 'vital-signs',
        ),
      );
    }

    // Build list in expected order, then append any extras not listed
    final List<PatientVital> ordered = [
      for (final t in expectedOrder) latestByTitle[t]!,
      ...latestByTitle.entries
          .where((e) => !expectedOrder.contains(e.key))
          .map((e) => e.value),
    ];

    return ordered;
  }

  String _normalizeTitle(String title) {
    final t = title.trim().toLowerCase();
    if (t == 'body height' || t == 'height')
      return PatientVitalType.height.title;
    if (t == 'body weight' || t == 'weight')
      return PatientVitalType.weight.title;
    if (t == 'body mass index' || t == 'bmi' || t == 'body mass index (bmi)') {
      return PatientVitalType.bmi.title;
    }
    if (t == 'oxygen saturation' ||
        t == 'oxygen saturation in arterial blood' ||
        t == 'spo2' ||
        t == 'pulse oximetry' ||
        t == 'oximetry') {
      return PatientVitalType.bloodOxygen.title;
    }
    if (t == 'body temperature' || t == 'temperature') {
      return PatientVitalType.temperature.title;
    }
    if (t == 'heart rate' || t == 'pulse rate' || t == 'pulse') {
      return PatientVitalType.heartRate.title;
    }
    if (t == 'respiratory rate') {
      return PatientVitalType.respiratoryRate.title;
    }
    if (t == 'systolic blood pressure') {
      return PatientVitalType.systolicBloodPressure.title;
    }
    if (t == 'diastolic blood pressure') {
      return PatientVitalType.diastolicBloodPressure.title;
    }
    if (t == 'blood pressure') {
      return PatientVitalType.bloodPressure.title;
    }
    if (t == 'blood glucose' || t == 'glucose') {
      return PatientVitalType.bloodGlucose.title;
    }
    return title;
  }

  List<PatientVital> _extractVitalSignsFromObservation(
      Observation observation) {
    final List<PatientVital> vitals = <PatientVital>[];

    final Set<String> primaryCodes = (observation.code?.coding ?? [])
        .where((c) => c.code != null)
        .map((c) => c.code.toString())
        .toSet();
    final bool isBloodPressurePanel =
        primaryCodes.contains('85354-9') || primaryCodes.contains('55284-4');

    if (isBloodPressurePanel && observation.component != null) {
      for (final component in observation.component!) {
        final compCodes = (component.code.coding ?? [])
            .where((c) => c.code != null)
            .map((c) => c.code.toString())
            .toSet();

        for (final code in compCodes) {
          if (code == '8480-6' || code == '8462-4') {
            final String title = code == '8480-6'
                ? 'Systolic Blood Pressure'
                : 'Diastolic Blood Pressure';

            String value = 'N/A';
            String unit = 'mmHg';
            final valueX = component.valueX;
            if (valueX is fhir_r4.Quantity) {
              value = valueX.value?.toString() ?? value;
              unit = valueX.unit?.toString() ?? unit;
            }

            vitals.add(
              PatientVital(
                title: title,
                value: value,
                unit: unit,
                status: _observationFactory.extractVitalSignStatus(observation),
                observationId: observation.id,
                effectiveDate: observation.date,
                category: _observationFactory.extractCategory(observation),
              ),
            );
          }
        }
      }
    } else {
      if (_observationFactory.isVitalSign(observation)) {
        vitals.add(PatientVital.fromObservation(observation));
      }
    }

    return vitals;
  }

  void _combineBloodPressure(Map<String, PatientVital> latestByTitle) {
    final PatientVital? systolic =
        latestByTitle[PatientVitalType.systolicBloodPressure.title];
    final PatientVital? diastolic =
        latestByTitle[PatientVitalType.diastolicBloodPressure.title];
    if (systolic == null || diastolic == null) return;

    int? sys = int.tryParse(systolic.value) ??
        double.tryParse(systolic.value)?.round();
    int? dia = int.tryParse(diastolic.value) ??
        double.tryParse(diastolic.value)?.round();
    if (sys == null || dia == null) return;

    final DateTime? latestDate;
    if (systolic.effectiveDate == null && diastolic.effectiveDate == null) {
      latestDate = null;
    } else if (systolic.effectiveDate == null) {
      latestDate = diastolic.effectiveDate;
    } else if (diastolic.effectiveDate == null) {
      latestDate = systolic.effectiveDate;
    } else {
      latestDate = systolic.effectiveDate!.isAfter(diastolic.effectiveDate!)
          ? systolic.effectiveDate
          : diastolic.effectiveDate;
    }

    final String combinedStatus = (sys >= 140 || dia >= 90) ? 'High' : 'Normal';

    final PatientVital bp = PatientVital(
      title: PatientVitalType.bloodPressure.title,
      value: '$sys/$dia',
      unit: 'mmHg',
      status: combinedStatus,
      observationId: null,
      effectiveDate: latestDate,
      category: 'vital-signs',
    );

    latestByTitle
      ..remove(PatientVitalType.systolicBloodPressure.title)
      ..remove(PatientVitalType.diastolicBloodPressure.title)
      ..putIfAbsent(PatientVitalType.bloodPressure.title, () => bp)
      ..update(PatientVitalType.bloodPressure.title, (_) => bp,
          ifAbsent: () => bp);
  }
}
