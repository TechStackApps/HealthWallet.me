import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:health_wallet/features/onboarding/presentation/models/onboarding_screen_data.dart';
import 'package:health_wallet/features/onboarding/presentation/widgets/onboarding_navigation.dart';
import 'package:health_wallet/features/onboarding/presentation/widgets/onboarding_screen.dart';

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
          icon: Icons.favorite_border,
        ),
        OnboardingScreenData(
          title: context.l10n.onboardingRecordsTitle,
          subtitle: context.l10n.onboardingRecordsSubtitle,
          description: context.l10n.onboardingRecordsDescription,
          icon: Icons.folder_open_outlined,
          showScanButton: true,
        ),
        OnboardingScreenData(
          title: context.l10n.onboardingSyncTitle,
          subtitle: context.l10n.onboardingSyncSubtitle,
          description: context.l10n.onboardingSyncDescription,
          icon: Icons.shield_outlined,
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
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        // Close scanner if user swipes to a different page
                        if (state.isScannerActive && page != 1) {
                          context
                              .read<OnboardingBloc>()
                              .add(const OnboardingScanQR());
                        }
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingPageChanged(page));
                      },
                      children: _screens
                          .map((screenData) => OnboardingScreen(
                                title: screenData.title,
                                subtitle: screenData.subtitle,
                                description: screenData.description,
                                icon: screenData.icon,
                                showScanButton: screenData.showScanButton,
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
          );
        },
      ),
    );
  }
}
