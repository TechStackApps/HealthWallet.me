import 'package:flutter/material.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';

class EditRecordsDialog extends StatefulWidget {
  final Map<HomeRecordsCategory, bool> selectedResources;
  final Function(Map<HomeRecordsCategory, bool>) onSelectionChanged;

  const EditRecordsDialog({
    super.key,
    required this.selectedResources,
    required this.onSelectionChanged,
  });

  @override
  State<EditRecordsDialog> createState() => _EditRecordsDialogState();
}

class _EditRecordsDialogState extends State<EditRecordsDialog> {
  late Map<HomeRecordsCategory, bool> _tempSelectedResources;

  @override
  void initState() {
    super.initState();
    _tempSelectedResources = Map.from(widget.selectedResources);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Records'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: HomeRecordsCategory.values.map((category) {
            return CheckboxListTile(
              title: Text(category.display),
              value: _tempSelectedResources[category] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  _tempSelectedResources[category] = value!;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSelectionChanged(_tempSelectedResources);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
