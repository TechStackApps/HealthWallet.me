import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/biometrics_setup_dialog.dart';
import 'dart:ui';
import 'package:health_wallet/gen/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final SvgGenImage image;
  final bool showBiometricToggle;
  final Widget? customWidget;

  const OnboardingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    this.showBiometricToggle = false,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) {
        return previous.isBiometricAuthEnabled !=
                current.isBiometricAuthEnabled ||
            previous.status != current.status;
      },
      builder: (context, userState) {
        return BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, onboardingState) {
            return MultiBlocListener(
              listeners: [
                BlocListener<UserBloc, UserState>(
                  listenWhen: (previous, current) {
                    return current.shouldShowBiometricsSetup &&
                        !current.isBiometricAuthEnabled;
                  },
                  listener: (context, userState) {
                    context
                        .read<UserBloc>()
                        .add(const UserBiometricsSetupShown());
                    showDialog(
                      context: context,
                      builder: (context) => const BiometricsSetupDialog(),
                    );
                  },
                ),
              ],
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    image.svg(height: 250),
                    if (!showBiometricToggle)
                      const SizedBox(height: Insets.large),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.titleLarge.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Insets.large),
                    _buildRichSubtitle(context, subtitle),
                    const SizedBox(height: Insets.large),
                    _buildRichDescription(context, description),
                    if (showBiometricToggle) ...[
                      const SizedBox(height: Insets.large),
                      Text(
                        context.l10n.onboardingBiometricText,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    if (customWidget != null) ...[
                      const SizedBox(height: Insets.large),
                      customWidget!,
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRichSubtitle(BuildContext context, String subtitle) {
    // Handle hyperlinks first
    if (subtitle.contains('<link>') && subtitle.contains('</link>')) {
      final parts = subtitle.split('<link>');
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
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    final url = linkText == 'HealthWallet.me'
                        ? 'https://healthwallet.me'
                        : 'https://github.com/fastenhealth/fasten-onprem';
                    context.read<OnboardingBloc>().add(
                          OnboardingLaunchUrl(url),
                        );
                  },
              ),
              TextSpan(text: afterLink),
            ],
          ),
        ),
      );
    }
    // Handle bold text
    else if (subtitle.contains('**') && subtitle.split('**').length >= 3) {
      final parts = subtitle.split('**');
      final beforeBold = parts[0];
      final boldText = parts[1];
      final afterBold = parts.length > 2 ? parts[2] : '';

      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyle.bodySmall.copyWith(
            color: context.colorScheme.onSurface.withOpacity(0.7),
            height: 1.5,
            letterSpacing: -0.2,
          ),
          children: [
            TextSpan(text: beforeBold),
            TextSpan(
              text: boldText,
              style: AppTextStyle.bodySmall.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
                letterSpacing: -0.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: afterBold),
          ],
        ),
      );
    } else {
      return Text(
        subtitle,
        textAlign: TextAlign.center,
        style: AppTextStyle.bodySmall.copyWith(
          color: context.colorScheme.onSurface.withOpacity(0.7),
          height: 1.5,
          letterSpacing: -0.2,
        ),
      );
    }
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
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    final url = linkText == 'HealthWallet.me'
                        ? 'https://healthwallet.me'
                        : 'https://github.com/fastenhealth/fasten-onprem';
                    context.read<OnboardingBloc>().add(
                          OnboardingLaunchUrl(url),
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
