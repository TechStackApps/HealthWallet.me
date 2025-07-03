import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/records/presentation/widgets/filter_chip.dart';
import 'package:health_wallet/features/records/presentation/widgets/records_filter_dialog.dart';

@RoutePage()
class RecordsPage extends StatefulWidget {
  final String? filter;

  const RecordsPage({super.key, this.filter});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.filter != null) {
      context.read<RecordsBloc>().add(AddFilter(widget.filter!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecordsView(scrollController: _scrollController);
  }
}

class RecordsView extends StatelessWidget {
  final ScrollController scrollController;

  const RecordsView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Records',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add share functionality here
            },
            icon: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          BlocBuilder<RecordsBloc, RecordsState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.filter_list),
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
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search records, doctors, locations...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textMuted,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                                      context.read<RecordsBloc>().add(
                                        RemoveFilter(filter),
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
            BlocConsumer<RecordsBloc, RecordsState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (entries, filters, availableFilters) {
                    if (filters.isNotEmpty) {
                      final index = entries.indexWhere(
                        (entry) => entry.tag == filters.first,
                      );
                      if (index != -1) {
                        // Scroll to the item
                        // This is a bit of a hack, but it works for now
                        // A better solution would be to use a ScrollablePositionedList
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController.animateTo(
                            index * 150.0, // Approximate height of each item
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: (_, __) => const SizedBox.shrink(),
                  loading: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (entries, _, __) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return _buildTimelineEntry(
                        context,
                        icon: entry.icon,
                        title: entry.title,
                        date: entry.date,
                        description: entry.description,
                        doctors: entry.doctors,
                        location: entry.location,
                        tag: entry.tag,
                        tagBgColor: entry.tagBgColor,
                        tagTextColor: entry.tagTextColor,
                      );
                    },
                  ),
                  error: (message, _, __) => Center(child: Text(message)),
                );
              },
            ),
            const SizedBox(height: 58),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEntry(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String date,
    required String description,
    required List<String> doctors,
    required String location,
    required String tag,
    required Color tagBgColor,
    required Color tagTextColor,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left side: Timeline Circle and Connector
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Expanded(child: Container(width: 2, color: AppColors.border)),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
                Expanded(child: Container(width: 2, color: AppColors.border)),
              ],
            ),
          ),
          // Right side: Content Card
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(right: 16.0, bottom: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 16,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  doctors.join(' & '),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<RecordsBloc>().add(AddFilter(tag));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tagBgColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tag,
                              style: textTheme.bodySmall?.copyWith(
                                color: tagTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        IconButton(
                          onPressed: () {
                            // Add share functionality here
                          },
                          icon: Icon(
                            Icons.share,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
