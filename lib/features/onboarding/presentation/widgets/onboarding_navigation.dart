import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingNavigation extends StatelessWidget {
  final PageController pageController;
  final int currentPage;

  const OnboardingNavigation({
    super.key,
    required this.pageController,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Row(
        children: [
          // Fixed width container for back button to prevent layout shifts
          SizedBox(
            width: 120,
            child: currentPage != 0
                ? TextButton.icon(
                    onPressed: () {
                      context
                          .read<OnboardingBloc>()
                          .add(const OnboardingPreviousPage());
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: Text(context.l10n.onboardingBack),
                  )
                : null,
          ),
          // Centered dots with fixed positioning
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => _buildDot(index, context, currentPage),
              ),
            ),
          ),
          // Fixed width container for next button
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                if (currentPage == 2) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasSeenOnboarding', true);
                  context.appRouter.replace(const DashboardRoute());
                } else {
                  // Reset sync state when moving to next page to ensure we don't stay on success state
                  context
                      .read<OnboardingBloc>()
                      .add(const OnboardingResetSync());
                  context
                      .read<OnboardingBloc>()
                      .add(const OnboardingNextPage());
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(
                currentPage == 2
                    ? context.l10n.onboardingGetStarted
                    : context.l10n.onboardingNext,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context, int currentPage) {
    return Container(
      height: 10,
      width: currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: Insets.extraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentPage == index ? context.theme.primaryColor : Colors.grey,
      ),
    );
  }
}
