import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/presentation/widgets/resource_card_configs.dart';
import 'package:intl/intl.dart';

// TODO: refactor this to use IFhirResource
class UnifiedResourceCard extends StatelessWidget {
  final IFhirResource resource;
  final bool isStandalone;
  final VoidCallback? onTap;

  const UnifiedResourceCard({
    super.key,
    required this.resource,
    this.isStandalone = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // final config = ResourceCardConfigs.getConfig(displayModel.resourceType);

    // return InkWell(
    //   onTap: onTap,
    //   borderRadius: BorderRadius.circular(8),
    //   child: Container(
    //     padding: const EdgeInsets.all(Insets.normal),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Primary content
    //         _buildPrimaryContent(context, config),

    //         // Secondary content (if any)
    //         if (displayModel.secondaryDisplay != null) ...[
    //           const SizedBox(height: Insets.extraSmall),
    //           _buildSecondaryContent(context, config),
    //         ],

    //         // Additional fields specific to resource type
    //         ..._buildAdditionalFields(context, config),

    //         // Footer with date and actions
    //         if (displayModel.date != null) ...[
    //           const SizedBox(height: Insets.small),
    //           _buildFooter(context, config),
    //         ],
    //       ],
    //     ),
    //   ),
    // );
  }

  // Widget _buildHeader(BuildContext context, ResourceCardConfig config) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       // Resource type badge
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: Insets.small,
  //           vertical: Insets.extraSmall,
  //         ),
  //         decoration: BoxDecoration(
  //           color: config.color.withAlpha(45),
  //           borderRadius: BorderRadius.circular(16),
  //           border: Border.all(color: config.color, width: 1),
  //         ),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               config.icon,
  //               size: 14,
  //               color: config.color,
  //             ),
  //             const SizedBox(width: Insets.extraSmall),
  //             Text(
  //               displayModel.resourceType,
  //               style: context.textTheme.bodySmall?.copyWith(
  //                 color: config.color,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),

  //       // Status badge (if available)
  //       if (displayModel.status != null)
  //         Container(
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: Insets.small,
  //             vertical: Insets.extraSmall,
  //           ),
  //           decoration: BoxDecoration(
  //             color: _getStatusColor(displayModel.status!).withAlpha(45),
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: _getStatusColor(displayModel.status!),
  //               width: 1,
  //             ),
  //           ),
  //           child: Text(
  //             displayModel.status!,
  //             style: context.textTheme.bodySmall?.copyWith(
  //               color: _getStatusColor(displayModel.status!),
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  // Widget _buildPrimaryContent(BuildContext context, ResourceCardConfig config) {
  //   return Text(
  //     displayModel.primaryDisplay,
  //     style: context.textTheme.titleMedium?.copyWith(
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

  // Widget _buildSecondaryContent(
  //     BuildContext context, ResourceCardConfig config) {
  //   return Text(
  //     displayModel.secondaryDisplay!,
  //     style: context.textTheme.bodyMedium?.copyWith(
  //       color: AppColors.textSecondary,
  //     ),
  //   );
  // }

  // List<Widget> _buildAdditionalFields(
  //     BuildContext context, ResourceCardConfig config) {
  //   final widgets = <Widget>[];

  //   // Add category if available
  //   if (displayModel.category != null) {
  //     widgets.add(const SizedBox(height: Insets.extraSmall));
  //     widgets.add(
  //       Row(
  //         children: [
  //           Icon(
  //             Icons.category,
  //             size: 16,
  //             color: context.colorScheme.onSurface.withOpacity(0.6),
  //           ),
  //           const SizedBox(width: Insets.extraSmall),
  //           Text(
  //             displayModel.category!,
  //             style: context.textTheme.bodySmall?.copyWith(
  //               color: AppColors.textSecondary,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   // Add additional info
  //   for (final info in displayModel.additionalInfo) {
  //     if (info.isNotEmpty) {
  //       widgets.add(const SizedBox(height: Insets.extraSmall));
  //       widgets.add(
  //         Row(
  //           children: [
  //             Icon(
  //               Icons.info_outline,
  //               size: 16,
  //               color: context.colorScheme.onSurface.withOpacity(0.6),
  //             ),
  //             const SizedBox(width: Insets.extraSmall),
  //             Expanded(
  //               child: Text(
  //                 info,
  //                 style: context.textTheme.bodySmall?.copyWith(
  //                   color: AppColors.textSecondary,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   }

  //   return widgets;
  // }

  // Widget _buildFooter(BuildContext context, ResourceCardConfig config) {
  //   return Row(
  //     children: [
  //       // Date
  //       Icon(
  //         Icons.access_time,
  //         size: 16,
  //         color: context.colorScheme.onSurface.withOpacity(0.6),
  //       ),
  //       const SizedBox(width: Insets.extraSmall),
  //       Text(
  //         _formatDate(displayModel.date!),
  //         style: context.textTheme.bodySmall?.copyWith(
  //           color: AppColors.textSecondary,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // String _formatDate(String dateString) {
  //   try {
  //     final date = DateTime.parse(dateString);
  //     return DateFormat('MMM d, yyyy').format(date);
  //   } catch (_) {
  //     return dateString;
  //   }
  // }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'finished':
      case 'completed':
        return Colors.green;
      case 'in-progress':
      case 'draft':
        return Colors.blue;
      case 'cancelled':
      case 'stopped':
        return Colors.red;
      case 'planned':
      case 'requested':
        return Colors.orange;
      case 'on-hold':
      case 'suspended':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
