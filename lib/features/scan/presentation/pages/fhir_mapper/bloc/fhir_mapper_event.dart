part of 'fhir_mapper_bloc.dart';

abstract class FhirMapperEvent {
  const FhirMapperEvent();
}

@freezed
class FhirMapperImagesPrepared extends FhirMapperEvent
    with _$FhirMapperImagesPrepared {
  const factory FhirMapperImagesPrepared({
    required List<String> scannedImages,
    required List<String> importedImages,
    required List<String> importedPdfs,
  }) = _FhirMapperImagesPrepared;
}

@freezed
class FhirMappingInitiated extends FhirMapperEvent with _$FhirMappingInitiated {
  const factory FhirMappingInitiated() = _FhirMappingInitiated;
}

@freezed
class FhirMapperResourceChanged extends FhirMapperEvent
    with _$FhirMapperResourceChanged {
  const factory FhirMapperResourceChanged({
    required int index,
    required String propertyKey,
    required String newValue,
  }) = _FhirMapperResourceChanged;
}

@freezed
class FhirMapperEncounterCreationInitiated extends FhirMapperEvent
    with _$FhirMapperEncounterCreationInitiated {
  const factory FhirMapperEncounterCreationInitiated({
    required String encounterName,
    required HomeState homeState,
    required PatientState patientState,
  }) = _FhirMapperEncounterCreationInitiated;
}
