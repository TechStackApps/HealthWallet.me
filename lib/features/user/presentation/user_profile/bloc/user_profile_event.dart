part of 'user_profile_bloc.dart';

@freezed
class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.initialised() = UserProfileInitialised;
  const factory UserProfileEvent.refreshed() = UserProfileRefreshed;
  const factory UserProfileEvent.userUpdated({required User user}) =
      UserProfileUserUpdated;
  const factory UserProfileEvent.userDeleted() = UserProfileUserDeleted;
  const factory UserProfileEvent.signedOut() = UserProfileSignedOut;
  const factory UserProfileEvent.pictureUpdated({required String photoUrl}) =
      UserProfilePictureUpdated;
  const factory UserProfileEvent.emailVerified() = UserProfileEmailVerified;
  const factory UserProfileEvent.themeToggled() = UserProfileThemeToggled;
  const factory UserProfileEvent.biometricAuthToggled(bool isEnabled) =
      UserProfileBiometricAuthToggled;
}
