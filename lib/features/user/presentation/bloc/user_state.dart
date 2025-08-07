part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(UserStatus.initial()) UserStatus status,
    @Default(User()) User user,
    @Default(false) bool isBiometricAuthEnabled,
    @Default([]) List<Patient> patients,
    @Default({}) Set<String> expandedPatientIds,
    @Default('') String animatingPatientId,
    @Default('') String collapsingPatientId,
    @Default('') String expandingPatientId,
    @Default('') String swappingFromPatientId,
    @Default('') String swappingToPatientId,
    @Default(PatientAnimationPhase.none) PatientAnimationPhase animationPhase,
  }) = _UserState;
}

@freezed
class UserStatus with _$UserStatus {
  const factory UserStatus.initial() = _Initial;
  const factory UserStatus.loading() = _Loading;
  const factory UserStatus.success() = _Success;
  const factory UserStatus.failure(Object exception) = _Failure;
}

enum PatientAnimationPhase {
  none,
  collapsing,
  swapping,
  expanding,
}
