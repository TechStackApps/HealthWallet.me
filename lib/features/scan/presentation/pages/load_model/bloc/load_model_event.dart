part of 'load_model_bloc.dart';

abstract class LoadModelEvent {
  const LoadModelEvent();
}

@freezed
class LoadModelInitialized extends LoadModelEvent
    with _$LoadModelInitialized {
  const factory LoadModelInitialized() = _LoadModelInitialized;
}

@freezed
class LoadModelDownloadInitiated extends LoadModelEvent
    with _$LoadModelDownloadInitiated {
  const factory LoadModelDownloadInitiated() =
      _LoadModelDownloadInitiated;
}

class _DownloadProgressChanged extends LoadModelEvent {
  _DownloadProgressChanged(this.progress);

  final double progress;
}