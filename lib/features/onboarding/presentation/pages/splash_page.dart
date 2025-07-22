import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/services/biometric_auth_service.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final UserRepository _userRepository = getIt<UserRepository>();
  final BiometricAuthService _biometricAuthService =
      getIt<BiometricAuthService>();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final isBiometricAuthEnabled =
        await _userRepository.isBiometricAuthEnabled();
    logger.d(
        'SplashPage: hasSeenOnboarding=$hasSeenOnboarding, isBiometricAuthEnabled=$isBiometricAuthEnabled');

    if (hasSeenOnboarding) {
      if (isBiometricAuthEnabled) {
        final didAuthenticate = await _biometricAuthService.authenticate();
        logger.d('SplashPage: didAuthenticate=$didAuthenticate');
        if (didAuthenticate) {
          logger.d('SplashPage: Navigating to DashboardRoute');
          context.appRouter.replace(const DashboardRoute());
        } else {
          logger.d(
              'SplashPage: Authentication failed, navigating to OnboardingRoute');
          context.appRouter.replace(const OnboardingRoute());
        }
      } else {
        logger.d(
            'SplashPage: Biometric not enabled, navigating to DashboardRoute');
        context.appRouter.replace(const DashboardRoute());
      }
    } else {
      logger.d(
          'SplashPage: hasSeenOnboarding is false, navigating to OnboardingRoute');
      context.appRouter.replace(const OnboardingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
