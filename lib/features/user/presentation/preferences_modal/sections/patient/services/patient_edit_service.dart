import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/core/utils/blood_observation_utils.dart';

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

  /// Updates the blood type observation for a patient
  Future<void> updateBloodTypeObservation(
    Patient patient,
    String bloodType,
  ) async {
    if (!BloodObservationUtils.isValidBloodType(bloodType)) {
      return;
    }

    try {
      final newObservation = BloodObservationUtils.createBloodTypeObservation(
        bloodType: bloodType,
        patientSourceId: patient.sourceId,
        patientResourceId: patient.resourceId,
      );

      await _recordsRepository.saveObservation(newObservation);
    } catch (e) {
      rethrow;
    }
  }

  /// Checks if any patient fields have changed
  Future<bool> hasPatientChanges({
    required Patient currentPatient,
    required DateTime? newBirthDate,
    required String newGender,
    required String newBloodType,
  }) async {
    final currentBirthDate =
        FhirFieldExtractor.extractPatientBirthDate(currentPatient);
    final currentGender =
        FhirFieldExtractor.extractPatientGender(currentPatient);
    final currentBloodType = await getCurrentBloodType(currentPatient);

    final birthDateChanged = currentBirthDate != newBirthDate;
    final genderChanged = _mapGenderToDisplay(currentGender) != newGender;
    final bloodTypeChanged =
        currentBloodType != newBloodType && newBloodType != 'N/A';

    return birthDateChanged || genderChanged || bloodTypeChanged;
  }

  /// Maps FHIR gender to display format
  String _mapGenderToDisplay(String? fhirGender) {
    if (fhirGender == null) return 'Prefer not to say';

    switch (fhirGender.toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      default:
        return 'Prefer not to say';
    }
  }

  /// Validates patient data before saving
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
