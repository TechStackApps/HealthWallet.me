import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:injectable/injectable.dart';

abstract class RecordsRemoteDataSource {
  Future<List<FhirResource>> getResources({required String resourceType});
}

@Injectable(as: RecordsRemoteDataSource)
class RecordsRemoteDataSourceImpl implements RecordsRemoteDataSource {
  @override
  Future<List<FhirResource>> getResources({required String resourceType}) {
    // TODO: implement getResources
    throw UnimplementedError();
  }
}
