import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSourcesUseCase {
  final FhirRepository _fhirRepository;

  GetSourcesUseCase(this._fhirRepository);

  Future<List<Source>> call() {
    return _fhirRepository.getSources();
  }
}
