import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';

abstract class RecordsRemoteDataSource {
  Future<List<FhirResource>> getResources({required String resourceType});
}
