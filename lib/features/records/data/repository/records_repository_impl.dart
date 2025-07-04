import 'package:health_wallet/features/records/data/data_source/local/records_local_data_source.dart';
import 'package:health_wallet/features/records/data/data_source/remote/records_remote_data_source.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final RecordsRemoteDataSource _remoteDataSource;
  final RecordsLocalDataSource _localDataSource;

  RecordsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<FhirResource>> getResources(
      {required String resourceType}) async {
    final localResources =
        await _localDataSource.getResources(resourceType: resourceType);
    if (localResources.isNotEmpty) {
      return localResources;
    }
    final remoteResources =
        await _remoteDataSource.getResources(resourceType: resourceType);
    await _localDataSource.saveResources(remoteResources);
    return remoteResources;
  }
}
