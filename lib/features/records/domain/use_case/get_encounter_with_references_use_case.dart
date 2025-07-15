import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEncounterWithReferencesUseCase {
  final FhirRepository _fhirRepository;

  GetEncounterWithReferencesUseCase(this._fhirRepository);

  Future<List<FhirResource>> call(String encounterId) {
    return _fhirRepository.getEncounterWithReferences(encounterId);
  }
}
