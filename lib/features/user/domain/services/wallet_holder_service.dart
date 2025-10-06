import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WalletHolderService {
  final AppDatabase _appDatabase;
  final RecordsRepository _recordsRepository;

  WalletHolderService(this._appDatabase, this._recordsRepository);

  Future<String?> getWalletHolderId() async {
    final result = await _appDatabase
        .customSelect(
          'SELECT patient_id FROM wallet_holder_config LIMIT 1',
        )
        .getSingleOrNull();

    return result?.data['patient_id'] as String?;
  }

  Future<void> setWalletHolder(String patientId, String sourceId) async {
    await _appDatabase.customStatement(
      'INSERT OR REPLACE INTO wallet_holder_config (patient_id, source_id, created_at) VALUES (?, ?, ?)',
      [patientId, sourceId, DateTime.now().toIso8601String()],
    );
  }

  Future<Patient?> getWalletHolder() async {
    final walletHolderId = await getWalletHolderId();
    if (walletHolderId == null) return null;

    try {
      final patients = await _recordsRepository.getResources(
        resourceTypes: [FhirType.Patient],
        limit: 100,
      );

      final patientList = patients.whereType<Patient>().toList();
      return patientList.firstWhere(
        (patient) => patient.id == walletHolderId,
        orElse: () => throw Exception('Wallet holder patient not found'),
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> isWalletHolder(String patientId) async {
    final walletHolderId = await getWalletHolderId();
    return walletHolderId == patientId;
  }

  Future<void> clearWalletHolder() async {
    await _appDatabase.customStatement(
      'DELETE FROM wallet_holder_config',
    );
  }
}
