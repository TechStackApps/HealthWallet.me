import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetResourcesUseCase {
  final FhirRepository _fhirRepository;

  GetResourcesUseCase(this._fhirRepository);

  Future<List<FhirResource>> call({String? resourceType, String? sourceId}) {
    return _fhirRepository.getResources(
        resourceType: resourceType, sourceId: sourceId);
  }
}
