import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/observation/observation.dart';
import 'package:intl/intl.dart';

class ObservationCard extends StatelessWidget {
  final Observation observation;

  const ObservationCard({super.key, required this.observation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              observation.code.text ?? 'Observation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Status', observation.status),
            if (observation.valueQuantity != null)
              _buildDetailRow(
                'Value',
                '${observation.valueQuantity!.value} ${observation.valueQuantity!.unit}',
              ),
            if (observation.effectiveDateTime != null)
              _buildDetailRow(
                'Effective Date',
                DateFormat.yMMMd().format(observation.effectiveDateTime!),
              ),
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
