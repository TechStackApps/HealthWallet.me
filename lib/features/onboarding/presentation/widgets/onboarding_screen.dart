import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/widgets/qr_scanner_widget.dart';
import 'package:health_wallet/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/biometric_toggle_button.dart';
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
        // If scanner is active, show only the QR scanner
        if (state.isScannerActive) {
          return BlocListener<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              // Handle sync process when QR code is detected
              if (state.scannedQRCode != null && state.isSyncing) {
                // Trigger sync with the scanned QR code data
                context.read<SyncBloc>().add(
                      SyncEvent.syncDataWithJson(state.scannedQRCode!),
                    );

                // Reset the syncing state after triggering sync
                context.read<OnboardingBloc>().add(
                      const OnboardingQRCodeDetected(''),
                    );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: QRScannerWidget(
                onQRCodeDetected: (qrCode) {
                  context.read<OnboardingBloc>().add(
                        OnboardingQRCodeDetected(qrCode),
                      );
                },
                onCancel: () {
                  context.read<OnboardingBloc>().add(
                        const OnboardingScanQR(),
                      );
                },
                title: 'Scan QR Code',
                cancelButtonText: 'Cancel',
              ),
            ),
          );
        }

        // Show success state if sync completed
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

        // Show syncing state if QR code was scanned and syncing is in progress
        if (state.isSyncing && state.scannedQRCode != null) {
          return BlocListener<SyncBloc, SyncState>(
            listener: (context, syncState) {
              // Handle sync completion
              syncState.status.whenOrNull(
                success: () {
                  // Mark sync as completed to show success state
                  context.read<OnboardingBloc>().add(
                        const OnboardingSyncCompleted(),
                      );
                },
                failure: (error) {
                  // Show error message and reset syncing state
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sync failed: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  // Reset syncing state without triggering another sync
                  context.read<OnboardingBloc>().add(
                        const OnboardingResetSync(),
                      );
                },
              );
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

        // Otherwise, show the normal onboarding content
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              image.svg(height: 250),
              const SizedBox(height: 40),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.7),
                  height: 1.5,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 16),
              _buildRichDescription(context, description),
              if (showBiometricToggle) ...[
                const SizedBox(height: 16),
                Text(
                  context.l10n.onboardingBiometricText,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                const BiometricToggleButton(),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildRichDescription(BuildContext context, String description) {
    // Check if the description contains a link
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
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              height: 1.5,
              letterSpacing: -0.2,
            ),
            children: [
              TextSpan(text: beforeLink),
              TextSpan(
                text: linkText,
                style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
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
      // Fallback to regular text if no link is found
      return Text(
        description,
        textAlign: TextAlign.center,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.textPrimary.withValues(alpha: 0.7),
          height: 1.5,
          letterSpacing: -0.2,
        ),
      );
    }
  }
}
