import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';

abstract class SyncRepository {
  Future<void> syncData();
  Future<void> syncDataWithJson(String jsonData);
  Future<List<Source>> getSources();
  Future<void> checkConnection(String token);
  Future<ConnectionStatus> checkConnectionValidity();
}
