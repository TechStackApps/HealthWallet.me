import 'package:dio/dio.dart';
import 'package:health_wallet/features/records/data/data_source/remote/records_remote_data_source.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRemoteDataSource)
class RecordsRemoteDataSourceImpl implements RecordsRemoteDataSource {
  final Dio _dio;

  RecordsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<FhirResource>> getResources(
      {required String resourceType}) async {
    // TODO: implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}
