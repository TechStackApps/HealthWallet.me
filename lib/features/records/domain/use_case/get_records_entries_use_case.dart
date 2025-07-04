import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecordsEntriesUseCase {
  final RecordsRepository _repository;

  GetRecordsEntriesUseCase(this._repository);

  Future<List<FhirResource>> call({required String resourceType}) {
    return _repository.getResources(resourceType: resourceType);
  }
}
