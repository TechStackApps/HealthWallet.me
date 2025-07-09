import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SyncService {
  final FhirRepository _fhirRepository;
  final SharedPreferences _sharedPreferences;

  SyncService(this._fhirRepository, this._sharedPreferences);

  Future<void> syncData() async {
    await _fhirRepository.syncData();
  }

  DateTime? getLastSyncTimestamp() {
    final timestamp = _sharedPreferences.getString('lastSyncTimestamp');
    if (timestamp != null) {
      return DateTime.parse(timestamp);
    }
    return null;
  }

  Future<void> setLastSyncTimestamp(DateTime dateTime) async {
    await _sharedPreferences.setString(
        'lastSyncTimestamp', dateTime.toIso8601String());
  }
}
