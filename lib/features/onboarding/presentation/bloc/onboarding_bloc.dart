import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'onboarding_bloc.freezed.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPage>(_onNextPage);
    on<OnboardingPreviousPage>(_onPreviousPage);
    on<OnboardingLaunchUrl>(_onLaunchUrl);
    on<OnboardingScanQR>(_onScanQR);
    on<OnboardingQRCodeDetected>(_onQRCodeDetected);
    on<OnboardingComplete>(_onCompleteOnboarding);
    on<OnboardingResetSync>(_onResetSync);
    on<OnboardingSyncCompleted>(_onSyncCompleted);
  }

  void _onPageChanged(
      OnboardingPageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _onNextPage(OnboardingNextPage event, Emitter<OnboardingState> emit) {
    if (state.currentPage < 2) {
      // 3 pages total (0, 1, 2)
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void _onPreviousPage(
      OnboardingPreviousPage event, Emitter<OnboardingState> emit) {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  Future<void> _onLaunchUrl(
      OnboardingLaunchUrl event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(isLaunchingUrl: true));

    try {
      final url = Uri.parse(event.url);
      if (await canLaunchUrl(url)) {
        final launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        emit(state.copyWith(
          isLaunchingUrl: false,
          urlLaunchSuccess: launched,
        ));
      } else {
        emit(state.copyWith(
          isLaunchingUrl: false,
          urlLaunchSuccess: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLaunchingUrl: false,
        urlLaunchSuccess: false,
        errorMessage: 'Could not open link. Please try again.',
      ));
    }
  }

  void _onScanQR(OnboardingScanQR event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isScannerActive: !state.isScannerActive));
  }

  void _onQRCodeDetected(
      OnboardingQRCodeDetected event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      isScannerActive: false,
      scannedQRCode: event.qrCode,
      isSyncing: true,
    ));

    // Trigger sync process with the scanned QR code data
    // This will be handled by the UI layer which has access to the SyncBloc
  }

  void _onCompleteOnboarding(
      OnboardingComplete event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isOnboardingCompleted: true));
  }

  void _onResetSync(OnboardingResetSync event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      isSyncing: false,
      syncCompleted: false,
      scannedQRCode: null,
    ));
  }

  void _onSyncCompleted(
      OnboardingSyncCompleted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      isSyncing: false,
      syncCompleted: true,
      scannedQRCode: null,
    ));
  }
}
