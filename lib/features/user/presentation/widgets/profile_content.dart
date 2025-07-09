import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/user/presentation/widgets/theme_toggle_button.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.border,
                        child: Assets.icons.user.svg(
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            context.colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: Insets.small),
                      Text(
                        '${context.l10n.patientId}#HV-2024-001*',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Assets.icons.edit.svg(
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: Insets.normal),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      Assets.icons.calendar.svg(
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      'N/A',
                      context.l10n.age,
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      Assets.icons.genderMale.svg(
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      'N/A',
                      context.l10n.sex,
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      Assets.icons.drop.svg(
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      'O+',
                      context.l10n.bloodType,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.medium),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(Insets.normal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.small,
                          vertical: Insets.extraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(45),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          context.l10n.lastSyncedProfile,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: Insets.small),
                      Text(
                        context.l10n.syncLatestRecords,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: Insets.normal),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.appRouter.push(const SyncRoute());
                          },
                          icon: Assets.icons.renewSync.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.surface,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: Text(
                            context.l10n.scanToSync,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.medium,
                              vertical: Insets.smallNormal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Insets.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.theme),
                  const ThemeToggleButton(),
                ],
              ),
              const SizedBox(height: Insets.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.biometricAuthentication),
                  Switch(
                    value: state.isBiometricAuthEnabled,
                    onChanged: (value) {
                      context.read<UserProfileBloc>().add(
                            UserProfileEvent.biometricAuthToggled(value),
                          );
                    },
                  ),
                ],
              ),
              const SizedBox(height: Insets.medium),
              ListTile(
                title: Text(context.l10n.privacyPolicy),
                onTap: () {
                  context.appRouter.push(const PrivacyPolicyRoute());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    Widget icon,
    String value,
    String label,
  ) {
    final TextTheme textTheme = context.textTheme;
    return Card(
      color: context.colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.smallNormal, horizontal: Insets.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: Insets.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      value,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
