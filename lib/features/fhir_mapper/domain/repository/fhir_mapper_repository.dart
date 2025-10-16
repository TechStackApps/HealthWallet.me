import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';

abstract class FhirMapperRepository {
  Stream<double> downloadModel();

  Future<bool> checkModelExistence();

  Future<List<MappingResource>> mapResources(String medicalText);
}
