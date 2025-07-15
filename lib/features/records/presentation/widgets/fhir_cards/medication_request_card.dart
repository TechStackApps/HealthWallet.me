import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/medication_request/medication_request.dart';

class MedicationRequestCard extends StatelessWidget {
  final MedicationRequest medicationRequest;

  const MedicationRequestCard({super.key, required this.medicationRequest});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              medicationRequest.medicationCodeableConcept?.text ??
                  'Medication Request',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Status', medicationRequest.status),
            _buildDetailRow('Intent', medicationRequest.intent),
            _buildDetailRow(
                'Requester',
                medicationRequest.requester?.when(
                      resolved: (resource) =>
                          (resource.resourceJson['name'] as List<dynamic>)
                              .first['text'],
                      unresolved: (reference) => reference,
                    ) ??
                    'N/A'),
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
