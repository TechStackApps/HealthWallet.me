import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
}
