import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';

class RecordsFilterDialog extends StatelessWidget {
  const RecordsFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Records'),
      content: BlocBuilder<RecordsBloc, RecordsState>(
        builder: (context, state) {
          return Wrap(
            spacing: 8.0,
            children: state.availableFilters.map((filter) {
              final isSelected = state.activeFilters.contains(filter);
              return FilterChip(
                label: Text(filter.display),
                selected: isSelected,
                onSelected: (selected) {
                  context.read<RecordsBloc>().add(RecordsFilterToggled([filter]));
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
            context.read<RecordsBloc>().add(const RecordsInitialised());
            context.popDialog();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
