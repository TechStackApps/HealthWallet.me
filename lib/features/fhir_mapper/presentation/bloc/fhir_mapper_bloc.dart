import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/repository/fhir_mapper_repository.dart';
import 'package:injectable/injectable.dart';

part 'fhir_mapper_event.dart';
part 'fhir_mapper_state.dart';
part 'fhir_mapper_bloc.freezed.dart';

@Injectable()
class FhirMapperBloc extends Bloc<FhirMapperEvent, FhirMapperState> {
  FhirMapperBloc(this._repository) : super(const FhirMapperState()) {
    on<FhirMapperInitialised>(_onFhirMapperInitialised);
    on<FhirMapperModelDownloadInitiated>(_onFhirMapperModelDownloadInitiated);
    on<_DownloadProgressChanged>(_onDownloadProgressChanged);
    on<FhirMappingInitiated>(_onFhirMappingInitiated);
    on<FhirMapperResourceChanged>(_onFhirMapperResourceChanged);
  }

  final FhirMapperRepository _repository;

  void _onFhirMapperInitialised(
    FhirMapperInitialised event,
    Emitter<FhirMapperState> emit,
  ) async {
    bool isModelLoaded = await _repository.checkModelExistence();
    log(isModelLoaded.toString());
    emit(state.copyWith(
      status: isModelLoaded
          ? FhirMapperStatus.modelLoaded
          : FhirMapperStatus.modelAbsent,
    ));
  }

  void _onFhirMapperModelDownloadInitiated(
    FhirMapperModelDownloadInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    emit(state.copyWith(status: FhirMapperStatus.modelLoading));

    final stream = _repository.downloadModel();

    stream.listen((progress) => add(_DownloadProgressChanged(progress)));
  }

  void _onDownloadProgressChanged(
    _DownloadProgressChanged event,
    Emitter<FhirMapperState> emit,
  ) {
    double progress = event.progress;

    if (progress == 100) {
      emit(state.copyWith(status: FhirMapperStatus.modelLoaded));
      return;
    }
    emit(state.copyWith(downloadProgress: event.progress));
  }

  void _onFhirMappingInitiated(
    FhirMappingInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    emit(state.copyWith(status: FhirMapperStatus.mappingLoading));

    List<MappingResource> resources =
        await _repository.mapResources(event.text);

    emit(state.copyWith(
      status: FhirMapperStatus.success,
      resources: resources,
    ));
  }

  void _onFhirMapperResourceChanged(
    FhirMapperResourceChanged event,
    Emitter<FhirMapperState> emit,
  ) {
    MappingResource updatedResource = state.resources[event.index].copyWithMap({
      event.propertyKey: event.newValue,
    });

    final newResources = [...state.resources];
    newResources[event.index] = updatedResource;

    emit(state.copyWith(resources: newResources));
  }
}
