import 'dart:convert';
import 'dart:developer';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/domain/utils/encounter_relation_checker.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/domain/factory/display_factory_manager.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final FhirResourceDatasource _datasource;

  RecordsRepositoryImpl(AppDatabase database)
      : _datasource = FhirResourceDatasource(database);

  /// Get resources with pagination and filtering
  @override
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int limit = 20,
    int offset = 0,
  }) async {
    final localDtos = await _datasource.getResources(
      resourceTypes: resourceTypes.map((fhirType) => fhirType.name).toList(),
      sourceId: sourceId,
      limit: limit,
      offset: offset,
    );

    return localDtos.map(IFhirResource.fromLocalDto).toList();
  }

  /// Get related resources for an encounter
  @override
  Future<List<IFhirResource>> getRelatedResourcesForEncounter({
    required String encounterId,
    String? sourceId,
  }) async {
    final localDtos = await _datasource.getResourcesByEncounterId(
      encounterId: encounterId,
      sourceId: sourceId,
    );

    return localDtos.map(IFhirResource.fromLocalDto).toList();
  }

  @override
  Future<Map<String, dynamic>?> resolveReference(String reference) async {
    return await _datasource.resolveReference(reference);
  }

  @override
  Future<String?> getReferenceDisplayName(String reference) async {
    final resolved = await resolveReference(reference);
    if (resolved == null) return null;

    // Extract display name from resolved resource
    return resolved['name']?.toString() ??
        resolved['title']?.toString() ??
        reference;
  }
}
