import 'package:flutter/material.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';

class EditRecordsDialog extends StatefulWidget {
  final Map<String, bool> selectedResources;
  final Function(Map<String, bool>) onSelectionChanged;

  const EditRecordsDialog({
    super.key,
    required this.selectedResources,
    required this.onSelectionChanged,
  });

  @override
  State<EditRecordsDialog> createState() => _EditRecordsDialogState();
}

class _EditRecordsDialogState extends State<EditRecordsDialog> {
  late Map<String, bool> _tempSelectedResources;

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
          children: ClinicalDataTags.resourceTypeMap.keys.map((resource) {
            return CheckboxListTile(
              title: Text(resource),
              value: _tempSelectedResources[resource] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  _tempSelectedResources[resource] = value!;
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
