import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_filter_bloc.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/edit_records_dialog.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return HomeView(pageController: pageController);
  }
}

class HomeView extends StatefulWidget {
  final PageController pageController;
  const HomeView({super.key, required this.pageController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _showEditRecordsDialog(HomeState state) {
    showDialog(
      context: context,
      builder: (context) {
        return EditRecordsDialog(
          selectedResources: state.selectedResources,
          onSelectionChanged: (newSelection) {
            context
                .read<HomeBloc>()
                .add(HomeEvent.filtersChanged(newSelection));
          },
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    // Trigger data refresh
    context.read<HomeBloc>().add(const HomeEvent.initialised());

    // Also check for sync token updates
    context.read<SyncBloc>().add(const SyncEvent.checkTokenStatus());

    // Small delay to allow the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final editMode = state.editMode ?? false;
        return state.status.when(
          initial: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          failure: (error) => Scaffold(
            body: Center(
              child: Text(
                'Error: $error',
                style: TextStyle(color: context.colorScheme.error),
              ),
            ),
          ),
          success: () => Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(text: context.l10n.homeHi),
                        TextSpan(
                          text: state.patient != null
                              ? ((state.patient!.resourceJson['name'] as List?)
                                      ?.first['given']
                                      ?.first as String?) ??
                                  ''
                              : 'SourceName',
                          style: TextStyle(color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  editMode
                      ? TextButton(
                          onPressed: () => context
                              .read<HomeBloc>()
                              .add(const HomeEvent.editModeChanged(false)),
                          child: const Text('Done'),
                        )
                      : Row(
                          children: [
                            IconButton(
                              icon: Assets.icons.settings.svg(),
                              onPressed: () {
                                PreferenceModal.show(context);
                              },
                            ),
                          ],
                        ),
                ],
              ),
              backgroundColor: context.colorScheme.surface,
              elevation: 0,
              actions: const [],
            ),
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: _buildDashboardContent(
                context,
                context.textTheme,
                context.colorScheme,
                state,
                editMode,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    HomeState state,
    bool editMode,
  ) {
    final filteredCards = state.overviewCards
        .where((card) => state.selectedResources[card.title] ?? false)
        .toList();
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Sync Status Section
              BlocBuilder<SyncBloc, SyncState>(
                builder: (context, syncState) {
                  return _buildSyncStatusSection(context, syncState);
                },
              ),
              const SizedBox(height: Insets.medium),

              // Vital Signs Section
              Text(
                context.l10n.homeVitalSigns,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: Insets.smallNormal),
              VitalsSection(
                vitals: state.vitalSigns,
                editMode: editMode,
                onReorder: (oldIndex, newIndex) {
                  context
                      .read<HomeBloc>()
                      .add(HomeEvent.vitalsReordered(oldIndex, newIndex));
                },
                onLongPressCard: () => context
                    .read<HomeBloc>()
                    .add(const HomeEvent.editModeChanged(true)),
              ),

              // Medical Records Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Medical Records',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (!editMode)
                    InkWell(
                      onTap: () => _showEditRecordsDialog(state),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.small,
                          vertical: Insets.extraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withAlpha(45),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Edit Records',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Insets.smallNormal),

              // Source filter dropdown
              if (state.sources.isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(bottom: Insets.small),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.homeSource,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Flexible(
                        child: DropdownButton<String>(
                          value: state.selectedSource,
                          isExpanded: false,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEvent.sourceChanged(newValue));
                            }
                          },
                          items: state.sources
                              .where((source) => source.id != 'All')
                              .map((source) {
                            return DropdownMenuItem<String>(
                              value: source.id,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 150),
                                child: Text(
                                  source.name?.isNotEmpty == true
                                      ? source.name!
                                      : source.id,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }).toList()
                            ..insert(
                                0,
                                DropdownMenuItem<String>(
                                  value: 'All',
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    child: Text(
                                      context.l10n.homeAll,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: Insets.smallNormal),
              MedicalRecordsSection(
                overviewCards: filteredCards,
                editMode: editMode,
                onLongPressCard: () => context
                    .read<HomeBloc>()
                    .add(const HomeEvent.editModeChanged(true)),
                onReorder: (oldIndex, newIndex) {
                  context
                      .read<HomeBloc>()
                      .add(HomeEvent.recordsReordered(oldIndex, newIndex));
                },
                onTapCard: (card) {
                  final resourceType =
                      ClinicalDataTags.resourceTypeMap[card.title];
                  if (resourceType != null) {
                    context
                        .read<RecordsFilterBloc>()
                        .add(RecordsFilterEvent.toggleFilter(resourceType));
                  }
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
              const SizedBox(height: Insets.medium),
              RecentRecordsSection(
                recentRecords: state.recentRecords,
                onViewAll: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
              const SizedBox(height: 116),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncStatusSection(BuildContext context, SyncState syncState) {
    final lastSync =
        syncState.history.isNotEmpty ? syncState.history.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.l10n.homeLastSynced}${lastSync != null ? DateFormat.yMd().add_jm().format(lastSync) : context.l10n.homeNever}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                if (syncState.currentToken != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Connected to ${syncState.currentToken!.serverName}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
            // Sync status indicator
            _buildSyncStatusIndicator(context, syncState),
          ],
        ),

        // Show warning if token is expired or expiring soon
        if (syncState.currentToken != null &&
            (syncState.currentToken!.isExpired ||
                syncState.currentToken!.isExpiringSoon)) ...[
          const SizedBox(height: Insets.small),
          Container(
            padding: const EdgeInsets.all(Insets.small),
            decoration: BoxDecoration(
              color: (syncState.currentToken!.isExpired
                      ? AppColors.error
                      : AppColors.warning)
                  .withAlpha(45),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  syncState.currentToken!.isExpired
                      ? Icons.error
                      : Icons.warning,
                  size: 16,
                  color: syncState.currentToken!.isExpired
                      ? AppColors.error
                      : AppColors.warning,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    syncState.currentToken!.isExpired
                        ? 'Sync token expired. Go to Profile to set up sync again.'
                        : 'Sync token expires soon. Consider refreshing it in Profile.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: syncState.currentToken!.isExpired
                          ? AppColors.error
                          : AppColors.warning,
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

  Widget _buildSyncStatusIndicator(BuildContext context, SyncState syncState) {
    return syncState.tokenStatus.when(
      none: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sync_disabled,
              size: 12,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              'Not Synced',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      active: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.success.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sync,
              size: 12,
              color: AppColors.success,
            ),
            const SizedBox(width: 4),
            Text(
              'Synced',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.success,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      expired: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.error.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sync_problem,
              size: 12,
              color: AppColors.error,
            ),
            const SizedBox(width: 4),
            Text(
              'Expired',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      expiringSoon: () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sync_problem,
              size: 12,
              color: AppColors.warning,
            ),
            const SizedBox(width: 4),
            Text(
              'Expiring',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.warning,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
