part of 'user_profile_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

@freezed
class UserProfileInitialised extends UserProfileEvent
    with _$UserProfileInitialised {
  const factory UserProfileInitialised() = _UserProfileInitialised;
}

@freezed
class UserProfileRefreshed extends UserProfileEvent
    with _$UserProfileInitialised {
  const factory UserProfileRefreshed() = _UserProfileRefreshed;
}

@freezed
class UserProfileUserUpdated extends UserProfileEvent
    with _$UserProfileUserUpdated {
  const factory UserProfileUserUpdated({
    required User user,
  }) = _UserProfileUserUpdated;
}

@freezed
class UserProfileUserDeleted extends UserProfileEvent
    with _$UserProfileUserDeleted {
  const factory UserProfileUserDeleted() = _UserProfileUserDeleted;
}

@freezed
class UserProfileSignedOut extends UserProfileEvent
    with _$UserProfileSignedOut {
  const factory UserProfileSignedOut() = _UserProfileSignedOut;
}

@freezed
class UserProfilePictureUpdated extends UserProfileEvent
    with _$UserProfilePictureUpdated {
  const factory UserProfilePictureUpdated({
    required String photoUrl,
  }) = _UserProfilePictureUpdated;
}

@freezed
class UserProfileEmailVerified extends UserProfileEvent
    with _$UserProfileEmailVerified {
  const factory UserProfileEmailVerified() = _UserProfileEmailVerified;
}

@freezed
class UserProfileThemeToggled extends UserProfileEvent
    with _$UserProfileThemeToggled {
  const factory UserProfileThemeToggled() = _UserProfileThemeToggled;
}