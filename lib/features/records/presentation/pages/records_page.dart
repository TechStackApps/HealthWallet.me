import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/records/presentation/widgets/records_filter_bottom_sheet.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/unified_resource_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/encounter_card.dart';

import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:intl/intl.dart';

@RoutePage()
class RecordsPage extends StatelessWidget {
  final List<FhirType>? initFilters;

  const RecordsPage({super.key, this.initFilters});

  @override
  Widget build(BuildContext context) {
    // Use the global RecordsBloc that's already provided in app.dart
    return RecordsView(initFilters: initFilters);
  }
}

class RecordsView extends StatefulWidget {
  final List<FhirType>? initFilters;

  const RecordsView({super.key, this.initFilters});

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

    _scrollController.addListener(_onScroll);

    final selected = context.read<HomeBloc>().state.selectedSource;
    final selectedSourceId = selected == 'All' ? null : selected;
    // Optional: init diagnostics (removed noisy logs)
    context.read<RecordsBloc>().add(RecordsSourceChanged(selectedSourceId));

    if (widget.initFilters != null) {
      context
          .read<RecordsBloc>()
          .add(RecordsFiltersApplied(widget.initFilters!));
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
        final state = context.read<RecordsBloc>().state;
        if (state.status != RecordsStatus.loading() && state.hasMorePages) {
          context.read<RecordsBloc>().add(const RecordsLoadMore());
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
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            final selectedSourceId =
                state.selectedSource == 'All' ? null : state.selectedSource;

            context
                .read<RecordsBloc>()
                .add(RecordsSourceChanged(selectedSourceId));
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.medicalRecords,
              style: AppTextStyle.titleMedium,
            ),
            backgroundColor: context.colorScheme.surface,
            actions: [
              IconButton(
                onPressed: () {
                  // Share functionality
                },
                icon: Assets.icons.share.svg(
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BlocBuilder<RecordsBloc, RecordsState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        builder: (context) => RecordsFilterBottomSheet(
                          activeFilters: state.activeFilters,
                          onApply: (filters) => context
                              .read<RecordsBloc>()
                              .add(RecordsFiltersApplied(filters)),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    icon: Assets.icons.filter.svg(
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: context.l10n.searchRecordsHint,
                        hintStyle: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.6),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Assets.icons.search.svg(width: 16),
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
                    BlocBuilder<RecordsBloc, RecordsState>(
                      builder: (context, state) {
                        if (state.activeFilters.isEmpty) {
                          return const SizedBox();
                        }
                        return Wrap(
                          spacing: 8.0,
                          runSpacing: 8,
                          children: state.activeFilters
                              .map(
                                (filter) => GestureDetector(
                                  onTap: () => context
                                      .read<RecordsBloc>()
                                      .add(RecordsFilterRemoved(filter)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          filter.display,
                                          style: AppTextStyle.labelSmall
                                              .copyWith(
                                                  color: AppColors.primary),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.close,
                                          color: AppColors.primary,
                                          size: 12,
                                        )
                                      ],
                                    ),
                                  ),
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
                child: BlocBuilder<RecordsBloc, RecordsState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == const RecordsStatus.loading()) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: Colors.red,
                        ),
                      );
                    }

                    if (state.status == RecordsStatus.failure(Exception())) {
                      return Center(child: Text(state.status.toString()));
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
                      itemCount: timelineResources.length +
                          (state.hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == timelineResources.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                color: Colors.red,
                              ),
                            ),
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
    required IFhirResource resource,
    required int index,
    required bool isFirst,
    required bool isLast,
  }) {
    const double dotSize = 16.0;
    const double lineWidth = 2.0;

    FhirType recordType = resource.fhirType;

    return IntrinsicHeight(
      key: ValueKey('timeline-${resource.fhirType}-${resource.id}-$index'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.only(
                bottom: Insets.normal,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
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
                              context.read<RecordsBloc>().add(
                                    RecordsFiltersApplied([recordType]),
                                  );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Insets.small,
                                vertical: Insets.extraSmall,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  recordType.icon.svg(width: 15),
                                  const SizedBox(width: 4),
                                  Text(
                                    recordType.display,
                                    style: AppTextStyle.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (resource.date != null)
                            Text(
                              DateFormat.yMMMMd().format(resource.date!),
                              style: AppTextStyle.labelMedium,
                            ),
                        ],
                      ),
                      const SizedBox(height: Insets.small),
                      // Resource content - Simple approach
                      if (resource.fhirType == FhirType.Encounter)
                        EncounterCard(encounter: resource as Encounter)
                      else
                        UnifiedResourceCard(
                          resource: resource,
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => ResourceDetailPage(
                            //         resource: resource.resourceModel!),
                            //   ),
                            // );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Timeline line and dot
            Transform.translate(
              offset: const Offset(-dotSize / 2, 0),
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
                          color: AppColors.primary,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            color: AppColors.primary.withValues(alpha: 0.6),
                            blurRadius: 3,
                          )
                        ]),
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
