part of 'fhir_mapper_bloc.dart';

@freezed
class FhirMapperState with _$FhirMapperState {
  const factory FhirMapperState({
    @Default(FhirMapperStatus.initial) FhirMapperStatus status,
    @Default([]) List<MappingResource> resources,
    @Default(0.0) double mappingProgress,
    @Default([]) List<IFhirResource> fhirResources,
    @Default([]) List<String> scannedImages,
    @Default([]) List<String> importedImages,
    @Default([]) List<String> importedPdfs,
    @Default([]) List<String> allImagePathsForOCR,
    String? errorMessage,
    @Default([]) List<PatientGroup> currentPatients,
    PatientGroup? selectedPatient,
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
