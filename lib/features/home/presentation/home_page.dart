import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
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
            body: _buildDashboardContent(
              context,
              context.textTheme,
              context.colorScheme,
              state,
              editMode,
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
              // Vital Signs Section
              BlocBuilder<SyncBloc, SyncState>(
                builder: (context, syncState) {
                  final lastSync = syncState.history.isNotEmpty
                      ? syncState.history.first
                      : null;
                  return syncState.status.maybeWhen(
                    success: () => Text(
                      '${context.l10n.homeLastSynced}${lastSync != null ? DateFormat.yMd().add_jm().format(lastSync) : context.l10n.homeNever}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              const SizedBox(height: Insets.medium),
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
                  editMode
                      ? IconButton(
                          icon: Assets.icons.edit.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () => _showEditRecordsDialog(state),
                        )
                      : Row(
                          children: [
                            Text(
                              context.l10n.homeSource,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(width: Insets.extraSmall),
                            DropdownButton<String>(
                              value: state.selectedSource,
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
                                  child: Text(source.name?.isNotEmpty == true
                                      ? source.name!
                                      : source.id),
                                );
                              }).toList()
                                ..insert(
                                    0,
                                    DropdownMenuItem<String>(
                                      value: 'All',
                                      child: Text(context.l10n.homeAll),
                                    )),
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
                    .add(const HomeEvent.editModeChanged(true)),
                onReorder: (oldIndex, newIndex) {
                  context
                      .read<HomeBloc>()
                      .add(HomeEvent.recordsReordered(oldIndex, newIndex));
                },
                onTapCard: (card) {
                  final homeState = context.read<HomeBloc>().state;
                  final selectedSource = homeState.selectedSource;
                  context.read<RecordsBloc>().add(
                        RecordsEvent.loadRecords(
                          sourceId:
                              selectedSource == 'All' ? null : selectedSource,
                          filter: ClinicalDataTags.resourceTypeMap[card.title],
                        ),
                      );
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
                onTapRecord: (record) {
                  context.router.push(RecordDetailRoute(resource: record));
                },
              ),
              const SizedBox(height: 116),
            ]),
          ),
        ),
      ],
    );
  }
}
