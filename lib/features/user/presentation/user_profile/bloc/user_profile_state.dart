part of 'user_profile_bloc.dart';

@freezed
sealed class UserProfileStatus with _$UserProfileStatus {
  const factory UserProfileStatus.initial() = _Initial;
  const factory UserProfileStatus.loading() = _Loading;
  const factory UserProfileStatus.success() = _Success;
  const factory UserProfileStatus.logOutSuccess() = _LogOutSuccess;
  const factory UserProfileStatus.failure(Object exception) = _Failure;
}

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(UserProfileStatus.initial()) UserProfileStatus status,
    @Default(User()) User user,
    @Default(false) bool isBiometricAuthEnabled,
  }) = _UserProfileState;
}
