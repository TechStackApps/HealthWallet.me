import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
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
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 5.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.isDarkMode
                    ? Colors.white
                    : context.colorScheme.onPrimary,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentPage < 2 ? 'Continue' : 'Get started',
                    style: AppTextStyle.buttonMedium,
                  ),
                  const SizedBox(width: 8),
                  if (currentPage < 2) const Icon(Icons.arrow_forward),
                ],
              ),
            ),
            if (currentPage == 2)
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Privacy Policy',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                      decoration: TextDecoration.underline,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => _buildDot(index, context, currentPage),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context, int currentPage) {
    return GestureDetector(
      onTap: () => pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      child: Container(
        height: 12,
        width: currentPage == index ? 24 : 12,
        margin: EdgeInsets.only(right: index < 2 ? 12 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: currentPage == index
              ? context.colorScheme.primary
                  .withOpacity(context.isDarkMode ? 0.9 : 1.0)
              : context.colorScheme.onSurface.withOpacity(0.3),
          border: Border.all(
            color: context.colorScheme.onSurface.withOpacity(0.15),
            width: currentPage == index ? 0 : 1,
          ),
        ),
      ),
    );
  }
}
