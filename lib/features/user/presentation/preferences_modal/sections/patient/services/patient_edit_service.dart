import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/entity/observation/observation.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/core/utils/blood_observation_utils.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';

class PatientEditService {
  final RecordsRepository _recordsRepository;

  PatientEditService(this._recordsRepository);

  /// Gets the current blood type for a patient
  Future<String?> getCurrentBloodType(Patient patient) async {
    try {
      final observations = await _recordsRepository.getBloodTypeObservations(
        patientId: patient.id,
        sourceId: patient.sourceId.isNotEmpty ? patient.sourceId : null,
      );
      return FhirFieldExtractor.extractBloodTypeFromObservations(observations);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateBloodTypeObservation(
    Patient patient,
    String bloodType,
  ) async {
    try {
      final existingObservations =
          await _recordsRepository.getBloodTypeObservations(
        patientId: patient.id,
        sourceId: patient.sourceId.isNotEmpty ? patient.sourceId : null,
      );

      if (bloodType == 'N/A') {
        if (existingObservations.isNotEmpty) {
          final existingObservation = existingObservations.first as Observation;

          final updatedRawResource =
              Map<String, dynamic>.from(existingObservation.rawResource);
          updatedRawResource.remove('valueCodeableConcept');

          final clearedObservation = existingObservation.copyWith(
            valueX: null,
            date: DateTime.now(),
            rawResource: updatedRawResource,
          );
          await _recordsRepository.saveObservation(clearedObservation);
        }
        return;
      }

      if (!BloodObservationUtils.isValidBloodType(bloodType)) {
        logger.w('Invalid blood type: $bloodType');
        return;
      }

      if (existingObservations.isNotEmpty) {
        final existingObservation = existingObservations.first as Observation;

        final newValueX = BloodObservationUtils.createBloodTypeValue(bloodType);

        final updatedRawResource =
            Map<String, dynamic>.from(existingObservation.rawResource);
        updatedRawResource['valueCodeableConcept'] = newValueX.toJson();

        final updatedObservation = existingObservation.copyWith(
          valueX: newValueX,
          date: DateTime.now(),
          rawResource: updatedRawResource,
        );

        await _recordsRepository.saveObservation(updatedObservation);
      } else {
        final newObservation = BloodObservationUtils.createBloodTypeObservation(
          bloodType: bloodType,
          patientSourceId: patient.sourceId,
          patientResourceId: patient.resourceId,
        );
        await _recordsRepository.saveObservation(newObservation);
      }
    } catch (e) {
      logger.e('Error updating blood type observation: $e');
      rethrow;
    }
  }

  /// Checks if any patient fields have changed
  Future<bool> hasPatientChanges({
    required Patient currentPatient,
    required DateTime? newBirthDate,
    required String newGender,
    required String newBloodType,
    required AppLocalizations l10n,
  }) async {
    final currentBirthDate =
        FhirFieldExtractor.extractPatientBirthDate(currentPatient);
    final currentGender =
        FhirFieldExtractor.extractPatientGender(currentPatient);
    final currentBloodType = await getCurrentBloodType(currentPatient);

    final birthDateChanged = currentBirthDate != newBirthDate;
    final genderChanged = _mapGenderToDisplay(currentGender, l10n) != newGender;
    final bloodTypeChanged = currentBloodType != newBloodType;

    return birthDateChanged || genderChanged || bloodTypeChanged;
  }

  String _mapGenderToDisplay(String? fhirGender, AppLocalizations l10n) {
    if (fhirGender == null) return l10n.preferNotToSay;

    switch (fhirGender.toLowerCase()) {
      case 'male':
        return l10n.male;
      case 'female':
        return l10n.female;
      default:
        return l10n.preferNotToSay;
    }
  }

  bool validatePatientData({
    required DateTime? birthDate,
    required String gender,
    required String bloodType,
  }) {
    if (birthDate == null) {
      return false;
    }

    if (birthDate.isAfter(DateTime.now())) {
      return false;
    }

    return true;
  }
}
