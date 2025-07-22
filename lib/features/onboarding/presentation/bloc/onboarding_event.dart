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

@freezed
class OnboardingScanQR extends OnboardingEvent with _$OnboardingScanQR {
  const factory OnboardingScanQR() = _OnboardingScanQR;
}

@freezed
class OnboardingQRCodeDetected extends OnboardingEvent
    with _$OnboardingQRCodeDetected {
  const factory OnboardingQRCodeDetected(String qrCode) =
      _OnboardingQRCodeDetected;
}

@freezed
class OnboardingComplete extends OnboardingEvent with _$OnboardingComplete {
  const factory OnboardingComplete() = _OnboardingComplete;
}

@freezed
class OnboardingResetSync extends OnboardingEvent with _$OnboardingResetSync {
  const factory OnboardingResetSync() = _OnboardingResetSync;
}

@freezed
class OnboardingSyncCompleted extends OnboardingEvent
    with _$OnboardingSyncCompleted {
  const factory OnboardingSyncCompleted() = _OnboardingSyncCompleted;
}
