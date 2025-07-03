part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialised() = _Initialised;
  const factory HomeEvent.sourceChanged(String source) = _SourceChanged;
}
