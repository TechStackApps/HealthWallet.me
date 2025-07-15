import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/bloc/encounter_detail_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/unified_resource_card.dart';
import 'package:health_wallet/features/records/presentation/pages/resource_detail_page.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EncounterDetailPage extends StatelessWidget {
  final EncounterDisplayModel encounter;

  const EncounterDetailPage({
    super.key,
    required this.encounter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EncounterDetailBloc>()
        ..add(EncounterDetailEvent.load(encounter.id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Encounter Details'),
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
              _buildHeaderCard(context),

              const SizedBox(height: Insets.normal),

              // Main content
              _buildMainContent(context),

              const SizedBox(height: Insets.normal),

              // Related resources section
              _buildRelatedResourcesSection(context),

              const SizedBox(height: Insets.normal),

              // Raw data (for debugging/technical users)
              _buildRawDataSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resource type badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.small,
                vertical: Insets.extraSmall,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(45),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_hospital,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    'Encounter',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: Insets.normal),

            // Encounter type
            Text(
              encounter.encounterType,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            // Patient name
            const SizedBox(height: Insets.small),
            Text(
              encounter.patientDisplay,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            // Date/time
            if (encounter.formattedStartDate != null) ...[
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
                    encounter.formattedStartDate!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (encounter.endDate != null) ...[
                    const Text(' - '),
                    Text(
                      _formatDate(encounter.endDate!),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encounter Details',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: Insets.normal),

            // Practitioners
            if (encounter.practitionerNames.isNotEmpty) ...[
              _buildInfoRow(
                context,
                'Practitioners',
                encounter.practitionerNames.join(', '),
                Icons.person,
              ),
              const SizedBox(height: Insets.small),
            ],

            // Organization
            if (encounter.organizationName.isNotEmpty) ...[
              _buildInfoRow(
                context,
                'Organization',
                encounter.organizationName,
                Icons.business,
              ),
              const SizedBox(height: Insets.small),
            ],

            // Locations
            if (encounter.locationNames.isNotEmpty) ...[
              _buildInfoRow(
                context,
                'Locations',
                encounter.locationNames.join(', '),
                Icons.location_on,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: context.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: Insets.extraSmall),
        Text(
          '$label: ',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedResourcesSection(BuildContext context) {
    return BlocBuilder<EncounterDetailBloc, EncounterDetailState>(
      builder: (context, state) {
        if (state.status == EncounterDetailStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.relatedResources.isEmpty) {
          return const SizedBox(); // No related resources to show
        }

        final relatedResources = state.relatedResources;

        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(Insets.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Related Resources',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Insets.normal),
                ...relatedResources.entries.map((entry) {
                  final resourceType = entry.key;
                  final resources = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Resource type header
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Insets.small),
                        child: Text(
                          '$resourceType (${resources.length})',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _getResourceTypeColor(resourceType),
                          ),
                        ),
                      ),

                      // Resource list
                      ...resources.map((resource) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Insets.small),
                          child: UnifiedResourceCard(
                            displayModel: resource,
                            isStandalone: false,
                            onTap: () {
                              // Navigate to resource detail page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResourceDetailPage(resource: resource),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRawDataSection(BuildContext context) {
    return Card(
      elevation: 1,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            'Raw Data',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Technical details (JSON)',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Insets.normal),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: SelectableText(
                  _formatJson(encounter.rawEncounter),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e) {
      return json.toString();
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (_) {
      return dateString;
    }
  }

  Color _getResourceTypeColor(String resourceType) {
    switch (resourceType.toLowerCase()) {
      case 'allergyintolerance':
        return Colors.red;
      case 'condition':
        return Colors.orange;
      case 'procedure':
        return Colors.green;
      case 'medicationrequest':
        return Colors.purple;
      case 'observation':
        return Colors.teal;
      case 'diagnosticreport':
        return Colors.indigo;
      case 'immunization':
        return Colors.pink;
      case 'careplan':
        return Colors.brown;
      case 'goal':
        return Colors.amber;
      case 'documentreference':
        return Colors.cyan;
      case 'media':
        return Colors.deepOrange;
      case 'location':
        return Colors.lime;
      case 'organization':
        return Colors.deepPurple;
      case 'practitioner':
        return Colors.lightBlue;
      case 'patient':
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }
}
