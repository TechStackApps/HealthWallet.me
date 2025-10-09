part of 'fhir_mapper_bloc.dart';

abstract class FhirMapperEvent {
  const FhirMapperEvent();
}

@freezed
class FhirMapperInitialised extends FhirMapperEvent
    with _$FhirMapperInitialised {
  const factory FhirMapperInitialised() = _FhirMapperInitialised;
}

@freezed
class FhirMapperModelDownloadInitiated extends FhirMapperEvent
    with _$FhirMapperModelDownloadInitiated {
  const factory FhirMapperModelDownloadInitiated() =
      _FhirMapperModelDownloadInitiated;
}

class _DownloadProgressChanged extends FhirMapperEvent {
  _DownloadProgressChanged(this.progress);

  final double progress;
}
