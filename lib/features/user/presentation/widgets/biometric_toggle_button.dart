import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';

class BiometricToggleButton extends StatelessWidget {
  const BiometricToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final isBiometricEnabled = state.isBiometricAuthEnabled;

        return GestureDetector(
          onTap: () {
            context.read<UserProfileBloc>().add(
                  UserProfileEvent.biometricAuthToggled(!isBiometricEnabled),
                );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 76,
            height: 40,
            padding: const EdgeInsets.all(Insets.extraSmall),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: !isBiometricEnabled
                          ? colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'OFF',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: !isBiometricEnabled
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isBiometricEnabled
                          ? colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'ON',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: isBiometricEnabled
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
