import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/records/presentation/widgets/filter_chip_widget.dart';
import 'package:health_wallet/features/records/presentation/widgets/records_filter_dialog.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart'
    as fhir;
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

@RoutePage()
class RecordsPage extends StatefulWidget {
  final String? filter;

  const RecordsPage({super.key, this.filter});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final homeState = context.read<HomeBloc>().state;
    final selectedSource = homeState.selectedSource;
    context.read<RecordsBloc>().add(
          RecordsEvent.loadRecords(
            sourceId: selectedSource == 'All' ? null : selectedSource,
            filter: widget.filter,
          ),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('RecordsPage: build method called');
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        final selectedSource = state.selectedSource;
        logger.d(
            'RecordsPage: HomeBloc listener triggered, selectedSource: $selectedSource');
        context.read<RecordsBloc>().add(
              RecordsEvent.loadRecords(
                sourceId: selectedSource == 'All' ? null : selectedSource,
              ),
            );
      },
      listenWhen: (previous, current) =>
          previous.selectedSource != current.selectedSource,
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
                onPressed: () {
                  // Add share functionality here
                },
                icon: Assets.icons.share.svg(),
              ),
              BlocBuilder<RecordsBloc, RecordsState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Assets.icons.filter.svg(),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<RecordsBloc>(context),
                          child: RecordsFilterDialog(
                            selectedFilter: state.filters.isNotEmpty
                                ? state.filters.first
                                : null,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Insets.normal),
                  child: Column(
                    children: [
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
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                          filled: true,
                          fillColor: context.colorScheme.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: Insets.smallNormal,
                          ),
                        ),
                      ),
                      const SizedBox(height: Insets.small),
                      BlocBuilder<RecordsBloc, RecordsState>(
                        builder: (context, state) {
                          if (state.filters.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8.0,
                                children: state.filters
                                    .map(
                                      (filter) => FilterChipWidget(
                                        label: filter,
                                        onDeleted: () {
                                          final newFilters =
                                              List<String>.from(state.filters)
                                                ..remove(filter);
                                          context.read<RecordsBloc>().add(
                                                RecordsEvent.updateFilters(
                                                    newFilters),
                                              );
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<RecordsBloc, RecordsState>(
                  builder: (context, state) {
                    logger.d(
                        'RecordsPage: RecordsBloc builder called with state: $state');
                    if (state.status == RecordsStatus.loading &&
                        state.entries.isEmpty) {
                      logger.d('RecordsPage: showing loading indicator');
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == RecordsStatus.failure) {
                      logger.e(
                          'RecordsPage: showing failure state: ${state.error}');
                      return Center(child: Text(state.error));
                    }

                    final filteredEntries = state.entries.where((entry) {
                      if (state.filters.isEmpty) {
                        return true;
                      }
                      return state.filters.contains(entry.resourceType);
                    }).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredEntries.length,
                      itemBuilder: (context, index) {
                        final entry = filteredEntries[index];
                        return _buildTimelineEntry(
                          context,
                          entry: entry,
                          isFirst: index == 0,
                          isLast: index == filteredEntries.length - 1,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: Insets.huge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineEntry(
    BuildContext context, {
    required fhir.FhirResource entry,
    required bool isFirst,
    required bool isLast,
  }) {
    const double dotSize = 16.0;
    const double lineWidth = 2.0;
    const double timelineColumnWidth = 40.0;
    // For first/last logic, you may want to pass index/length, but for now, use green dot for all

    return IntrinsicHeight(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: timelineColumnWidth / 3.5 + dotSize / 2,
                bottom: Insets.normal),
            child: GestureDetector(
              onTap: () {
                context.appRouter.push(RecordDetailRoute(resource: entry));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: AppColors.border),
                ),
                margin: const EdgeInsets.only(right: Insets.normal),
                child: Padding(
                  padding: const EdgeInsets.all(Insets.normal),
                  child: _RecordCard(resource: entry),
                ),
              ),
            ),
          ),
          SizedBox(
            width: timelineColumnWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Vertically center the dot and lines within its column
              children: [
                // Upper line segment: Always an Expanded widget, but transparent if it's the first item.
                Expanded(
                  child: Container(
                    width: lineWidth,
                    color: !isFirst
                        ? AppColors.primary
                        : Colors
                            .transparent, // Grey line, or transparent if first item
                  ),
                ),

                // Dot: A circular container representing the point on the timeline.
                Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background for the dot
                    border: Border.all(
                        color: AppColors.primary,
                        width: 3), // Blue border for the dot
                    shape: BoxShape.circle,
                  ),
                ),

                // Lower line segment: Always an Expanded widget, but transparent if it's the last item.
                Expanded(
                  child: Container(
                    width: lineWidth,
                    color: !isLast
                        ? AppColors.primary
                        : Colors
                            .transparent, // Grey line, or transparent if last item
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final fhir.FhirResource resource;

  const _RecordCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    final resourceJson = resource.resourceJson;
    String title;
    String subtitle;

    switch (resource.resourceType) {
      case 'Patient':
        final name = resourceJson['name'] as List?;
        final firstName = name?.first['given']?.first ?? 'N/A';
        final lastName = name?.first['family'] ?? 'N/A';
        title = '$firstName $lastName';
        subtitle = 'Patient';
        break;
      case 'Observation':
        title = resourceJson['code']?['text'] ?? 'Observation';
        final value = resourceJson['valueQuantity']?['value'] ?? '';
        final unit = resourceJson['valueQuantity']?['unit'] ?? '';
        subtitle = '$value $unit';
        break;
      case 'MedicationRequest':
        title = resourceJson['medicationCodeableConcept']?['text'] ??
            'Medication Request';
        subtitle = resourceJson['requester']?['display'] ?? '';
        break;
      case 'Condition':
        title = resourceJson['code']?['text'] ?? 'Condition';
        subtitle =
            resourceJson['clinicalStatus']?['coding']?.first['display'] ?? '';
        break;
      case 'Immunization':
        title = resourceJson['vaccineCode']?['text'] ?? 'Immunization';
        subtitle = resourceJson['status'] ?? '';
        break;
      case 'Procedure':
        title = resourceJson['code']?['text'] ?? 'Procedure';
        subtitle = resourceJson['status'] ?? '';
        break;
      default:
        title = resource.resourceType;
        subtitle = resource.id ?? '';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left text section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: Insets.extraSmall),
              Text(
                subtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: Insets.small),
        // Right action section
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                final newFilters =
                    List<String>.from(context.read<RecordsBloc>().state.filters)
                      ..add(resource.resourceType);
                context
                    .read<RecordsBloc>()
                    .add(RecordsEvent.updateFilters(newFilters));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.small,
                  vertical: Insets.extraSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  resource.resourceType,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Insets.small),
            IconButton(
              onPressed: () {
                // Share functionality
              },
              icon: Icon(
                Icons.share,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
