import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/services/wallet_patient_service.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:injectable/injectable.dart';

/// Service to determine source types and capabilities based on architecture diagram logic
@injectable
class SourceTypeService {
  final WalletPatientService _walletPatientService;
  final SyncRepository _syncRepository;

  SourceTypeService(this._walletPatientService, this._syncRepository);

  /// Determines if a source is writable based on its platform type
  /// Following the clean architecture:
  /// - WALLET sources (platformType = 'wallet') are writable
  /// - FASTEN sources (platformType = 'fasten') are read-only
  bool isSourceWritable(String platformType) {
    return platformType == 'wallet';
  }

  /// Determines the source type category based on platform type
  SourceType getSourceType(String platformType) {
    switch (platformType) {
      case 'wallet':
        return SourceType.wallet;
      case 'fasten':
        return SourceType.fasten;
      default:
        return SourceType.fasten; // Default to fasten for unknown types
    }
  }

  /// Gets a user-friendly description of the source type
  String getSourceTypeDescription(SourceType type) {
    switch (type) {
      case SourceType.wallet:
        return 'Personal Health Wallet - You can add, edit, and manage data';
      case SourceType.fasten:
        return 'Fasten Health System - Read-only data from your healthcare provider';
      case SourceType.ehr:
        return 'Electronic Health Record - Read-only data from your medical records';
      case SourceType.external:
        return 'External System - Read-only data from external healthcare systems';
    }
  }

  /// Checks if a source can be edited (label only for read-only sources)
  bool canEditSource(Source source) {
    if (isSourceWritable(source.platformType)) {
      return true; // Full editing capabilities
    }
    return true; // Can always edit label, even for read-only sources
  }

  /// Checks if a source can be deleted
  bool canDeleteSource(Source source) {
    return isSourceWritable(source.platformType) && source.id != 'wallet';
  }

  /// Checks if new data can be added to a source
  bool canAddDataToSource(Source source) {
    return isSourceWritable(source.platformType);
  }

  /// Ensures a wallet source exists for a patient, creating one if needed
  /// This is the core method for ensuring all new data goes to wallet sources
  Future<Source> ensureWalletSourceForPatient({
    required String patientId,
    String? patientName,
    required List<Source> availableSources,
  }) async {
    // DEBUG: Log available sources
    print(
        '🔍 DEBUG: ensureWalletSourceForPatient called for patientId: $patientId');
    print(
        '🔍 DEBUG: Available sources: ${availableSources.map((s) => '${s.id}(${s.platformType})').toList()}');

    // Check if patient already has a patient-specific wallet source
    final existingWallet = availableSources
        .where(
          (s) => s.platformType == 'wallet' && s.id == 'wallet-$patientId',
        )
        .firstOrNull;

    if (existingWallet != null) {
      print('✅ DEBUG: Found existing wallet source: ${existingWallet.id}');
      return existingWallet;
    }

    // Create new wallet source via WalletPatientService
    print('🔄 DEBUG: Creating new wallet source for patient: $patientId');
    final walletSource =
        await _walletPatientService.createWalletSourceForPatient(
      patientId,
      patientName ?? 'Patient $patientId',
    );

    // Save the wallet source to the database
    await _syncRepository.cacheSources([walletSource]);
    print('✅ DEBUG: Created and saved wallet source: ${walletSource.id}');

    return walletSource;
  }

  /// Gets the appropriate source for creating new data for a patient
  /// Returns wallet source if available, otherwise creates one
  Future<Source> getWritableSourceForPatient({
    required String patientId,
    String? patientName,
    required List<Source> availableSources,
  }) async {
    return await ensureWalletSourceForPatient(
      patientId: patientId,
      patientName: patientName,
      availableSources: availableSources,
    );
  }
}

/// Enum representing different source types based on the architecture diagram
enum SourceType {
  wallet, // WALLET sources (writable)
  fasten, // Fasten Health sources (read-only)
  ehr, // EHR system sources (read-only)
  external, // Other external sources (read-only)
}
