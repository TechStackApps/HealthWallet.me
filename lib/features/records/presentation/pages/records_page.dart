import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';

import 'package:health_wallet/features/records/presentation/bloc/timeline_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_filter_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/encounter_detail_bloc.dart';
import 'package:health_wallet/features/records/presentation/models/timeline_resource_model.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:health_wallet/core/di/injection.dart';

import 'package:health_wallet/features/records/presentation/widgets/records_filter_dialog.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/fhir_resource_utils.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/unified_resource_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/encounter_card.dart';
import 'package:health_wallet/features/records/presentation/pages/resource_detail_page.dart';

import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

@RoutePage()
class RecordsPage extends StatelessWidget {
  final String? filter;

  const RecordsPage({super.key, this.filter});

  @override
  Widget build(BuildContext context) {
    final recordsFilterBloc = context.read<RecordsFilterBloc>();
    final homeState = context.read<HomeBloc>().state;
    final sourceId =
        homeState.selectedSource == 'All' ? null : homeState.selectedSource;

    // Provide TimelineBloc at the page level, as it depends on current filters and source
    return BlocProvider(
      create: (context) => TimelineBloc(
        getIt<RecordsRepository>(),
        initialFilters: recordsFilterBloc.state.activeFilters,
        sourceId: sourceId,
      )..add(const TimelineEvent.load()),
      child: RecordsView(filter: filter),
    );
  }
}

class RecordsView extends StatefulWidget {
  final String? filter;

  const RecordsView({super.key, this.filter});

  @override
  State<RecordsView> createState() => _RecordsViewState();
}

