import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/diagnostic_report/diagnostic_report.dart';
import 'package:intl/intl.dart';

class DiagnosticReportCard extends StatelessWidget {
  final DiagnosticReport report;

  const DiagnosticReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.title ?? 'Diagnostic Report',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (report.status != null)
              _buildDetailRow('Status', report.status!),
            if (report.effectiveDatetime != null)
              _buildDetailRow(
                'Effective Date',
                report.effectiveDatetime!,
              ),
            if (report.conclusion != null)
              _buildDetailRow('Conclusion', report.conclusion!),
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
