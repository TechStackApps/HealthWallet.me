import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:injectable/injectable.dart';

abstract class RecordsLocalDataSource {
  Future<List<FhirResource>> getResources({required String resourceType});
  Future<void> saveResources(List<FhirResource> resources);
}

@Injectable(as: RecordsLocalDataSource)
class RecordsLocalDataSourceImpl implements RecordsLocalDataSource {
  @override
  Future<List<FhirResource>> getResources({required String resourceType}) {
    // TODO: implement getResources
    throw UnimplementedError();
  }

  @override
  Future<void> saveResources(List<FhirResource> resources) {
    // TODO: implement saveResources
    throw UnimplementedError();
  }
}
