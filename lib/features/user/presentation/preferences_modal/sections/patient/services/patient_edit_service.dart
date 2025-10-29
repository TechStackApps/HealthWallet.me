import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/core/utils/blood_observation_utils.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class PatientEditService {
  final RecordsRepository _recordsRepository;
  final SourceTypeService _sourceTypeService;

  PatientEditService(
    this._recordsRepository,
    this._sourceTypeService,
  );

  /// Saves patient edits, handling read-only sources with copy-on-write pattern
  Future<Patient> savePatientEdits({
    required Patient currentPatient,
    String? name,
    required DateTime birthDate,
    required String gender,
    required List<Source> availableSources,
  }) async {
    // Get source and check writability
    final source = availableSources.firstWhere(
      (s) => s.id == currentPatient.sourceId,
      orElse: () =>
          throw Exception('Source not found for ${currentPatient.sourceId}'),
    );

    final isWritable = _sourceTypeService.isSourceWritable(source.platformType);

    if (isWritable) {
      // Wallet source → update in place
      return await _updatePatientInPlace(
        patient: currentPatient,
        name: name,
        birthDate: birthDate,
        gender: gender,
      );
    } else {
      // Read-only source → copy to wallet
      return await _copyPatientToWallet(
        readOnlyPatient: currentPatient,
        name: name,
        birthDate: birthDate,
        gender: gender,
        availableSources: availableSources,
      );
    }
  }

  /// Updates patient in place (for writable sources)
  Future<Patient> _updatePatientInPlace({
    required Patient patient,
    String? name,
    required DateTime birthDate,
    required String gender,
  }) async {
    // Parse existing FHIR patient
    final fhirPatient = fhir_r4.Patient.fromJson(patient.rawResource);

    // Build updated HumanName if name changed
    List<fhir_r4.HumanName>? updatedNames = fhirPatient.name;
    if (name != null && name.isNotEmpty) {
      final nameParts = name.split(' ');
      final family = nameParts.last;
      final given = nameParts.length > 1
          ? nameParts.sublist(0, nameParts.length - 1)
          : <String>[];

      updatedNames = [
        fhir_r4.HumanName(
          text: fhir_r4.FhirString(name),
          family: fhir_r4.FhirString(family),
          given: given.map((n) => fhir_r4.FhirString(n)).toList(),
        ),
      ];
    }

    // Use fhir_r4 copyWith for type safety
    final updatedFhirPatient = fhirPatient.copyWith(
      name: updatedNames,
      gender: _mapDisplayGenderToFhir(gender),
      birthDate: fhir_r4.FhirDate.fromDateTime(birthDate),
    );

    // Convert back to JSON
    final updatedRawResource = updatedFhirPatient.toJson();

    // Calculate display title from updated name
    final displayTitle = name ?? patient.displayTitle;

    // Update Patient entity with new rawResource and title
    final finalPatient = patient.copyWith(
      rawResource: updatedRawResource,
      title: displayTitle,
      name: updatedNames,
      gender: updatedFhirPatient.gender,
      birthDate: updatedFhirPatient.birthDate,
    );

    await _recordsRepository.updatePatient(finalPatient);
    return finalPatient;
  }

  /// Copies patient to wallet source with edits (for read-only sources)
  Future<Patient> _copyPatientToWallet({
    required Patient readOnlyPatient,
    String? name,
    required DateTime birthDate,
    required String gender,
    required List<Source> availableSources,
  }) async {
    // Ensure wallet source exists (use resourceId!)
    final walletSource = await _sourceTypeService.getWritableSourceForPatient(
      patientId: readOnlyPatient.resourceId,
      patientName: readOnlyPatient.displayTitle,
      availableSources: availableSources,
    );

    // Check if wallet patient already exists
    final existingWalletPatients = await _recordsRepository.getResources(
      resourceTypes: [FhirType.Patient],
      sourceId: walletSource.id,
    );

    final existingWalletPatient = existingWalletPatients
        .whereType<Patient>()
        .where((p) => _hasSameIdentifiers(p, readOnlyPatient))
        .firstOrNull;

    if (existingWalletPatient != null) {
      logger.i('Updating existing wallet patient: ${existingWalletPatient.id}');
      // Update existing wallet patient
      return await _updatePatientInPlace(
        patient: existingWalletPatient,
        name: name,
        birthDate: birthDate,
        gender: gender,
      );
    } else {
      logger.i('Creating new wallet patient for: ${readOnlyPatient.id}');
      // Create new wallet patient copy
      return await _createWalletPatientFromReadOnly(
        readOnlyPatient: readOnlyPatient,
        walletSource: walletSource,
        name: name,
        birthDate: birthDate,
        gender: gender,
      );
    }
  }

  /// Creates a new patient in wallet source, copying from read-only version
  Future<Patient> _createWalletPatientFromReadOnly({
    required Patient readOnlyPatient,
    required Source walletSource,
    String? name,
    required DateTime birthDate,
    required String gender,
  }) async {
    final walletResourceId = 'patient-${const Uuid().v4()}';
    final walletDbId = '${walletSource.id}_$walletResourceId';

    // Parse read-only patient as FHIR
    final fhirPatient = fhir_r4.Patient.fromJson(readOnlyPatient.rawResource);

    // Build updated HumanName if name provided
    List<fhir_r4.HumanName>? updatedNames = fhirPatient.name;
    if (name != null && name.isNotEmpty) {
      final nameParts = name.split(' ');
      final family = nameParts.last;
      final given = nameParts.length > 1
          ? nameParts.sublist(0, nameParts.length - 1)
          : <String>[];

      updatedNames = [
        fhir_r4.HumanName(
          text: fhir_r4.FhirString(name),
          family: fhir_r4.FhirString(family),
          given: given.map((n) => fhir_r4.FhirString(n)).toList(),
        ),
      ];
    }

    // Create new FHIR patient with wallet ID and edits
    final updatedFhirPatient = fhirPatient.copyWith(
      id: fhir_r4.FhirString(walletResourceId),
      name: updatedNames,
      gender: _mapDisplayGenderToFhir(gender),
      birthDate: fhir_r4.FhirDate.fromDateTime(birthDate),
    );

    final updatedRawResource = updatedFhirPatient.toJson();

    // Calculate display title
    final displayTitle = name ?? readOnlyPatient.displayTitle;

    // Create wallet patient entity
    final finalPatient = readOnlyPatient.copyWith(
      id: walletDbId,
      sourceId: walletSource.id,
      resourceId: walletResourceId,
      rawResource: updatedRawResource,
      title: displayTitle,
      identifier: readOnlyPatient.identifier, // Keep for deduplication
      name: updatedNames,
      gender: updatedFhirPatient.gender,
      birthDate: updatedFhirPatient.birthDate,
    );

    await _recordsRepository.updatePatient(finalPatient);

    logger.i(
        'Created wallet patient copy: ${finalPatient.id} from ${readOnlyPatient.id}');

    return finalPatient;
  }

  /// Checks if two patients have matching FHIR identifiers
  bool _hasSameIdentifiers(Patient p1, Patient p2) {
    if (p1.identifier == null || p2.identifier == null) return false;
    if (p1.identifier!.isEmpty || p2.identifier!.isEmpty) return false;

    final ids1 = p1.identifier!
        .where((id) =>
            id.system?.valueString != null && id.value?.valueString != null)
        .map((id) => '${id.system!.valueString}:${id.value!.valueString}')
        .toSet();

    final ids2 = p2.identifier!
        .where((id) =>
            id.system?.valueString != null && id.value?.valueString != null)
        .map((id) => '${id.system!.valueString}:${id.value!.valueString}')
        .toSet();

    return ids1.intersection(ids2).isNotEmpty;
  }

  /// Maps display gender to FHIR gender
  fhir_r4.AdministrativeGender? _mapDisplayGenderToFhir(String displayGender) {
    switch (displayGender.toLowerCase()) {
      case 'male':
        return fhir_r4.AdministrativeGender.male;
      case 'female':
        return fhir_r4.AdministrativeGender.female;
      case 'prefer not to say':
      case 'prefernottosay':
      case 'unknown':
      default:
        return fhir_r4.AdministrativeGender.unknown;
    }
  }

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
