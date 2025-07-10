import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/encounter/encounter.dart';
import 'package:intl/intl.dart';

class EncounterCard extends StatelessWidget {
  final Encounter encounter;

  const EncounterCard({super.key, required this.encounter});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              encounter.code?.text ?? 'Encounter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (encounter.periodStart != null)
              Text(
                'Start date: ${encounter.periodStart}',
              ),
            const SizedBox(height: 8),
            if (encounter.locationDisplay != null)
              Text(
                'Location: ${encounter.locationDisplay}',
              ),
          ],
        ),
      ),
    );
  }
}
