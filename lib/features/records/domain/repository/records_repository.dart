import 'dart:convert';

import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/data/mapper/display_factory_manager.dart';
import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/timeline_resource_model.dart';

abstract class RecordsRepository {
  void reset();

  Future<List<TimelineResourceModel>> getTimelineResources({
    List<String> resourceTypes = const [],
    bool loadMore = false,
    String? sourceId,
  });

  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(
    String encounterId,
  );

  Future<List<String>> getAvailableResourceTypes();

  Future<Map<String, int>> importFhirBundle(
      String bundleJson, String defaultSourceId);

  bool get hasMorePages;

  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  });
}
