part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

@freezed
class UserInitialised extends UserEvent with _$UserInitialised {
  const factory UserInitialised() = _UserInitialised;
}

@freezed
class UserThemeToggled extends UserEvent with _$UserThemeToggled {
  const factory UserThemeToggled() = _UserThemeToggled;
}

@freezed
class UserBiometricAuthToggled extends UserEvent
    with _$UserBiometricAuthToggled {
  const factory UserBiometricAuthToggled(bool isEnabled) =
      _UserBiometricAuthToggled;
}

@freezed
class UserPatientsLoaded extends UserEvent with _$UserPatientsLoaded {
  const factory UserPatientsLoaded() = _UserPatientsLoaded;
}

@freezed
class UserPatientReorder extends UserEvent with _$UserPatientReorder {
  const factory UserPatientReorder(String patientId) = _UserPatientReorder;
}
