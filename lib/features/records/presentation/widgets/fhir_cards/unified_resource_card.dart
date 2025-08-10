import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/display_factory_manager.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/encounter_card.dart';
import 'package:health_wallet/core/utils/date_format_utils.dart';

/// Unified card for displaying any FHIR resource type
/// Works directly with IFhirResource entities using EntityDisplayConverter
class UnifiedResourceCard extends StatelessWidget {
  final IFhirResource resource;
  final VoidCallback? onTap;

  const UnifiedResourceCard({
    super.key,
    required this.resource,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Special handling for Encounter - should use EncounterCard
    if (resource.fhirType == FhirType.Encounter) {
      return EncounterCard(
        encounter: resource,
      );
    }

    // Convert entity to display model for clean title extraction
    final displayModel =
        DisplayFactoryManager.instance.buildDisplayModel(resource);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayModel.primaryDisplay,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  resource.fhirType.display,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date - only show if there's a meaningful date
            if (resource.date != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormatUtils.humanReadable(resource.date!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Removed local date formatter in favor of DateFormatUtils
}
