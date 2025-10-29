import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:injectable/injectable.dart';

part 'load_model_event.dart';
part 'load_model_state.dart';
part 'load_model_bloc.freezed.dart';

@Injectable()
class LoadModelBloc extends Bloc<LoadModelEvent, LoadModelState> {
  LoadModelBloc(this._repository) : super(const LoadModelState()) {
    on<LoadModelInitialized>(_onLoadModelInitialized);
    on<LoadModelDownloadInitiated>(_onLoadModelDownloadInitiated,
        transformer: restartable());
  }

  final ScanRepository _repository;

  void _onLoadModelInitialized(
    LoadModelInitialized event,
    Emitter<LoadModelState> emit,
  ) async {
    bool isModelLoaded = false;
    try {
      isModelLoaded = await _repository.checkModelExistence();
    } on Exception catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: LoadModelStatus.error,
          errorMessage: 'An error appeared while checking model existence'));
    } finally {
      emit(state.copyWith(
        status: isModelLoaded
            ? LoadModelStatus.modelLoaded
            : LoadModelStatus.modelAbsent,
      ));
    }
  }

  void _onLoadModelDownloadInitiated(
    LoadModelDownloadInitiated event,
    Emitter<LoadModelState> emit,
  ) async {
    emit(state.copyWith(status: LoadModelStatus.loading));

    try {
      final stream = _repository.downloadModel();

      await for (final progress in stream) {
        if (emit.isDone) return;

        emit(state.copyWith(downloadProgress: progress));
      }

      emit(state.copyWith(status: LoadModelStatus.modelLoaded));
    } catch (_) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
            status: LoadModelStatus.error,
            errorMessage: 'An error appeared while downloading the model'),
      );
    }
  }
}
