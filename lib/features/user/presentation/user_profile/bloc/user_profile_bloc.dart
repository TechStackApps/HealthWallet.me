import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';
part 'user_profile_bloc.freezed.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(
    this._userRepository,
    // this._authRepository,
  ) : super(const UserProfileState()) {
    on<UserProfileInitialised>(_onUserProfileInitialised);
    on<UserProfileRefreshed>(_onUserProfileRefreshed);
    on<UserProfileUserUpdated>(_onUserProfileUserUpdated);
    on<UserProfileUserDeleted>(_onUserProfileUserDeleted);
    on<UserProfileSignedOut>(_onUserProfileSignedOut);
    on<UserProfilePictureUpdated>(_onUserProfilePictureUpdated);
    on<UserProfileEmailVerified>(_onUserProfileEmailVerified);
    on<UserProfileThemeToggled>(_onUserProfileThemeToggled);
  }

  final UserRepository _userRepository;
  // final AuthenticationRepository _authRepository;

  Future<void> _onUserProfileInitialised(
    UserProfileInitialised event,
    Emitter<UserProfileState> emit,
  ) async {
    await _getCurrentUser(false, emit);
  }

  Future<void> _onUserProfileRefreshed(
    UserProfileRefreshed event,
    Emitter<UserProfileState> emit,
  ) async {
    await _getCurrentUser(true, emit);
  }

  Future<void> _getCurrentUser(
    bool fetchFromNetwork,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      final user = await _userRepository.getCurrentUser(
          fetchFromNetwork: fetchFromNetwork);
      emit(state.copyWith(
          status: const UserProfileStatus.success(), user: user));
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfileUserUpdated(
    UserProfileUserUpdated event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      await _userRepository.updateUser(event.user);
      emit(
        state.copyWith(
            status: const UserProfileStatus.success(), user: event.user),
      );
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfileUserDeleted(
    UserProfileUserDeleted event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      await _userRepository.deleteUser();
      emit(state.copyWith(status: const UserProfileStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfileSignedOut(
    UserProfileSignedOut event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      await _userRepository.clearUser();
      // await _authRepository.logout();
      emit(state.copyWith(status: const UserProfileStatus.logOutSuccess()));
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfilePictureUpdated(
    UserProfilePictureUpdated event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      await _userRepository.updateProfilePicture(event.photoUrl);
      final user = await _userRepository.getCurrentUser();
      emit(state.copyWith(
          status: const UserProfileStatus.success(), user: user));
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfileEmailVerified(
    UserProfileEmailVerified event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      await _userRepository.verifyEmail();
      final user = await _userRepository.getCurrentUser();
      emit(state.copyWith(
          status: const UserProfileStatus.success(), user: user));
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }

  Future<void> _onUserProfileThemeToggled(
    UserProfileThemeToggled event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: const UserProfileStatus.loading()));
    try {
      final updatedUser = state.user.copyWith(
        isDarkMode: !state.user.isDarkMode,
      );
      await _userRepository.updateUser(updatedUser);
      emit(
        state.copyWith(
            status: const UserProfileStatus.success(), user: updatedUser),
      );
    } catch (e) {
      emit(state.copyWith(status: UserProfileStatus.failure(e)));
    }
  }
}
