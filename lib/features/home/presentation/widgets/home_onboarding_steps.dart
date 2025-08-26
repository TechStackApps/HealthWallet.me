import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

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
