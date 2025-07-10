import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/condition/condition.dart';

class ConditionCard extends StatelessWidget {
  final Condition condition;

  const ConditionCard({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              condition.codeText ?? 'Condition',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (condition.clinicalStatus != null)
              _buildDetailRow('Clinical Status', condition.clinicalStatus!),
            if (condition.dateRecorded != null)
              _buildDetailRow('Date Recorded', condition.dateRecorded!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
