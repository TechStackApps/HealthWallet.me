part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial()) LoginStatus status,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool canLogIn,
  }) = _LoginState;
}

@freezed
sealed class LoginStatus with _$LoginStatus {
  const factory LoginStatus.initial() = _Initial;
  const factory LoginStatus.loading() = _Loading;
  const factory LoginStatus.success() = _Success;
  const factory LoginStatus.failure(Object error) = _Failure;
}
