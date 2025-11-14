part of 'fhir_mapper_bloc.dart';

@freezed
class FhirMapperState with _$FhirMapperState {
  const factory FhirMapperState({
    @Default(ProcessingSession()) ProcessingSession session,
    @Default(FhirMapperStatus.initial) FhirMapperStatus status,
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
