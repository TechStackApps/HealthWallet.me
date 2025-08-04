import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';

abstract class SyncRepository {
  Future<void> syncData();
  Future<void> syncDataWithJson(String jsonData);
  Future<List<FhirResourceDto>> getResources(
      {String? resourceType, String? sourceId});
  Future<List<FhirResourceDto>> getEncounterWithReferences(String encounterId);
  Future<List<entity.Source>> getSources();
  Future<void> checkConnection(String token);
  Future<ConnectionStatus> checkConnectionValidity();
}
