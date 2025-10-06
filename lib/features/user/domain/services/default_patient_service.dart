import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/data/data_source/local/sync_local_data_source.dart';
import 'package:health_wallet/features/user/domain/services/wallet_holder_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class DefaultPatientService {
  final RecordsRepository _recordsRepository;
  final WalletHolderService _walletHolderService;
  final SyncLocalDataSource _syncLocalDataSource;

  DefaultPatientService(this._recordsRepository, this._walletHolderService,
      this._syncLocalDataSource);

  Future<Patient> createDefaultWalletHolder() async {
    // Create a basic patient with placeholder data
    // User can edit later via patient edit dialog
    return Patient(
      id: 'default_wallet_holder',
      sourceId: 'wallet',
      resourceId: 'default_wallet_holder',
      title: 'Health Wallet Holder',
      name: [
        fhir_r4.HumanName(
          use: fhir_r4.NameUse.official,
          given: [fhir_r4.FhirString('Health')],
          family: fhir_r4.FhirString('Wallet Holder'),
        ),
      ],
      birthDate: null, // Will prompt user to fill
      gender: null, // Will prompt user to fill
      rawResource: {
        'resourceType': 'Patient',
        'id': 'default_wallet_holder',
        'name': [
          {
            'use': 'official',
            'given': ['Health'],
            'family': 'Wallet Holder',
          }
        ],
      },
    );
  }

  Future<void> createAndSetAsMain() async {
    try {
      // Check if wallet holder already exists
      final existingWalletHolder = await _walletHolderService.getWalletHolder();
      if (existingWalletHolder != null) {
        return; // Already exists, don't create another
      }

      // Create default patient
      final defaultPatient = await createDefaultWalletHolder();

      // Create FHIR resource DTO for saving
      final fhirResourceDto = FhirResourceDto(
        id: defaultPatient.id,
        sourceId: defaultPatient.sourceId,
        resourceType: 'Patient',
        resourceId: defaultPatient.resourceId,
        title: defaultPatient.title,
        date: DateTime.now(),
        resourceRaw: defaultPatient.rawResource,
        changeType: 'created',
      );

      // Save to database using the sync local data source
      await _syncLocalDataSource.cacheFhirResources([fhirResourceDto]);

      // Set as wallet holder
      await _walletHolderService.setWalletHolder(
          defaultPatient.id, defaultPatient.sourceId);
    } catch (e) {
      // Log error but don't throw - this is a convenience feature
    }
  }

  Future<bool> shouldCreateDefaultWalletHolder() async {
    try {
      // Check if any patients exist
      final patients = await _recordsRepository.getResources(
        resourceTypes: [FhirType.Patient],
        limit: 1,
      );

      // If no patients exist, we should create a default one
      return patients.isEmpty;
    } catch (e) {
      // If there's an error, assume we should create one
      return true;
    }
  }
}
