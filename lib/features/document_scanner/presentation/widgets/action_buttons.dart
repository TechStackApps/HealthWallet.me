import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCreateEncounter;
  final VoidCallback onAttachToEncounter;
  final VoidCallback? onExtractText;

  const ActionButtons({
    super.key,
    required this.onCreateEncounter,
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
                onPressed: onCreateEncounter,
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
