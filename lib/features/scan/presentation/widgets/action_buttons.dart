import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onProcessToFhir;
  final VoidCallback onAttachToEncounter;
  final VoidCallback? onExtractText;

  const ActionButtons({
    super.key,
    required this.onProcessToFhir,
    required this.onAttachToEncounter,
    this.onExtractText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onProcessToFhir,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Process to FHIR'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAttachToEncounter,
                icon: const Icon(Icons.attach_file),
                label: const Text('Attach to encounter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        if (onExtractText != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onExtractText,
                  icon: const Icon(Icons.text_fields),
                  label: const Text('Extract Text'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 65),
      ],
    );
  }
}

class AddButtonCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddButtonCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 48,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
