import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/services/biometric_auth_service.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final BiometricAuthService _biometricAuthService =
      getIt<BiometricAuthService>();

  Future<void> _authenticate() async {
    logger.i('Starting authentication process...');
    final canAuth = await _biometricAuthService.canAuthenticate();
    logger.i('Can authenticate check returned: $canAuth');
    if (canAuth) {
      final didAuthenticate = await _biometricAuthService.authenticate();
      logger.i('Authentication result: $didAuthenticate');
      if (didAuthenticate) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenOnboarding', true);
        await prefs.setBool('isBiometricAuthEnabled', true);
        context
            .read<UserProfileBloc>()
            .add(const UserProfileBiometricAuthToggled(true));
        context.appRouter.replace(const DashboardRoute());
      }
    } else {
      logger.w('Biometrics not available, skipping authentication.');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);
      context.appRouter.replace(const DashboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, size: 100),
              const SizedBox(height: Insets.extraLarge),
              Text(
                context.l10n.onboardingAuthTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Insets.medium),
              Text(
                context.l10n.onboardingAuthDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: Insets.extraLarge),
              ElevatedButton(
                onPressed: _authenticate,
                child: Text(context.l10n.onboardingAuthEnable),
              ),
              TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasSeenOnboarding', true);
                  context.appRouter.replace(const DashboardRoute());
                },
                child: Text(context.l10n.onboardingAuthSkip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
