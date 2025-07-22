part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool isLaunchingUrl,
    @Default(false) bool urlLaunchSuccess,
    @Default(false) bool isOnboardingCompleted,
    @Default(false) bool isScannerActive,
    @Default(false) bool isSyncing,
    @Default(false) bool syncCompleted,
    String? errorMessage,
    String? scannedQRCode,
  }) = _OnboardingState;
}
