part of 'fhir_mapper_bloc.dart';

@freezed
class FhirMapperState with _$FhirMapperState {
  const factory FhirMapperState({
    @Default(FhirMapperStatus.modelLoading) FhirMapperStatus status,
    double? downloadProgress,
  }) = _FhirMapperState;
}

enum FhirMapperStatus {
  modelAbsent,
  modelLoading,
  modelLoaded,
  mappingLoading,
  success,
  error,
}
