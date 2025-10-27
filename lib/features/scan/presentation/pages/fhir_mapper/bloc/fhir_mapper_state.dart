part of 'fhir_mapper_bloc.dart';

@freezed
class FhirMapperState with _$FhirMapperState {
  const factory FhirMapperState({
    @Default(FhirMapperStatus.initial) FhirMapperStatus status,
    @Default([]) List<MappingResource> resources,
    @Default([]) List<String> scannedImages,
    @Default([]) List<String> importedImages,
    @Default([]) List<String> importedPdfs,
    @Default([]) List<String> allImagePathsForOCR,
    String? errorMessage,
  }) = _FhirMapperState;
}

enum FhirMapperStatus {
  initial,
  convertingPdfs,
  mappingReady,
  mapping,
  editingResources,
  savingResources,
  success,
  failure,
}
