import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/practitioner/practitioner.dart';

class PractitionerCard extends StatelessWidget {
  final Practitioner practitioner;

  const PractitionerCard({super.key, required this.practitioner});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${practitioner.name?.first.given?.first ?? ''} ${practitioner.name?.first.family ?? ''}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Gender', practitioner.gender ?? 'N/A'),
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
