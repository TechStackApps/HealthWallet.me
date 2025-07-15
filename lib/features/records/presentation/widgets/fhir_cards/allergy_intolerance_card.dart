import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/allergy_intolerance/allergy_intolerance.dart';

class AllergyIntoleranceCard extends StatelessWidget {
  final AllergyIntolerance allergy;

  const AllergyIntoleranceCard({super.key, required this.allergy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Allergy/Intoleranceeee',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            allergy.title ?? 'Allergy/Intolerance',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (allergy.type != null) _buildDetailRow('Type', allergy.type!),
          if (allergy.category != null)
            _buildDetailRow('Category', allergy.category!.join(', ')),
          if (allergy.status != null)
            _buildDetailRow('Status', allergy.status!),
        ],
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
