import 'package:health_wallet/features/records/data/data_source/local/records_local_data_source.dart';
import 'package:health_wallet/features/records/data/data_source/remote/records_remote_data_source.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final RecordsRemoteDataSource _remoteDataSource;
  final RecordsLocalDataSource _localDataSource;

  RecordsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<void> deleteResourcesForSource(String sourceId) {
    // TODO: implement deleteResourcesForSource
    throw UnimplementedError();
  }

  @override
  Future<List<FhirResourceDisplayModel>> getAllResourcesForDisplay(
      {List<String>? resourceTypes}) {
    // TODO: implement getAllResourcesForDisplay
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAvailableResourceTypes() {
    // TODO: implement getAvailableResourceTypes
    throw UnimplementedError();
  }

  @override
  Future<List<EncounterDisplayModel>> getEncountersForDisplay() {
    // TODO: implement getEncountersForDisplay
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(String encounterId) {
    // TODO: implement getRelatedResourcesForEncounter
    throw UnimplementedError();
  }

  @override
  Future<Map<String, int>> getResourceCounts() {
    // TODO: implement getResourceCounts
    throw UnimplementedError();
  }

  @override
  Future<List<FhirResourceDisplayModel>> getResourcesForPatient(
      String patientId) {
    // TODO: implement getResourcesForPatient
    throw UnimplementedError();
  }

  @override
  Future<List<FhirResourceDisplayModel>> getResourcesWithFilters(
      {List<String>? resourceTypes,
      DateTime? startDate,
      DateTime? endDate,
      String? patientId}) {
    // TODO: implement getResourcesWithFilters
    throw UnimplementedError();
  }

  @override
  Future<List<FhirResourceDisplayModel>> getStandaloneResourcesForDisplay(
      {List<String>? resourceTypes}) {
    // TODO: implement getStandaloneResourcesForDisplay
    throw UnimplementedError();
  }

  @override
  Future<Map<String, int>> importFhirBundle(String bundleJson) {
    // TODO: implement importFhirBundle
    throw UnimplementedError();
  }

  @override
  Future<List<FhirResourceDisplayModel>> searchResources(String query) {
    // TODO: implement searchResources
    throw UnimplementedError();
  }
}
