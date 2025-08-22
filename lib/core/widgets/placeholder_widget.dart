import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class PlaceholderWidget extends StatelessWidget {
  final bool hasRealData;
  final ColorScheme colorScheme;
  final VoidCallback? onSyncPressed;

  const PlaceholderWidget({
    super.key,
    required this.hasRealData,
    required this.colorScheme,
    this.onSyncPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, recordsState) {
        // Show placeholder only when there's no real data and no demo data loaded
        if (!hasRealData && !recordsState.hasDemoData) {
          return Column(
            children: [
              const SizedBox(height: Insets.medium),
              Container(
                padding: const EdgeInsets.all(Insets.large),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.science_outlined,
                      size: 48,
                      color: colorScheme.primary.withOpacity(0.6),
                    ),
                    const SizedBox(height: Insets.medium),
                    Text(
                      'No medical records yet',
                      style: AppTextStyle.titleMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      'Load demo data to explore the app or sync your real medical records',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: Insets.large),
                    Column(
                      children: [
                        // Sync Button (First)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: onSyncPressed ??
                                () {
                                  context.router.push(const SyncRoute());
                                },
                            icon: const Icon(Icons.sync),
                            label: const Text('Sync Records'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: context.isDarkMode
                                  ? Colors.white
                                  : colorScheme.onPrimary,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Insets.medium),
                        // Demo Data Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: recordsState.isLoadingDemoData
                                ? null
                                : () {
                                    context.read<RecordsBloc>().add(
                                          const LoadDemoData(),
                                        );
                                  },
                            icon: recordsState.isLoadingDemoData
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.science),
                            label: Text(
                              recordsState.isLoadingDemoData
                                  ? 'Loading Demo Data...'
                                  : 'Load Demo Data',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondary,
                              foregroundColor: context.isDarkMode
                                  ? Colors.white
                                  : colorScheme.onSecondary,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        if (recordsState.hasDemoData) ...[
                          const SizedBox(height: Insets.medium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Demo data loaded',
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Insets.small),
                          TextButton(
                            onPressed: () {
                              context.read<RecordsBloc>().add(
                                    const ClearDemoData(),
                                  );
                            },
                            child: Text(
                              'Clear Demo Data',
                              style: TextStyle(
                                color: colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
