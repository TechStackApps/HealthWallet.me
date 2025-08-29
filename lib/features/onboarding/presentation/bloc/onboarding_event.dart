part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

@freezed
class OnboardingPageChanged extends OnboardingEvent
    with _$OnboardingPageChanged {
  const factory OnboardingPageChanged(int page) = _OnboardingPageChanged;
}

@freezed
class OnboardingNextPage extends OnboardingEvent with _$OnboardingNextPage {
  const factory OnboardingNextPage() = _OnboardingNextPage;
}

@freezed
class OnboardingPreviousPage extends OnboardingEvent
    with _$OnboardingPreviousPage {
  const factory OnboardingPreviousPage() = _OnboardingPreviousPage;
}

@freezed
class OnboardingLaunchUrl extends OnboardingEvent with _$OnboardingLaunchUrl {
  const factory OnboardingLaunchUrl(String url) = _OnboardingLaunchUrl;
}
