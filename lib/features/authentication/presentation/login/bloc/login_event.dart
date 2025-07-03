part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

@freezed
class LoginEmailChanged extends LoginEvent with _$LoginEmailChanged {
  const factory LoginEmailChanged({required String value}) = _LoginEmailChanged;
}

@freezed
class LoginPasswordChanged extends LoginEvent with _$LoginPasswordChanged {
  const factory LoginPasswordChanged({required String value}) =
      _LoginPasswordChanged;
}

@freezed
class LoginButtonPressed extends LoginEvent with _$LoginButtonPressed {
  const factory LoginButtonPressed() = _LoginButtonPressed;
}

@freezed
class LoginWithGooglePressed extends LoginEvent with _$LoginWithGooglePressed {
  const factory LoginWithGooglePressed() = _LoginWithGooglePressed;
}

@freezed
class LoginWithApplePressed extends LoginEvent with _$LoginWithApplePressed {
  const factory LoginWithApplePressed() = _LoginWithApplePressed;
}
