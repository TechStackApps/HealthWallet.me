import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/procedure/procedure.dart';
import 'package:intl/intl.dart';

class ProcedureCard extends StatelessWidget {
  final Procedure procedure;

  const ProcedureCard({super.key, required this.procedure});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              procedure.code.text ?? 'Procedure',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Status', procedure.status),
            if (procedure.performedDateTime != null)
              _buildDetailRow(
                'Date',
                DateFormat.yMMMd().format(procedure.performedDateTime!),
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
