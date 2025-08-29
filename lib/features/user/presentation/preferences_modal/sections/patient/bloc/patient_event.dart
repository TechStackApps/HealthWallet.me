part of 'patient_bloc.dart';

abstract class PatientEvent {
  const PatientEvent();
}

@freezed
class PatientInitialised extends PatientEvent with _$PatientInitialised {
  const factory PatientInitialised() = _PatientInitialised;
}

@freezed
class PatientPatientsLoaded extends PatientEvent with _$PatientPatientsLoaded {
  const factory PatientPatientsLoaded() = _PatientPatientsLoaded;
}

@freezed
class PatientReorder extends PatientEvent with _$PatientReorder {
  const factory PatientReorder(String patientId) = _PatientReorder;
}

@freezed
class PatientDataUpdatedFromSync extends PatientEvent
    with _$PatientDataUpdatedFromSync {
  const factory PatientDataUpdatedFromSync() = _PatientDataUpdatedFromSync;
}

@freezed
class PatientEditStarted extends PatientEvent with _$PatientEditStarted {
  const factory PatientEditStarted(String patientId) = _PatientEditStarted;
}

@freezed
class PatientEditCancelled extends PatientEvent with _$PatientEditCancelled {
  const factory PatientEditCancelled() = _PatientEditCancelled;
}

@freezed
class PatientEditSaved extends PatientEvent with _$PatientEditSaved {
  const factory PatientEditSaved({
    required String patientId,
    required String sourceId,
    required DateTime birthDate,
    required String gender,
    required String bloodType,
  }) = _PatientEditSaved;
}

@freezed
class PatientSelectionChanged extends PatientEvent
    with _$PatientSelectionChanged {
  const factory PatientSelectionChanged({
    required String patientId,
    required String sourceId,
  }) = _PatientSelectionChanged;
}
