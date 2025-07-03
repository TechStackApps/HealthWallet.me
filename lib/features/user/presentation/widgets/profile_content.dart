import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/sync_medical_records_dialog.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final user = state.user;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Information',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primaryBlue.withAlpha(
                              51,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name ?? 'N/A',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                'Patient ID: #HV-2024-001*',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              Icons.calendar_today,
                              'N/A',
                              'Age',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              Icons.male,
                              'N/A',
                              'Sex',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              Icons.bloodtype,
                              'O+*',
                              'Blood Type*',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Data Sync Section
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data Sync',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Last sync: 2 hours ago*',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sync your latest medical records from your healthcare provider using a secure JWT token.*',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const SyncMedicalRecordsDialog();
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.sync,
                            color: AppColors.backgroundWhite,
                          ),
                          label: Text(
                            'Sync Medical Records*',
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.backgroundWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
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
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: user.isDarkMode,
                onChanged: (value) {
                  context.read<UserProfileBloc>().add(
                    const UserProfileThemeToggled(),
                  );
                },
                secondary: Icon(
                  user.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: user.isDarkMode ? Colors.amber : Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.primaryBlue),
            const SizedBox(height: 4),
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context,
    String count,
    String label, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: textColor.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSettingsTile(BuildContext context, String title, IconData icon,
  //     {bool hasToggle = false, bool isDestructive = false}) {
  //   final TextTheme textTheme = Theme.of(context).textTheme;
  //   final Color textColor = isDestructive ? Colors.red : AppColors.textPrimary;
  //   final Color iconColor =
  //       isDestructive ? Colors.red : AppColors.textSecondary;

  //   return InkWell(
  //     onTap: () {
  //       // Handle tap
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  //       child: Row(
  //         children: [
  //           Icon(icon, color: iconColor, size: 24),
  //           const SizedBox(width: 16),
  //           Expanded(
  //             child: Text(
  //               title,
  //               style: textTheme.titleMedium?.copyWith(
  //                 color: textColor,
  //               ),
  //             ),
  //           ),
  //           if (hasToggle)
  //             Consumer<ThemeProvider>(
  //               builder: (context, themeProvider, child) {
  //                 return Switch(
  //                   value: themeProvider.themeMode == ThemeMode.dark,
  //                   onChanged: (bool value) {
  //                     themeProvider.toggleTheme(value);
  //                   },
  //                   activeColor: AppColors.primaryBlue,
  //                 );
  //               },
  //             )
  //           else if (!isDestructive)
  //             Icon(Icons.arrow_forward_ios,
  //                 color: AppColors.textMuted, size: 16),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
