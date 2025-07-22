import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
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
            context.read<HomeBloc>().add(HomeFiltersChanged(newSelection));
          },
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    // Trigger data refresh
    context.read<HomeBloc>().add(const HomeInitialised());

    // Check for sync token updates
    context.read<SyncBloc>().add(const SyncEvent.checkTokenStatus());

    // Check connection validity
    context.read<SyncBloc>().add(const SyncEvent.checkConnectionValidity());

    // Small delay to allow the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final editMode = state.editMode ?? false;
        // Only show spinner for the very first load
        if (state.status.runtimeType == HomeStatus.initial().runtimeType) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        // Always show the dashboard, even if loading or failure
        return Scaffold(
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
                            .add(const HomeEditModeChanged(false)),
                        child: const Text('Done'),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Trigger connection validity check
                              context.read<SyncBloc>().add(
                                  const SyncEvent.checkConnectionValidity());
                              // Also refresh home data
                              context
                                  .read<HomeBloc>()
                                  .add(const HomeInitialised());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.icons.renewSync.svg(
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  context.colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              PreferenceModal.show(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.icons.settings.svg(),
                            ),
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
            child: Stack(
              children: [
                _buildDashboardContent(
                  context,
                  context.textTheme,
                  context.colorScheme,
                  state,
                  editMode,
                ),
                if (state.status.runtimeType ==
                    HomeStatus.failure(Exception()).runtimeType)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: MaterialBanner(
                      content: Text('Error loading data.'),
                      actions: [
                        TextButton(
                          onPressed: () => context
                              .read<HomeBloc>()
                              .add(const HomeInitialised()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
              ],
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
                      .add(HomeVitalsReordered(oldIndex, newIndex));
                },
                onLongPressCard: () => context
                    .read<HomeBloc>()
                    .add(const HomeEditModeChanged(true)),
              ),

              // Medical Records Section with Source Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Medical Records',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (editMode)
                    // Show "Edit Records" when in edit mode
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
                    )
                  else if (state.sources.isNotEmpty)
                    // Show source dropdown when not in edit mode
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.homeSource,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: Insets.small),
                        Flexible(
                          child: DropdownButton<String>(
                            value: state.selectedSource,
                            isExpanded: false,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<HomeBloc>()
                                    .add(HomeSourceChanged(newValue));
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
                ],
              ),
              const SizedBox(height: Insets.smallNormal),
              MedicalRecordsSection(
                overviewCards: filteredCards,
                editMode: editMode,
                onLongPressCard: () => context
                    .read<HomeBloc>()
                    .add(const HomeEditModeChanged(true)),
                onReorder: (oldIndex, newIndex) {
                  context
                      .read<HomeBloc>()
                      .add(HomeRecordsReordered(oldIndex, newIndex));
                },
                onTapCard: (card) {
                  final resourceType =
                      ClinicalDataTags.resourceTypeMap[card.title];
                  if (resourceType != null) {
                    context
                        .read<RecordsBloc>()
                        .add(RecordsFilterToggled(resourceType));
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
    // Check connection validity first
    if (syncState.connectionValid == null) {
      // Still checking connection
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.amber.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Checking...',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.amber,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    if (syncState.connectionValid == true) {
      // Connection is valid - green
      return Container(
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
              Icons.check_circle,
              size: 12,
              color: AppColors.success,
            ),
            const SizedBox(width: 4),
            Text(
              'Connected',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.success,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    // Connection is not valid
    // If token expired, show token expired warning
    if (syncState.tokenStatus.maybeWhen(
      expired: () => true,
      orElse: () => false,
    )) {
      // Token expired - amber
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.extraSmall,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.amber.withAlpha(45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: 12,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              'Token Expired',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.amber,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    // Server down or other connection issues - red
    return Container(
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
            Icons.cloud_off,
            size: 12,
            color: AppColors.error,
          ),
          const SizedBox(width: 4),
          Text(
            'No connection to server',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.error,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
