import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class FhirResourceCard extends StatelessWidget {
  final FhirResourceDisplayModel displayModel;

  const FhirResourceCard({super.key, required this.displayModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with resource type and date
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: Insets.small,
          //         vertical: Insets.extraSmall,
          //       ),
          //       decoration: BoxDecoration(
          //         color: _getResourceTypeColor(displayModel.resourceType)
          //             .withAlpha(45),
          //         borderRadius: BorderRadius.circular(16),
          //       ),
          //       child: Text(
          //         displayModel.display,
          //         style: context.textTheme.bodySmall?.copyWith(
          //           color: _getResourceTypeColor(displayModel.resourceType),
          //         ),
          //       ),
          //     ),
          //     if (displayModel.formattedDate != null)
          //       Padding(
          //         padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          //         child: Text(
          //           displayModel.formattedDate!,
          //           style: context.textTheme.bodySmall?.copyWith(
          //             color: AppColors.textSecondary,
          //           ),
          //         ),
          //       ),
          //   ],
          // ),
          // const SizedBox(height: Insets.medium),

          // Resource title
          Text(
            displayModel.primaryDisplay,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          // Subtitle if available
          if (displayModel.secondaryDisplay != null) ...[
            const SizedBox(height: Insets.small),
            Text(
              displayModel.secondaryDisplay!,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],

          const SizedBox(height: Insets.medium),

          // Details row
          if (displayModel.hasAdditionalInfo) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getResourceTypeIcon(displayModel.resourceType),
                const SizedBox(width: Insets.small),
                Expanded(
                  child: Text(
                    displayModel.additionalInfo.join(', '),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Insets.small),
          ],

          const SizedBox(height: Insets.small),

          // Action buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => _showResourceDetails(context),
                icon: const Icon(Icons.info_outline, size: 16),
                label: const Text('Details'),
                style: TextButton.styleFrom(
                  foregroundColor:
                      _getResourceTypeColor(displayModel.resourceType),
                  textStyle: context.textTheme.bodySmall,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showRelatedResources(context),
                icon: const Icon(Icons.link, size: 16),
                label: const Text('Related'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  textStyle: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getResourceTypeColor(String resourceType) {
    switch (resourceType) {
      case 'Encounter':
        return AppColors.primary;
      case 'AllergyIntolerance':
        return Colors.red;
      case 'MedicationRequest':
        return Colors.blue;
      case 'Observation':
        return Colors.green;
      case 'Condition':
        return Colors.orange;
      case 'Procedure':
        return Colors.purple;
      case 'Immunization':
        return Colors.teal;
      case 'DiagnosticReport':
        return Colors.indigo;
      default:
        return AppColors.primary;
    }
  }

  Widget _getResourceTypeIcon(String resourceType) {
    switch (resourceType) {
      case 'Encounter':
        return Assets.icons.calendar.svg(
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            _getResourceTypeColor(resourceType),
            BlendMode.srcIn,
          ),
        );
      case 'AllergyIntolerance':
        return Icon(
          Icons.warning_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'MedicationRequest':
        return Icon(
          Icons.medication_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'Observation':
        return Icon(
          Icons.analytics_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'Condition':
        return Icon(
          Icons.local_hospital_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'Procedure':
        return Icon(
          Icons.medical_services_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'Immunization':
        return Icon(
          Icons.vaccines_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      case 'DiagnosticReport':
        return Icon(
          Icons.assignment_outlined,
          size: 20,
          color: _getResourceTypeColor(resourceType),
        );
      default:
        return Assets.icons.activity.svg(
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            _getResourceTypeColor(resourceType),
            BlendMode.srcIn,
          ),
        );
    }
  }

  void _showResourceDetails(BuildContext context) {
    // TODO: Navigate to resource details screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Show details for ${displayModel.resourceType}: ${displayModel.id}')),
    );
  }

  void _showRelatedResources(BuildContext context) {
    // TODO: Navigate to related resources screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Show related resources for ${displayModel.resourceType}: ${displayModel.id}')),
    );
  }
}
