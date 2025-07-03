part of 'signup_bloc.dart';

abstract class SignupEvent {
  const SignupEvent();
}

@freezed
class SignupEmailChanged extends SignupEvent with _$SignupEmailChanged {
  const factory SignupEmailChanged({required String value}) =
      _SignupEmailChanged;
}

@freezed
class SignupFirstNameChanged extends SignupEvent with _$SignupFirstNameChanged {
  const factory SignupFirstNameChanged({required String value}) =
      _SignupFirstNameChanged;
}

@freezed
class SignupLastNameChanged extends SignupEvent with _$SignupLastNameChanged {
  const factory SignupLastNameChanged({required String value}) =
      _SignupLastNameChanged;
}

@freezed
class SignupPasswordChanged extends SignupEvent with _$SignupPasswordChanged {
  const factory SignupPasswordChanged({required String value}) =
      _SignupPasswordChanged;
}

@freezed
class SignupConfirmPasswordChanged extends SignupEvent
    with _$SignupConfirmPasswordChanged {
  const factory SignupConfirmPasswordChanged({required String value}) =
      _SignupConfirmPasswordChanged;
}

@freezed
class SignupButtonPressed extends SignupEvent with _$SignupButtonPressed {
  const factory SignupButtonPressed() = _SignupButtonPressed;
}

@freezed
class SignupWithGooglePressed extends SignupEvent
    with _$SignupWithGooglePressed {
  const factory SignupWithGooglePressed() = _SignupWithGooglePressed;
}

@freezed
class SignupWithApplePressed extends SignupEvent with _$SignupWithApplePressed {
  const factory SignupWithApplePressed() = _SignupWithApplePressed;
}
