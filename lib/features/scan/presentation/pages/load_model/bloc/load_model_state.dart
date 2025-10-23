part of 'load_model_bloc.dart';

@freezed
class LoadModelState with _$LoadModelState {
  const factory LoadModelState({
    @Default(LoadModelStatus.loading) LoadModelStatus status,
    double? downloadProgress,
  }) = _LoadModelState;
}

enum LoadModelStatus {
  modelAbsent,
  loading,
  modelLoaded,
  error,
}

