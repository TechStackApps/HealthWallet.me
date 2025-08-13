import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final SvgGenImage image;
  final bool showBiometricToggle;

  const OnboardingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    this.showBiometricToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state.syncCompleted) {
          return Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 100,
                  color: Colors.green,
                ),
                const SizedBox(height: Insets.large),
                Text(
                  'Sync Completed!',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: Insets.small),
                Text(
                  'Your health data has been successfully synced from the server.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        if (state.isSyncing) {
          return BlocListener<SyncBloc, SyncState>(
            listener: (context, syncState) {
              if (syncState.syncStatus == SyncStatus.connected) {
                context.read<OnboardingBloc>().add(
                      const OnboardingSyncCompleted(),
                    );
              } else if (syncState.syncStatus == SyncStatus.error &&
                  syncState.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sync failed: ${syncState.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
                context.read<OnboardingBloc>().add(
                      const OnboardingResetSync(),
                    );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: Insets.large),
                  Text(
                    'Syncing your health data...',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Insets.small),
                  Text(
                    'Please wait while we connect to your health server and sync your records.',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              image.svg(height: 250),
              const SizedBox(height: 40),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.titleLarge.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodySmall.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: Insets.normal),
              _buildRichDescription(context, description),
              if (showBiometricToggle) ...[
                const SizedBox(height: Insets.normal),
                Text(
                  context.l10n.onboardingBiometricText,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: Insets.normal),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    final isEnabled = userState.isBiometricAuthEnabled;
                    return TextButton(
                      onPressed: () {
                        context
                            .read<UserBloc>()
                            .add(UserBiometricAuthToggled(!isEnabled));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.primary,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        isEnabled
                            ? 'Disable Biometric Auth (FaceID / Passcode)'
                            : 'Enable Biometric Auth (FaceID / Passcode)',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildRichDescription(BuildContext context, String description) {
    if (description.contains('<link>') && description.contains('</link>')) {
      final parts = description.split('<link>');
      final linkParts = parts[1].split('</link>');
      final beforeLink = parts[0];
      final linkText = linkParts[0];
      final afterLink = linkParts[1];

      return BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyle.bodySmall.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
              letterSpacing: -0.2,
            ),
            children: [
              TextSpan(text: beforeLink),
              TextSpan(
                text: linkText,
                style: AppTextStyle.bodySmall.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                    height: 1.5,
                    letterSpacing: -0.2,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<OnboardingBloc>().add(
                          const OnboardingLaunchUrl(
                              'https://github.com/fastenhealth/fasten-onprem'),
                        );
                  },
              ),
              TextSpan(text: afterLink),
            ],
          ),
        ),
      );
    } else {
      return Text(
        description,
        textAlign: TextAlign.center,
        style: AppTextStyle.bodySmall.copyWith(
          color: context.colorScheme.onSurface.withOpacity(0.7),
          height: 1.5,
          letterSpacing: -0.2,
        ),
      );
    }
  }
}
