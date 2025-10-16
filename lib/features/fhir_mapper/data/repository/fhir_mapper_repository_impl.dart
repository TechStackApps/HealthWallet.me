import 'dart:convert';
import 'dart:developer';

import 'package:flutter_gemma/mobile/flutter_gemma_mobile.dart';
import 'package:health_wallet/features/fhir_mapper/data/datasource/fhir_mapper_remote_datasource.dart';
import 'package:health_wallet/features/fhir_mapper/data/model/prompt_template/prompt_template.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_observation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
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

  @override
  Future<List<MappingResource>> mapResources(String medicalText) async {
    List<MappingResource> resources = [];

    await _datasource
        .startModelSession(SlmModel.gemmaModel().toInferenceSpec());

    for (PromptTemplate promptTemplate in PromptTemplate.supportedPrompts()) {
      String prompt = promptTemplate.buildPrompt(medicalText);

      String? promptResponse = await _datasource.runPrompt(prompt);

      List<dynamic> jsonList = jsonDecode(promptResponse ?? '');

      for (Map<String, dynamic> json in jsonList) {
        resources.add(MappingResource.fromJson(json));
      }
    }

    _datasource.closeModelSession();

    return resources;
  }
}