class _RecordsViewState extends State<RecordsView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounceTimer;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();

    // Set up scroll listener for pagination and scroll to top button
    _scrollController.addListener(_onScroll);

    if (widget.filter != null) {
      context
          .read<RecordsFilterBloc>()
          .add(RecordsFilterEvent.toggleFilter(widget.filter!));
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    // Show/hide scroll to top button based on scroll position
    final shouldShowButton = currentScroll > 200; // Show after scrolling 200px
    if (shouldShowButton != _showScrollToTopButton) {
      setState(() {
        _showScrollToTopButton = shouldShowButton;
      });
    }

    // Simple pagination trigger - when within 200px of bottom
    if (maxScroll > 0 && currentScroll >= maxScroll - 200) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    // Simple debounce to prevent multiple requests
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        final state = context.read<TimelineBloc>().state;
        if (state.status != TimelineStatus.loading && state.hasMorePages) {
          context.read<TimelineBloc>().add(const TimelineEvent.loadMore());
        }
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Custom floating action button location that positions the button 50px higher
  FloatingActionButtonLocation get _customFabLocation {
    return _CustomFabLocation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecordsFilterBloc, RecordsFilterState>(
          listener: (context, state) {
            context
                .read<TimelineBloc>()
                .add(TimelineEvent.filterChanged(state.activeFilters));
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            final selectedSourceId =
                state.selectedSource == 'All' ? null : state.selectedSource;
            print(
                'DEBUG: HomeBloc selectedSource changed to: ${state.selectedSource}, mapped to: ${selectedSourceId}');
            context
                .read<TimelineBloc>()
                .add(TimelineEvent.sourceChanged(selectedSourceId));
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.medicalRecords,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            backgroundColor: context.colorScheme.surface,
            actions: [
              IconButton(
                onPressed: () async {
                  _showFilterDialog(context);
                },
                icon: Assets.icons.filter.svg(
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
            elevation: 0,
          ),
          floatingActionButton: _showScrollToTopButton
              ? FloatingActionButton(
                  onPressed: _scrollToTop,
                  mini: true,
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  child: const Icon(Icons.keyboard_arrow_up),
                )
              : null,
          floatingActionButtonLocation: _customFabLocation,
          body: Column(
            children: [
              // Search and filter section
              Padding(
                padding: const EdgeInsets.all(Insets.normal),
                child: Column(
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: context.l10n.searchRecordsHint,
                        hintStyle:
                            const TextStyle(color: AppColors.textSecondary),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(Insets.smallNormal),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: Assets.icons.search.svg(),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                        ),
                        filled: true,
                        fillColor: context.colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Insets.smallNormal,
                        ),
                      ),
                    ),
                    const SizedBox(height: Insets.small),
                    // Filter chips
                    BlocBuilder<RecordsFilterBloc, RecordsFilterState>(
                      builder: (context, state) {
                        if (state.activeFilters.isEmpty) {
                          return const SizedBox();
                        }
                        return Wrap(
                          spacing: 8.0,
                          children: state.activeFilters
                              .map(
                                (filter) => FilterChip(
                                  label: Text(getFhirResourceDisplay(filter)),
                                  selected: true,
                                  selectedColor: _getResourceTypeColor(filter)
                                      .withAlpha(45),
                                  onSelected: (bool value) {},
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () {
                                    context.read<RecordsFilterBloc>().add(
                                        RecordsFilterEvent.toggleFilter(
                                            filter));
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Records list
              Expanded(
                child: BlocBuilder<TimelineBloc, TimelineState>(
                  builder: (context, state) {
                    if (state.status == TimelineStatus.loading &&
                        state.resources.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == TimelineStatus.failure) {
                      return Center(child: Text(state.error));
                    }

                    final timelineResources = state.resources;

                    if (timelineResources.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open,
                                  size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No records found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        left: Insets.normal,
                        right: Insets.normal,
                        bottom: 100,
                      ),
                      itemCount: timelineResources.length +
                          (state.hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == timelineResources.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final resource = timelineResources[index];
                        return _buildTimelineResourceEntry(
                          context,
                          resource: resource,
                          index: index,
                          isFirst: index == 0,
                          isLast: index == timelineResources.length - 1,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineResourceEntry(
    BuildContext context, {
    required TimelineResourceModel resource,
    required int index,
    required bool isFirst,
    required bool isLast,
  }) {
    const double dotSize = 16.0;
    const double lineWidth = 2.0;
    const double timelineColumnWidth = 40.0;

    return IntrinsicHeight(
      key: ValueKey('timeline-${resource.resourceType}-${resource.id}-$index'),
      child: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(
              left: timelineColumnWidth / 3.5 + dotSize / 2,
              bottom: Insets.normal,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.border),
              ),
              margin: const EdgeInsets.only(right: Insets.normal),
              child: Padding(
                padding: const EdgeInsets.all(Insets.normal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resource type tag and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<RecordsFilterBloc>().add(
                                RecordsFilterEvent.toggleFilter(
                                    resource.resourceType));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.small,
                              vertical: Insets.extraSmall,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _getResourceTypeColor(resource.resourceType)
                                      .withAlpha(45),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _getResourceTypeColor(
                                    resource.resourceType),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              getFhirResourceDisplay(resource.resourceType),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: _getResourceTypeColor(
                                    resource.resourceType),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        if (resource.formattedDate != null)
                          Text(
                            resource.formattedDate!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: Insets.small),
                    // Resource content
                    if (resource.isEncounter && resource.encounterModel != null)
                      BlocProvider(
                        create: (context) => getIt<EncounterDetailBloc>()
                          ..add(EncounterDetailEvent.load(
                              resource.encounterModel!.id)),
                        child: EncounterCard(
                            displayModel: resource.encounterModel!),
                      )
                    else if (resource.isStandalone &&
                        resource.resourceModel != null)
                      UnifiedResourceCard(
                        displayModel: resource.resourceModel!,
                        isStandalone: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResourceDetailPage(
                                  resource: resource.resourceModel!),
                            ),
                          );
                        },
                      )
                    else
                      // Fallback for any resource that doesn't have proper models
                      Text(
                        resource.primaryDisplay,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Timeline line and dot
          SizedBox(
            width: timelineColumnWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Upper line
                Expanded(
                  child: Container(
                    width: lineWidth,
                    color: !isFirst ? AppColors.primary : Colors.transparent,
                  ),
                ),
                // Dot
                Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: _getResourceTypeColor(resource.resourceType),
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                // Lower line
                Expanded(
                  child: Container(
                    width: lineWidth,
                    color: !isLast ? AppColors.primary : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getResourceTypeColor(String resourceType) {
    switch (resourceType.toLowerCase()) {
      case 'encounter':
        return Colors.blue;
      case 'allergyintolerance':
        return Colors.red;
      case 'condition':
        return Colors.orange;
      case 'procedure':
        return Colors.green;
      case 'medicationrequest':
        return Colors.purple;
      case 'observation':
        return Colors.teal;
      case 'diagnosticreport':
        return Colors.indigo;
      case 'immunization':
        return Colors.pink;
      case 'careplan':
        return Colors.brown;
      case 'goal':
        return Colors.amber;
      case 'documentreference':
        return Colors.cyan;
      case 'media':
        return Colors.deepOrange;
      case 'location':
        return Colors.lime;
      case 'organization':
        return Colors.deepPurple;
      case 'practitioner':
        return Colors.lightBlue;
      case 'patient':
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  void _showFilterDialog(BuildContext context) {
    final timelineState = context.read<TimelineBloc>().state;
    final uniqueResourceTypes =
        timelineState.resources.map((e) => e.resourceType).toSet();

    showDialog(
      context: context,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<RecordsFilterBloc>(context),
          ),
          BlocProvider.value(
            value: BlocProvider.of<TimelineBloc>(context),
          ),
        ],
        child: RecordsFilterDialog(
          displayedResourceTypes: uniqueResourceTypes,
        ),
      ),
    );
  }
}

// Custom FloatingActionButtonLocation that positions the button 50px higher
class _CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final defaultOffset =
        FloatingActionButtonLocation.endFloat.getOffset(scaffoldGeometry);
    return Offset(defaultOffset.dx, defaultOffset.dy - 38);
  }
}
