import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/authentication/domain/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.dart';

part 'signup_event.dart';

part 'signup_bloc.freezed.dart';

@Injectable()
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this._authRepository) : super(const SignupState()) {
    on<SignupEmailChanged>(_onSignupEmailChanged);
    on<SignupFirstNameChanged>(_onSignupFirstNameChanged);
    on<SignupLastNameChanged>(_onSignupLastNameChanged);
    on<SignupPasswordChanged>(_onSignupPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onSignupConfirmPasswordChanged);
    on<SignupButtonPressed>(_onSignupButtonPressed);
    on<SignupWithGooglePressed>(_onSignupWithGooglePressed);
    on<SignupWithApplePressed>(_onSignupWithApplePressed);
  }

  final AuthenticationRepository _authRepository;

  void _checkCanSignup(Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        canSignUp: state.email != '' &&
            state.firstName != '' &&
            state.lastName != '' &&
            state.password != '' &&
            state.confirmPassword != '',
      ),
    );
  }

  void _onSignupEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(email: event.value));
    _checkCanSignup(emit);
  }

  void _onSignupFirstNameChanged(
    SignupFirstNameChanged event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(firstName: event.value));
    _checkCanSignup(emit);
  }

  void _onSignupLastNameChanged(
    SignupLastNameChanged event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(lastName: event.value));
    _checkCanSignup(emit);
  }

  void _onSignupPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(password: event.value));
    _checkCanSignup(emit);
  }

  void _onSignupConfirmPasswordChanged(
    SignupConfirmPasswordChanged event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(confirmPassword: event.value));
    _checkCanSignup(emit);
  }

  void _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(
      state.copyWith(status: const SignupStatus.loading(), canSignUp: false),
    );

    try {
      await _authRepository.signup(
        email: state.email,
        firstName: state.firstName,
        lastName: state.lastName,
        password: state.password,
      );

      emit(state.copyWith(status: const SignupStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.failure(e), canSignUp: true));
    }
  }

  void _onSignupWithGooglePressed(
    SignupWithGooglePressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(
      state.copyWith(status: const SignupStatus.loading(), canSignUp: false),
    );

    try {
      await _authRepository.loginWithGoogle();

      emit(state.copyWith(status: const SignupStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.failure(e), canSignUp: true));
    }
  }

  void _onSignupWithApplePressed(
    SignupWithApplePressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(
      state.copyWith(status: const SignupStatus.loading(), canSignUp: false),
    );

    try {
      await _authRepository.loginWithApple();

      emit(state.copyWith(status: const SignupStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: SignupStatus.failure(e), canSignUp: true));
    }
  }
}
