import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';

abstract class SyncRepository {
  Future<void> syncData();
  Future<void> syncDataWithJson(String jsonData);
  Future<List<Source>> getSources();
  Future<void> cacheResources(List<FhirResourceDto> resources);
  
  // Background sync methods (ONLY approach used)
  Future<void> startBackgroundSync({String? workingBaseUrl});
  Future<void> startSmartSync({String? workingBaseUrl});
  Future<bool> isBackgroundSyncRunning();
  Future<dynamic> getCurrentSyncProgress();
  Future<void> cancelBackgroundSync();
}
