part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool isLaunchingUrl,
    @Default(false) bool urlLaunchSuccess,
    String? errorMessage,
  }) = _OnboardingState;
}
