import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';
import 'package:health_wallet/features/records/domain/entity/records_entry.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecordsEntriesUseCase {
  final RecordsRepository _repository;

  GetRecordsEntriesUseCase(this._repository);

  Future<List<RecordsEntry>> call({String? filter}) {
    return _repository.getTimelineEntries(filter: filter);
  }

  Future<List<RecordsEntry>> forAllergy(Allergy allergy) {
    return _repository.getTimelineEntriesForAllergy(allergy);
  }
}
