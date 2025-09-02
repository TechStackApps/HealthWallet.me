import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';

class BiometricDisableDialog extends StatelessWidget {
  final bool isOnboarding;

  const BiometricDisableDialog({
    super.key,
    this.isOnboarding = false,
  });

  static void show(BuildContext context, {bool isOnboarding = false}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BiometricDisableDialog(isOnboarding: isOnboarding);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final borderColor =
        context.isDarkMode ? AppColors.borderDark : AppColors.border;

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
                  isOnboarding
                      ? context.l10n.confirmDisableBiometricOnboarding
                      : context.l10n.confirmDisableBiometric,
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
                          context.l10n.cancel,
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
                          context.l10n.disable,
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
  }
}
