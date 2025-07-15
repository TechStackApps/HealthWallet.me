import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/resource_card_configs.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ResourceDetailPage extends StatelessWidget {
  final FhirResourceDisplayModel resource;

  const ResourceDetailPage({
    super.key,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    final config = ResourceCardConfigs.getConfig(resource.resourceType);

    return Scaffold(
      appBar: AppBar(
        title: Text(config.displayName),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement sharing functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            _buildHeaderCard(context, config),

            const SizedBox(height: Insets.normal),

            // Main content
            _buildMainContent(context, config),

            const SizedBox(height: Insets.normal),

            // Additional details
            _buildAdditionalDetails(context, config),

            const SizedBox(height: Insets.normal),

            // Raw data (for debugging/technical users)
            _buildRawDataSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, ResourceCardConfig config) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resource type badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.small,
                    vertical: Insets.extraSmall,
                  ),
                  decoration: BoxDecoration(
                    color: config.color.withAlpha(45),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: config.color, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        config.icon,
                        size: 16,
                        color: config.color,
                      ),
                      const SizedBox(width: Insets.extraSmall),
                      Text(
                        config.displayName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: config.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Status badge
                if (resource.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.small,
                      vertical: Insets.extraSmall,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(resource.status!).withAlpha(45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(resource.status!),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      resource.status!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(resource.status!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: Insets.normal),

            // Primary display
            Text(
              resource.primaryDisplay,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            // Secondary display
            if (resource.secondaryDisplay != null) ...[
              const SizedBox(height: Insets.small),
              Text(
                resource.secondaryDisplay!,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],

            // Date
            if (resource.date != null) ...[
              const SizedBox(height: Insets.small),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    _formatDate(resource.date!),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
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

  Widget _buildMainContent(BuildContext context, ResourceCardConfig config) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Insets.normal),

            // Category
            if (resource.category != null)
              _buildDetailRow(
                context,
                'Category',
                resource.category!,
                Icons.category,
              ),

            // Additional info
            ...resource.additionalInfo.map((info) {
              if (info.isNotEmpty) {
                return _buildDetailRow(
                  context,
                  'Info',
                  info,
                  Icons.info_outline,
                );
              }
              return const SizedBox.shrink();
            }),

            // Resource-specific fields
            ..._buildResourceSpecificFields(context, config),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetails(
      BuildContext context, ResourceCardConfig config) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Information',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Insets.normal),

            // Resource ID
            _buildDetailRow(
              context,
              'Resource ID',
              resource.id,
              Icons.fingerprint,
            ),

            // Resource Type
            _buildDetailRow(
              context,
              'Resource Type',
              resource.resourceType,
              Icons.category,
            ),

            // Standalone indicator
            _buildDetailRow(
              context,
              'Type',
              'Standalone Resource',
              Icons.star,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRawDataSection(BuildContext context) {
    return Card(
      elevation: 1,
      child: ExpansionTile(
        leading: const Icon(Icons.code),
        title: Text(
          'Raw Data',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text('Technical information (for debugging)'),
        children: [
          Padding(
            padding: const EdgeInsets.all(Insets.normal),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Insets.normal),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                _formatRawData(resource.rawResource),
                style: context.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: context.colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: Insets.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildResourceSpecificFields(
    BuildContext context,
    ResourceCardConfig config,
  ) {
    final widgets = <Widget>[];
    final rawData = resource.rawResource;

    // Add resource-specific fields based on type
    for (final field in config.primaryFields) {
      final value = _extractFieldValue(rawData, field);
      if (value != null && value.isNotEmpty) {
        widgets.add(_buildDetailRow(
          context,
          _formatFieldName(field),
          value,
          Icons.medical_information,
        ));
      }
    }

    for (final field in config.secondaryFields) {
      final value = _extractFieldValue(rawData, field);
      if (value != null && value.isNotEmpty) {
        widgets.add(_buildDetailRow(
          context,
          _formatFieldName(field),
          value,
          Icons.info,
        ));
      }
    }

    return widgets;
  }

  String? _extractFieldValue(Map<String, dynamic> data, String field) {
    // Handle nested fields
    if (field.contains('.')) {
      final parts = field.split('.');
      dynamic current = data;
      for (final part in parts) {
        if (current is Map<String, dynamic> && current.containsKey(part)) {
          current = current[part];
        } else {
          return null;
        }
      }
      return current?.toString();
    }

    // Handle direct fields
    final value = data[field];
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      // Try to extract text or display from complex objects
      return value['text'] ?? value['display'] ?? value.toString();
    }
    if (value is List) {
      return value.map((e) => e.toString()).join(', ');
    }
    return value?.toString();
  }

  String _formatFieldName(String field) {
    // Convert camelCase to Title Case
    final regex = RegExp(r'(?=[A-Z])');
    return field.split(regex).map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM d, yyyy \'at\' h:mm a').format(date);
    } catch (_) {
      return dateString;
    }
  }

  String _formatRawData(Map<String, dynamic> data) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }

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
