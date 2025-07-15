import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;

abstract class FhirRepository {
  Future<void> syncData();
  Future<void> syncDataWithJson(String jsonData);
  Future<List<FhirResource>> getResources(
      {String? resourceType, String? sourceId});
  Future<List<FhirResource>> getEncounterWithReferences(String encounterId);
  Future<List<entity.Source>> getSources();
}
