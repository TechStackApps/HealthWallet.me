import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/theme_toggle_button.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/biometric_toggle_button.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/biometrics_setup_dialog.dart';
import 'dart:ui';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // Theme toggle functionality
                  context.read<UserBloc>().add(const UserThemeToggled());
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.small),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Theme',
                        style: AppTextStyle.bodySmall,
                      ),
                      const ThemeToggleButton(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Insets.medium),
              InkWell(
                onTap: () {
                  // Biometric toggle functionality
                  if (state.isBiometricAuthEnabled) {
                    // Show confirmation dialog when disabling
                    _showDisableBiometricDialog(context);
                  } else {
                    // Enable biometric directly
                    context
                        .read<UserBloc>()
                        .add(UserBiometricAuthToggled(true));
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.small),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.biometricAuthentication,
                        style: AppTextStyle.bodySmall,
                      ),
                      const BiometricToggleButton(),
                    ],
                  ),
                ),
              ),
              // Show biometrics setup dialog when needed
              BlocListener<UserBloc, UserState>(
                listenWhen: (previous, current) {
                  return current.shouldShowBiometricsSetup &&
                      !current.isBiometricAuthEnabled;
                },
                listener: (context, state) {
                  context
                      .read<UserBloc>()
                      .add(const UserBiometricsSetupShown());
                  showDialog(
                    context: context,
                    builder: (context) => const BiometricsSetupDialog(),
                  );
                },
                child: const SizedBox.shrink(),
              ),
              const SizedBox(height: Insets.medium),
              InkWell(
                onTap: () {
                  context.appRouter.push(const PrivacyPolicyRoute());
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.small),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.privacyPolicy,
                        style: AppTextStyle.bodySmall,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDisableBiometricDialog(BuildContext context) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final borderColor =
        context.isDarkMode ? AppColors.borderDark : AppColors.border;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(Insets.normal),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Insets.normal),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Are you sure you would like to disable the Biometric Auth (FaceID / Passcode)?',
                      style: AppTextStyle.labelLarge.copyWith(color: textColor),
                    ),
                    const SizedBox(height: Insets.normal),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide.none,
                              padding: const EdgeInsets.all(8),
                              fixedSize: const Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: AppTextStyle.buttonSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context
                                  .read<UserBloc>()
                                  .add(UserBiometricAuthToggled(false));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(8),
                              fixedSize: const Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Disable',
                              style: AppTextStyle.buttonSmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
