part of 'signup_bloc.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    @Default(SignupStatus.initial()) SignupStatus status,
    @Default('') String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool canSignUp,
  }) = _SignupState;
}

@freezed
sealed class SignupStatus with _$SignupStatus {
  const factory SignupStatus.initial() = _Initial;
  const factory SignupStatus.loading() = _Loading;
  const factory SignupStatus.success() = _Success;
  const factory SignupStatus.failure(Object error) = _Failure;
}
