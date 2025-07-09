import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/onboarding/presentation/pages/auth_page.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  OnboardingScreen(
                    title: context.l10n.onboardingWelcomeTitle,
                    subtitle: context.l10n.onboardingWelcomeSubtitle,
                    description: context.l10n.onboardingWelcomeDescription,
                    icon: Icons.favorite_border,
                  ),
                  OnboardingScreen(
                    title: context.l10n.onboardingRecordsTitle,
                    subtitle: context.l10n.onboardingRecordsSubtitle,
                    description: context.l10n.onboardingRecordsDescription,
                    icon: Icons.folder_open_outlined,
                  ),
                  OnboardingScreen(
                    title: context.l10n.onboardingSyncTitle,
                    subtitle: context.l10n.onboardingSyncSubtitle,
                    description: context.l10n.onboardingSyncDescription,
                    icon: Icons.shield_outlined,
                  ),
                  const AuthPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 0)
                    TextButton.icon(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: Text(context.l10n.onboardingBack),
                    )
                  else
                    const SizedBox(),
                  Row(
                    children: List.generate(
                      4,
                      (index) => _buildDot(index, context),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_currentPage == 3) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('hasSeenOnboarding', true);
                        context.appRouter.replace(const DashboardRoute());
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == 3
                          ? context.l10n.onboardingGetStarted
                          : context.l10n.onboardingNext,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.medium),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: Insets.extraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index ? context.theme.primaryColor : Colors.grey,
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;

  const OnboardingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: context.theme.primaryColor),
          const SizedBox(height: Insets.extraLarge),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Insets.small),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.theme.primaryColor,
            ),
          ),
          const SizedBox(height: Insets.medium),
          Text(
            description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
