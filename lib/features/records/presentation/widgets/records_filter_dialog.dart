import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';

class RecordsFilterDialog extends StatelessWidget {
  final String? selectedFilter;

  const RecordsFilterDialog({Key? key, this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Records'),
      content: BlocBuilder<RecordsBloc, RecordsState>(
        builder: (context, state) {
          return DropdownButton<String>(
            value: selectedFilter,
            items: state.availableFilters
                .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                context
                    .read<RecordsBloc>()
                    .add(RecordsEvent.updateFilters([value]));
                context.popDialog();
              }
            },
          );
        },
      ),
    );
  }
}
