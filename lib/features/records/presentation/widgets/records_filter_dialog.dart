import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';

class RecordsFilterDialog extends StatelessWidget {
  final String? selectedFilter;
  const RecordsFilterDialog({super.key, this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Filter Timeline'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: state.availableFilters.map((filter) {
              return CheckboxListTile(
                title: Text(filter),
                value: state.filters.contains(filter),
                onChanged: (bool? value) {
                  if (value == true) {
                    context
                        .read<RecordsBloc>()
                        .add(RecordsEvent.addFilter(filter));
                  } else {
                    context
                        .read<RecordsBloc>()
                        .add(RecordsEvent.removeFilter(filter));
                  }
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
