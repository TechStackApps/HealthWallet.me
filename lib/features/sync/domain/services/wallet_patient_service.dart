import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:injectable/injectable.dart';

/// Service to handle WALLET-{patient} source creation for patients from read-only sources
/// Following the architecture: when a patient comes from read-only sources (Fasten, Epic, etc.),
/// create a separate WALLET-{patient} source to avoid altering the source of truth
///
/// Source Hierarchy:
/// - Generic 'wallet' source: Reserved for default_wallet_holder patient only
/// - Patient-specific wallet sources: 'wallet-{patientId}' for each patient from read-only sources
/// - All wallet sources: Have platformType: 'wallet' (writable)
///
/// Patient Deduplication:
/// - When 2+ sources have the same patient (matched by FHIR identifiers)
/// - They are grouped together via PatientDeduplicationService
/// - Displayed as one patient with multiple sources
/// - Example: Patient from Epic + Patient's wallet source = 1 patient, 2 sources
@injectable
class WalletPatientService {
  final SyncRepository _syncRepository;

  WalletPatientService(this._syncRepository);

  /// Creates a WALLET-{patient} source for a patient that came from Fasten
  /// This ensures data isolation and prevents altering the source of truth
  Future<Source> createWalletSourceForPatient(
      String patientId, String patientName) async {
    final walletSourceId = 'wallet-$patientId';

    // Check if wallet source already exists
    final existingSources = await _syncRepository.getSources();
    final existingWalletSource = existingSources
        .where((source) => source.id == walletSourceId)
        .firstOrNull;

    if (existingWalletSource != null) {
      return existingWalletSource;
    }

    // Create new WALLET-{patient} source
    final walletSource = Source(
      id: walletSourceId,
      platformName: 'wallet',
      labelSource: 'Wallet - $patientName',
      platformType: 'wallet',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Note: In a real implementation, you would save this to the database
    // For now, we'll return the created source
    return walletSource;
  }

  /// Gets all wallet sources for a specific patient
  Future<List<Source>> getWalletSourcesForPatient(String patientId) async {
    final allSources = await _syncRepository.getSources();
    return allSources
        .where((source) =>
            source.id == 'wallet-$patientId' ||
            (source.platformType == 'wallet' && source.id.contains(patientId)))
        .toList();
  }

  /// Determines if a patient has a corresponding wallet source
  Future<bool> hasWalletSourceForPatient(String patientId) async {
    final walletSources = await getWalletSourcesForPatient(patientId);
    return walletSources.isNotEmpty;
  }

  /// Gets the primary wallet source for a patient (the main one)
  Future<Source?> getPrimaryWalletSourceForPatient(String patientId) async {
    final walletSources = await getWalletSourcesForPatient(patientId);
    return walletSources.firstOrNull;
  }

  /// Creates wallet sources for all patients that came from Fasten
  /// This should be called during sync to ensure all Fasten patients have wallet sources
  Future<List<Source>> createWalletSourcesForAllFastenPatients() async {
    final allSources = await _syncRepository.getSources();
    final fastenSources =
        allSources.where((source) => source.platformType == 'fasten').toList();

    final createdWalletSources = <Source>[];

    for (final fastenSource in fastenSources) {
      // Extract patient ID from source ID (assuming format like "fasten-patient-123")
      final patientId = _extractPatientIdFromSourceId(fastenSource.id);
      if (patientId != null) {
        final walletSource = await createWalletSourceForPatient(
            patientId, fastenSource.labelSource ?? 'Patient $patientId');
        createdWalletSources.add(walletSource);
      }
    }

    return createdWalletSources;
  }

  /// Extracts patient ID from a source ID
  /// This is a helper method - you might need to adjust the logic based on your source ID format
  String? _extractPatientIdFromSourceId(String sourceId) {
    // Example: "fasten-patient-123" -> "patient-123"
    // Example: "fasten-manual-456" -> "manual-456"
    if (sourceId.startsWith('fasten-')) {
      return sourceId.substring(7); // Remove "fasten-" prefix
    }
    return null;
  }
}
