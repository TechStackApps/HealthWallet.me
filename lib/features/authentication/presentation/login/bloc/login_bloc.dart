import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/authentication/domain/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';

part 'login_event.dart';

part 'login_bloc.freezed.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithApplePressed>(_onLoginWithApplePressed);
  }

  final AuthenticationRepository _authRepository;

  void _checkCanLogin(Emitter<LoginState> emit) {
    emit(state.copyWith(canLogIn: state.email != '' && state.password != ''));
  }

  void _onLoginEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(email: event.value));
    _checkCanLogin(emit);
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(password: event.value));
    _checkCanLogin(emit);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const LoginStatus.loading(), canLogIn: false));

    try {
      await _authRepository.login(email: state.email, password: state.password);

      emit(state.copyWith(status: const LoginStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure(e), canLogIn: true));
    }
  }

  void _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const LoginStatus.loading(), canLogIn: false));

    try {
      await _authRepository.loginWithGoogle();

      emit(state.copyWith(status: const LoginStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure(e), canLogIn: true));
    }
  }

  void _onLoginWithApplePressed(
    LoginWithApplePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: const LoginStatus.loading(), canLogIn: false));

    try {
      await _authRepository.loginWithApple();

      emit(state.copyWith(status: const LoginStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure(e), canLogIn: true));
    }
  }
}
