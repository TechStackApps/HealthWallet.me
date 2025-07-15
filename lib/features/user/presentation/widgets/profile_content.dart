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
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';

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
            // Initialize sync bloc when profile loads
            context.read<SyncBloc>().add(const SyncEvent.tokenStatusLoaded());

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
                          // Sync Status Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'Sync Status',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              // Status badge
                              BlocBuilder<SyncBloc, SyncState>(
                                builder: (context, syncState) {
                                  return _buildSyncStatusBadge(
                                      context, syncState);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: Insets.small),

                          // Sync Token Status
                          BlocBuilder<SyncBloc, SyncState>(
                            builder: (context, syncState) {
                              return _buildSyncTokenStatus(context, syncState);
                            },
                          ),

                          const SizedBox(height: Insets.normal),

                          // Sync Actions
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    context.appRouter.push(const SyncRoute());
                                  },
                                  icon: Assets.icons.renewSync.svg(
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      context.colorScheme.surface,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  label: Text(
                                    'Sync Now',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.background,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Insets.medium,
                                      vertical: Insets.small,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: Insets.small),
                              BlocBuilder<SyncBloc, SyncState>(
                                builder: (context, syncState) {
                                  if (syncState.currentToken != null) {
                                    return OutlinedButton(
                                      onPressed: () {
                                        _showRevokeTokenDialog(context);
                                      },
                                      child: Text(
                                        'Revoke Token',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                          color: AppColors.error,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side:
                                            BorderSide(color: AppColors.error),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Insets.small,
                                          vertical: Insets.small,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
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

  Widget _buildSyncStatusBadge(BuildContext context, SyncState syncState) {
    return syncState.tokenStatus.when(
      none: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.small,
          vertical: Insets.extraSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withAlpha(45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              'No Token',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      active: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.small,
          vertical: Insets.extraSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.success.withAlpha(45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_done,
              size: 14,
              color: AppColors.success,
            ),
            const SizedBox(width: 4),
            Text(
              'Active',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.success,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      expired: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.small,
          vertical: Insets.extraSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.error.withAlpha(45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off,
              size: 14,
              color: AppColors.error,
            ),
            const SizedBox(width: 4),
            Text(
              'Expired',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      expiringSoon: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.small,
          vertical: Insets.extraSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withAlpha(45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: 14,
              color: AppColors.warning,
            ),
            const SizedBox(width: 4),
            Text(
              'Expiring Soon',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.warning,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncTokenStatus(BuildContext context, SyncState syncState) {
    final token = syncState.currentToken;

    if (token == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No sync token configured',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Insets.extraSmall),
          Text(
            'Scan a QR code to connect to your health data server',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connected to: ${token.serverName}',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Insets.extraSmall),
        Text(
          'Server: ${token.address}:${token.port}',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: Insets.extraSmall),
        Row(
          children: [
            Icon(
              Icons.schedule,
              size: 14,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              _formatTokenExpiry(token),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (token.isExpired || token.isExpiringSoon) ...[
          const SizedBox(height: Insets.small),
          Container(
            padding: const EdgeInsets.all(Insets.small),
            decoration: BoxDecoration(
              color: (token.isExpired ? AppColors.error : AppColors.warning)
                  .withAlpha(45),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  token.isExpired ? Icons.error : Icons.warning,
                  size: 16,
                  color: token.isExpired ? AppColors.error : AppColors.warning,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    token.isExpired
                        ? 'Token has expired. Please scan a new QR code to continue syncing.'
                        : 'Token expires soon. Consider scanning a new QR code.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color:
                          token.isExpired ? AppColors.error : AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _formatTokenExpiry(SyncToken token) {
    final now = DateTime.now();
    final expiry = token.expiresAt;

    if (expiry.isBefore(now)) {
      final timeSinceExpiry = now.difference(expiry);
      if (timeSinceExpiry.inDays > 0) {
        return 'Expired ${timeSinceExpiry.inDays} day${timeSinceExpiry.inDays != 1 ? 's' : ''} ago';
      } else if (timeSinceExpiry.inHours > 0) {
        return 'Expired ${timeSinceExpiry.inHours} hour${timeSinceExpiry.inHours != 1 ? 's' : ''} ago';
      } else {
        return 'Expired ${timeSinceExpiry.inMinutes} minute${timeSinceExpiry.inMinutes != 1 ? 's' : ''} ago';
      }
    } else {
      final timeUntilExpiry = expiry.difference(now);
      if (timeUntilExpiry.inDays > 0) {
        return 'Expires in ${timeUntilExpiry.inDays} day${timeUntilExpiry.inDays != 1 ? 's' : ''}';
      } else if (timeUntilExpiry.inHours > 0) {
        return 'Expires in ${timeUntilExpiry.inHours} hour${timeUntilExpiry.inHours != 1 ? 's' : ''}';
      } else {
        return 'Expires in ${timeUntilExpiry.inMinutes} minute${timeUntilExpiry.inMinutes != 1 ? 's' : ''}';
      }
    }
  }

  void _showRevokeTokenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Sync Token'),
        content: const Text(
          'Are you sure you want to revoke the current sync token? '
          'You will need to scan a new QR code to sync again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SyncBloc>().add(const SyncEvent.tokenRevoked());
              Navigator.of(context).pop();
            },
            child: Text(
              'Revoke',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
