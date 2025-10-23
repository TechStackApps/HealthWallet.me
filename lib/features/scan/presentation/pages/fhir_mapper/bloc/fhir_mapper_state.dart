part of 'fhir_mapper_bloc.dart';

@freezed
class FhirMapperState with _$FhirMapperState {
  const factory FhirMapperState({
    @Default(FhirMapperStatus.initial) FhirMapperStatus status,
    @Default([]) List<MappingResource> resources,
  }) = _FhirMapperState;
}

enum FhirMapperStatus {
  initial,
  loading,
  success,
  error,
}
