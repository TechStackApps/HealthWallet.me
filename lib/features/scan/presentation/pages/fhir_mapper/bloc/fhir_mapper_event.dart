part of 'fhir_mapper_bloc.dart';

abstract class FhirMapperEvent {
  const FhirMapperEvent();
}

@freezed
class FhirMapperSessionCreated extends FhirMapperEvent
    with _$FhirMapperSessionCreated {
  const factory FhirMapperSessionCreated({
    required ProcessingSession session,
  }) = _FhirMapperSessionCreated;
}

@freezed
class FhirMapperPageInitialized extends FhirMapperEvent
    with _$FhirMapperPageInitialized {
  const factory FhirMapperPageInitialized({
    required String sessionId,
    required List<PatientGroup> currentPatients,
  }) = _FhirMapperPageInitialized;
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
class FhirMapperResourceRemoved extends FhirMapperEvent
    with _$FhirMapperResourceRemoved {
  const factory FhirMapperResourceRemoved({required int index}) =
      _FhirMapperResourceRemoved;
}

@freezed
class FhirMapperResourceCreationInitiated extends FhirMapperEvent
    with _$FhirMapperResourceCreationInitiated {
  const factory FhirMapperResourceCreationInitiated() =
      _FhirMapperResourceCreationInitiated;
}

@freezed
class FhirMapperPatientSelected extends FhirMapperEvent
    with _$FhirMapperPatientSelected {
  const factory FhirMapperPatientSelected(
      {required PatientGroup patientGroup}) = _FhirMapperPatientSelected;
}
