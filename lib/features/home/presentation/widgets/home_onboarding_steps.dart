import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/presentation/widgets/filter_home_dialog.dart';
import 'package:health_wallet/features/home/core/constants/home_constants.dart';

class HomeOnboardingSteps {
  static List<OnboardingStep> createSteps({
    required FocusNode firstVitalCardFocusNode,
    required FocusNode firstOverviewCardFocusNode,
    required BuildContext context,
  }) {
    return [
      _createVitalsOnboardingStep(firstVitalCardFocusNode, context),
      _createOverviewOnboardingStep(firstOverviewCardFocusNode, context),
    ];
  }

  static OnboardingStep _createVitalsOnboardingStep(
    FocusNode focusNode,
    BuildContext context,
  ) {
    return OnboardingStep(
      focusNode: focusNode,
      titleText: 'Reorder Vital Signs',
      bodyText:
          'Long press on vital cards to reorder them according to your preference.',
      fullscreen: false,
      overlayColor: Colors.black.withOpacity(0.7),
      overlayShape: const CircleBorder(),
      hasLabelBox: true,
      labelBoxDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      labelBoxPadding: const EdgeInsets.all(16),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      arrowPosition: ArrowPosition.bottomCenter,
    );
  }

  static OnboardingStep _createOverviewOnboardingStep(
    FocusNode focusNode,
    BuildContext context,
  ) {
    return OnboardingStep(
      focusNode: focusNode,
      titleText: 'Reorder Overview Cards',
      bodyText:
          'Long press on overview cards to reorder them as well. Customize your dashboard!',
      fullscreen: false,
      overlayColor: Colors.black.withOpacity(0.7),
      overlayShape: const CircleBorder(),
      hasLabelBox: true,
      labelBoxDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      labelBoxPadding: const EdgeInsets.all(16),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      arrowPosition: ArrowPosition.topCenter,
    );
  }
}

class HomeOnboardingController {
  final GlobalKey<OnboardingState> onboardingKey = GlobalKey<OnboardingState>();
  bool _shouldShowOnboarding = false;
  bool _hasTriggeredOnboarding = false;

  bool get shouldShowOnboarding => _shouldShowOnboarding;
  bool get hasTriggeredOnboarding => _hasTriggeredOnboarding;

  Future<void> checkIfShouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding =
        prefs.getBool(HomeConstants.onboardingSeenKey) ?? false;
    _shouldShowOnboarding = !hasSeenOnboarding;
    _hasTriggeredOnboarding = false;
  }

  void triggerOnboardingIfNeeded(HomeState state) {
    if (_shouldShowOnboarding &&
        state.hasDataLoaded &&
        !_hasTriggeredOnboarding &&
        state.patientVitals.isNotEmpty &&
        state.overviewCards.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_hasTriggeredOnboarding) {
          _hasTriggeredOnboarding = true;
          Future.delayed(HomeConstants.onboardingDelay, () {
            if (_shouldShowOnboarding) {
              print(
                  '🎯 Triggering onboarding with vitals: ${state.patientVitals.length}, cards: ${state.overviewCards.length}');
              onboardingKey.currentState?.show();
            }
          });
        }
      });
    }
  }

  Future<void> markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(HomeConstants.onboardingSeenKey, true);
    _shouldShowOnboarding = false;
    _hasTriggeredOnboarding = true;
  }

  void resetTrigger() {
    _hasTriggeredOnboarding = false;
  }
}

class HomeFocusController {
  late final FocusNode firstVitalCardFocusNode;
  late final FocusNode firstOverviewCardFocusNode;

  HomeFocusController() {
    _initializeFocusNodes();
  }

  void _initializeFocusNodes() {
    firstVitalCardFocusNode = FocusNode(debugLabel: 'First Vital Card');
    firstOverviewCardFocusNode = FocusNode(debugLabel: 'First Overview Card');
  }

  void dispose() {
    firstVitalCardFocusNode.dispose();
    firstOverviewCardFocusNode.dispose();
  }
}
