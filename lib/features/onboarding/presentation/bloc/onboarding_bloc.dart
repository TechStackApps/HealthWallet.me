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
    print('OnboardingBloc: Launching URL: ${event.url}');
    emit(state.copyWith(isLaunchingUrl: true));

    try {
      final url = Uri.parse(event.url);
      print('OnboardingBloc: Parsed URL: $url');
      if (await canLaunchUrl(url)) {
        print('OnboardingBloc: Can launch URL, attempting to launch...');
        final launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        print('OnboardingBloc: Launch result: $launched');
        emit(state.copyWith(
          isLaunchingUrl: false,
          urlLaunchSuccess: launched,
        ));
      } else {
        print('OnboardingBloc: Cannot launch URL');
        emit(state.copyWith(
          isLaunchingUrl: false,
          urlLaunchSuccess: false,
        ));
      }
    } catch (e) {
      print('OnboardingBloc: Error launching URL: $e');
      emit(state.copyWith(
        isLaunchingUrl: false,
        urlLaunchSuccess: false,
        errorMessage: 'Could not open link. Please try again.',
      ));
    }
  }
}
