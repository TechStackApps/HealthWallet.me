import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/immunization/immunization.dart';
import 'package:intl/intl.dart';

class ImmunizationCard extends StatelessWidget {
  final Immunization immunization;

  const ImmunizationCard({super.key, required this.immunization});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              immunization.title ?? 'Immunization',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (immunization.status != null)
              _buildDetailRow('Status', immunization.status!),
            if (immunization.providedDate != null)
              _buildDetailRow(
                'Date',
                immunization.providedDate!,
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
