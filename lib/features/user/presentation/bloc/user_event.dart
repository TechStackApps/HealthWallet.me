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
class UserDataUpdatedFromSync extends UserEvent with _$UserDataUpdatedFromSync {
  const factory UserDataUpdatedFromSync() = _UserDataUpdatedFromSync;
}

@freezed
class UserNameUpdated extends UserEvent with _$UserNameUpdated {
  const factory UserNameUpdated(String name) = _UserNameUpdated;
}
