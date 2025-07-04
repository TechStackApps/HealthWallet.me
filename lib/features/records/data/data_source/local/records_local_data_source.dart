import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class RecordsLocalDataSource {
  Future<List<FhirResource>> getResources({required String resourceType});
  Future<void> saveResources(List<FhirResource> resources);
}

@LazySingleton(as: RecordsLocalDataSource)
class RecordsLocalDataSourceImpl implements RecordsLocalDataSource {
  static const String _boxName = 'fhir_resources';

  Future<Box<FhirResource>> _openBox() async {
    return await Hive.openBox<FhirResource>(_boxName);
  }

  @override
  Future<List<FhirResource>> getResources(
      {required String resourceType}) async {
    final box = await _openBox();
    return box.values
        .where((resource) => resource.resourceType == resourceType)
        .toList();
  }

  @override
  Future<void> saveResources(List<FhirResource> resources) async {
    final box = await _openBox();
    for (final resource in resources) {
      await box.put(resource.id, resource);
    }
  }
}
