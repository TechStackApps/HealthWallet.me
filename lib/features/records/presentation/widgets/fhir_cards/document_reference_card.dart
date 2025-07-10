import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/document_reference/document_reference.dart';
import 'package:intl/intl.dart';

class DocumentReferenceCard extends StatelessWidget {
  final DocumentReference document;

  const DocumentReferenceCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title ?? 'Document Reference',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (document.status != null)
              _buildDetailRow('Status', document.status!),
            if (document.createdAt != null)
              _buildDetailRow(
                'Date',
                document.createdAt!,
              ),
            if (document.content?.isNotEmpty == true)
              _buildDetailRow(
                'Attachment',
                document.content!.first.title ?? 'N/A',
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
