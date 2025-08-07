import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/services/biometric_auth_service.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final BiometricAuthService _biometricAuthService;
  final RecordsRepository _recordsRepository;

  UserBloc(
    this._userRepository,
    this._biometricAuthService,
    this._recordsRepository,
  ) : super(const UserState()) {
    on<UserInitialised>(_onInitialised);
    on<UserThemeToggled>(_onThemeToggled);
    on<UserBiometricAuthToggled>(_onBiometricAuthToggled);
    on<UserPatientsLoaded>(_onPatientsLoaded);
    on<UserPatientReorder>(_onPatientReorder);
  }

  Future<void> _onInitialised(
    UserInitialised event,
    Emitter<UserState> emit,
  ) async {
    await _getCurrentUser(false, emit);
  }

  Future<void> _getCurrentUser(
    bool fetchFromNetwork,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: const UserStatus.loading()));

    final isBiometricAuthEnabled =
        await _userRepository.isBiometricAuthEnabled();

    try {
      User user;
      try {
        user = await _userRepository.getCurrentUser(
            fetchFromNetwork: fetchFromNetwork);
      } catch (e) {
        // If no user exists in local storage, create a default user with system theme
        final systemTheme =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        final isSystemDarkMode = systemTheme == Brightness.dark;

        user = User(
          isDarkMode: isSystemDarkMode,
        );

        // Save the default user to local storage
        await _userRepository.updateUser(user);
      }

      final patients = await _recordsRepository.getAllResources(
        resourceTypes: [FhirType.Patient],
        limit: 10,
      );

      final patientList = patients.whereType<Patient>().toList();
      final expandedIds =
          patientList.isNotEmpty ? {patientList.first.id} : <String>{};

      emit(state.copyWith(
        status: const UserStatus.success(),
        user: user,
        isBiometricAuthEnabled: isBiometricAuthEnabled,
        patients: patientList,
        expandedPatientIds: expandedIds,
      ));
    } catch (e) {
      // If everything fails, create a default user with system theme
      final systemTheme =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isSystemDarkMode = systemTheme == Brightness.dark;

      final defaultUser = User(
        isDarkMode: isSystemDarkMode,
      );

      emit(state.copyWith(
        status: const UserStatus.success(),
        user: defaultUser,
        isBiometricAuthEnabled: isBiometricAuthEnabled,
      ));
    }
  }

  Future<void> _onThemeToggled(
    UserThemeToggled event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: const UserStatus.loading()));
    try {
      final updatedUser = state.user.copyWith(
        isDarkMode: !state.user.isDarkMode,
      );
      await _userRepository.updateUser(updatedUser);
      emit(
        state.copyWith(status: const UserStatus.success(), user: updatedUser),
      );
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure(e)));
    }
  }

  Future<void> _onBiometricAuthToggled(
    UserBiometricAuthToggled event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: const UserStatus.loading()));
    try {
      if (event.isEnabled) {
        final canAuth = await _biometricAuthService.canAuthenticate();
        if (canAuth) {
          final didAuthenticate = await _biometricAuthService.authenticate();
          if (didAuthenticate) {
            await _userRepository.saveBiometricAuth(true);
            emit(
              state.copyWith(
                status: const UserStatus.success(),
                isBiometricAuthEnabled: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: const UserStatus.success(),
                isBiometricAuthEnabled: false,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              status: const UserStatus.success(),
              isBiometricAuthEnabled: false,
            ),
          );
        }
      } else {
        await _userRepository.saveBiometricAuth(false);
        emit(
          state.copyWith(
            status: const UserStatus.success(),
            isBiometricAuthEnabled: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure(e)));
    }
  }

  Future<void> _onPatientsLoaded(
    UserPatientsLoaded event,
    Emitter<UserState> emit,
  ) async {
    try {
      final patients = await _recordsRepository.getAllResources(
        resourceTypes: [FhirType.Patient],
        limit: 10,
      );

      final patientList = patients.whereType<Patient>().toList();
      final expandedIds =
          state.expandedPatientIds.isEmpty && patientList.isNotEmpty
              ? {patientList.first.id}
              : state.expandedPatientIds;

      emit(state.copyWith(
        patients: patientList,
        expandedPatientIds: expandedIds,
      ));
    } catch (e) {
      // Keep existing state on failure
    }
  }

  void _onPatientReorder(
    UserPatientReorder event,
    Emitter<UserState> emit,
  ) async {
    final currentExpandedIds = Set<String>.from(state.expandedPatientIds);
    final currentPatients = List<Patient>.from(state.patients);

    if (currentExpandedIds.contains(event.patientId)) {
      return;
    }

    final selectedPatient = currentPatients.firstWhere(
      (patient) => patient.id == event.patientId,
      orElse: () => currentPatients.first,
    );

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.collapsing,
      animatingPatientId: event.patientId,
    ));

    if (currentExpandedIds.isNotEmpty) {
      final collapsingPatientId = currentExpandedIds.first;

      emit(state.copyWith(
        collapsingPatientId: collapsingPatientId,
      ));

      await Future.delayed(const Duration(milliseconds: 800));

      currentExpandedIds.clear();
      emit(state.copyWith(
        expandedPatientIds: currentExpandedIds,
        collapsingPatientId: '',
      ));

      await Future.delayed(const Duration(milliseconds: 1200));
    }

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.swapping,
      swappingFromPatientId: currentPatients[0].id,
      swappingToPatientId: event.patientId,
    ));

    await Future.delayed(const Duration(milliseconds: 200));

    currentPatients.remove(selectedPatient);
    currentPatients.insert(0, selectedPatient);

    emit(state.copyWith(
      patients: currentPatients,
      swappingFromPatientId: '',
      swappingToPatientId: '',
    ));

    await Future.delayed(const Duration(milliseconds: 800));

    currentExpandedIds.add(event.patientId);
    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.expanding,
      expandedPatientIds: currentExpandedIds,
      expandingPatientId: event.patientId,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      expandingPatientId: '',
    ));

    await Future.delayed(const Duration(milliseconds: 200));

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.none,
      animatingPatientId: '',
      collapsingPatientId: '',
      expandingPatientId: '',
      swappingFromPatientId: '',
      swappingToPatientId: '',
    ));
  }
}
