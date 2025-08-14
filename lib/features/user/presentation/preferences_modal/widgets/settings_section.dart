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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme',
                    style: AppTextStyle.bodySmall,
                  ),
                  ThemeToggleButton(),
                ],
              ),
              const SizedBox(height: Insets.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.biometricAuthentication,
                    style: AppTextStyle.bodySmall,
                  ),
                  const BiometricToggleButton(),
                ],
              ),
              const SizedBox(height: Insets.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.privacyPolicy,
                    style: AppTextStyle.bodySmall,
                  ),
                  IconButton(
                    onPressed: () {
                      context.appRouter.push(const PrivacyPolicyRoute());
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
