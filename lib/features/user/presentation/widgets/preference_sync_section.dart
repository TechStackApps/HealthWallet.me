import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class PreferenceSyncSection extends StatelessWidget {
  const PreferenceSyncSection({super.key});

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;

    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, syncState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Synchronization',
                style: AppTextStyle.bodySmall,
              ),
              const SizedBox(height: Insets.small),
              Container(
                padding: const EdgeInsets.all(Insets.smallNormal),
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Insets.small,
                            vertical: Insets.extraSmall,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icons.timeClock.svg(
                                width: 14,
                                height: 14,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: Insets.extraSmall),
                              Text(
                                'Last synced: 2 hours ago',
                                style: AppTextStyle.labelSmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Insets.normal),
                    Assets.onboarding.onboarding2.svg(
                      width: 140,
                      height: 140,
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      'Sync your latest medical records from your healthcare provider using a secure JWT token. *',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.labelLarge,
                    ),
                    const SizedBox(height: Insets.normal),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.appRouter.push(const SyncRoute());
                        },
                        icon: Assets.icons.renewSync.svg(
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(
                          'Sync Medical records',
                          style: AppTextStyle.buttonSmall,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Insets.small,
                            vertical: Insets.small,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
