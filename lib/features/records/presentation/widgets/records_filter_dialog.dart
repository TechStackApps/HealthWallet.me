import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/utils/fhir_resource_utils.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_filter_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/timeline_bloc.dart';

class RecordsFilterDialog extends StatelessWidget {
  final Set<String> displayedResourceTypes;

  const RecordsFilterDialog({super.key, required this.displayedResourceTypes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Records'),
      content: BlocBuilder<RecordsFilterBloc, RecordsFilterState>(
        builder: (context, state) {
          final filtersToShow = state.availableFilters
              .where((filter) => displayedResourceTypes.contains(filter))
              .toList();

          return Wrap(
            spacing: 8.0,
            children: filtersToShow.map((filter) {
              final isSelected = state.activeFilters.contains(filter);
              return FilterChip(
                label: Text(getFhirResourceDisplay(filter)),
                selected: isSelected,
                onSelected: (selected) {
                  context
                      .read<RecordsFilterBloc>()
                      .add(RecordsFilterEvent.toggleFilter(filter));
                },
              );
            }).toList(),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => context.popDialog(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final filters =
                context.read<RecordsFilterBloc>().state.activeFilters;
            context
                .read<TimelineBloc>()
                .add(TimelineEvent.filterChanged(filters));
            context.popDialog();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
