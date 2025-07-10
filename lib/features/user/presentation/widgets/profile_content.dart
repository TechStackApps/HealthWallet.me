import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/theme_toggle_button.dart';
import 'package:health_wallet/gen/assets.gen.dart';

part 'user_section.dart';
part 'patient_section.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        final patient = homeState.patient;
        final name = patient?.resourceJson['name'] as List?;
        final firstName = name?.first['given']?.first ?? 'N/A';
        final lastName = name?.first['family'] ?? 'N/A';
        final gender = patient?.resourceJson['gender'] ?? 'N/A';
        final birthDate = patient?.resourceJson['birthDate'] != null
            ? DateTime.parse(patient!.resourceJson['birthDate'])
            : null;
        final age = birthDate != null
            ? (DateTime.now().difference(birthDate).inDays / 365).floor()
            : 'N/A';

        return BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Insets.normal),
                    child: UserSection(
                      firstName: 'John',
                      lastName: 'Doe',
                      onEdit: () {
                        // TODO: Edit user profile
                      },
                    ),
                  ),

                  /// 🩺 Patient Section
                  Card(
                    margin: const EdgeInsets.only(bottom: Insets.medium),
                    child: Padding(
                      padding: const EdgeInsets.all(Insets.normal),
                      child: PatientSection(
                        firstName: firstName,
                        lastName: lastName,
                        age: age.toString(),
                        gender: gender.toString(),
                      ),
                    ),
                  ),

                  /// 🔄 Sync Section
                  Card(
                    margin: const EdgeInsets.only(bottom: Insets.medium),
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

                  /// 📄 Privacy Policy
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
      },
    );
  }
}
