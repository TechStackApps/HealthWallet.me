import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:health_wallet/features/onboarding/presentation/models/onboarding_screen_data.dart';
import 'package:health_wallet/features/onboarding/presentation/widgets/onboarding_navigation.dart';
import 'package:health_wallet/features/onboarding/presentation/widgets/onboarding_screen.dart';
import 'package:health_wallet/gen/assets.gen.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  List<OnboardingScreenData> get _screens => [
        OnboardingScreenData(
          title: context.l10n.onboardingWelcomeTitle,
          subtitle: context.l10n.onboardingWelcomeSubtitle,
          description: context.l10n.onboardingWelcomeDescription,
          image: Assets.onboarding.onboarding1,
        ),
        OnboardingScreenData(
          title: context.l10n.onboardingRecordsTitle,
          subtitle: context.l10n.onboardingRecordsSubtitle,
          description: context.l10n.onboardingRecordsDescription,
          image: Assets.onboarding.onboarding2,
        ),
        OnboardingScreenData(
          title: context.l10n.onboardingSyncTitle,
          subtitle: context.l10n.onboardingSyncSubtitle,
          description: context.l10n.onboardingSyncDescription,
          image: Assets.onboarding.onboarding3,
          showBiometricToggle: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(),
        ),
      ],
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    AppColors.primary.withValues(alpha: 0.1)
                  ],
                  stops: const [0.5, 1],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2 * MediaQuery.sizeOf(context).height / 3,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          // Close scanner if user swipes to a different page

                          context
                              .read<OnboardingBloc>()
                              .add(OnboardingPageChanged(page));
                        },
                        children: _screens
                            .map((screenData) => OnboardingScreen(
                                  title: screenData.title,
                                  subtitle: screenData.subtitle,
                                  description: screenData.description,
                                  image: screenData.image,
                                  showBiometricToggle:
                                      screenData.showBiometricToggle,
                                ))
                            .toList(),
                      ),
                    ),
                    OnboardingNavigation(
                      pageController: _pageController,
                      currentPage: state.currentPage,
                    ),
                    const SizedBox(height: Insets.medium),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
