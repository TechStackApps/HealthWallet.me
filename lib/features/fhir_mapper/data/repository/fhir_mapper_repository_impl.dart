import 'package:flutter_gemma/mobile/flutter_gemma_mobile.dart';
import 'package:health_wallet/features/fhir_mapper/data/datasource/fhir_mapper_remote_datasource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/slm_model.dart';
import 'package:health_wallet/features/fhir_mapper/domain/repository/fhir_mapper_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FhirMapperRepository)
class FhirMapperRepositoryImpl implements FhirMapperRepository {
  FhirMapperRepositoryImpl(this._datasource);

  final FhirMapperRemoteDatasource _datasource;

  @override
  Stream<double> downloadModel() async* {
    Stream<DownloadProgress> stream =
        _datasource.downloadModel(SlmModel.gemmaModel().toInferenceSpec());

    await for (final progress in stream) {
      yield progress.overallProgress.toDouble();
    }
  }

  @override
  Future<bool> checkModelExistence() =>
      _datasource.checkModelExistence(SlmModel.gemmaModel().toInferenceSpec());
}
