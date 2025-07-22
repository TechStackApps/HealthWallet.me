import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/logger.dart';

import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/pages/record_detail_page.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

class EncounterCard extends StatefulWidget {
  final EncounterDisplayModel displayModel;

  const EncounterCard({super.key, required this.displayModel});

  @override
  State<EncounterCard> createState() => _EncounterCardState();
}

class _EncounterCardState extends State<EncounterCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final encounter = widget.displayModel.rawEncounter;

    logger.d('EncounterCard build: ${encounter['id']}');
    logger.d('Practitioner names: ${widget.displayModel.practitionerNames}');
    logger.d('Organization name: "${widget.displayModel.organizationName}"');
    logger.d('Location names: ${widget.displayModel.locationNames}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main encounter info (always visible)
        _buildMainEncounterInfo(context),

        // Expand/Collapse button (always visible, positioned at top)
        const SizedBox(height: Insets.small),
        _buildExpandButton(context),

        // Expandable section for related resources (below the button)
        if (_isExpanded) ...[
          const SizedBox(height: Insets.small),
          _buildRelatedResourcesSection(context),
        ],
      ],
    );
  }

  Widget _buildMainEncounterInfo(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to encounter detail page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RecordDetailPage(encounter: widget.displayModel),
          ),
        );
      },
      // borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(Insets.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encounter type and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.displayModel.encounterType,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_getEncounterStatus().isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.small,
                      vertical: Insets.extraSmall,
                    ),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(_getEncounterStatus()).withAlpha(45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getStatusColor(_getEncounterStatus()),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getEncounterStatus(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(_getEncounterStatus()),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

            // Patient info
            if (widget.displayModel.patientDisplay.isNotEmpty) ...[
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Expanded(
                    child: Text(
                      widget.displayModel.patientDisplay,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Practitioner info
            if (widget.displayModel.practitionerNames.isNotEmpty) ...[
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Expanded(
                    child: Text(
                      widget.displayModel.practitionerNames.join(', '),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Organization info
            if (widget.displayModel.organizationName.isNotEmpty) ...[
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.business,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Expanded(
                    child: Text(
                      widget.displayModel.organizationName,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Location info
            if (widget.displayModel.locationNames.isNotEmpty) ...[
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Expanded(
                    child: Text(
                      widget.displayModel.locationNames.join(', '),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Date range
            if (_getFormattedDateRange() != null) ...[
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    _getFormattedDateRange()!,
                    style: context.textTheme.bodySmall?.copyWith(
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

  Widget _buildExpandButton(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, state) {
        final isLoadingRelated =
            state.recordDetailStatus == RecordDetailStatus.loading();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: Insets.small,
            horizontal: Insets.normal,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Icons (individually tappable)
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // TODO: Implement license draft notes functionality
                      print('License draft notes tapped');
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Assets.icons.licenseDraftNotes.svg(
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  InkWell(
                    onTap: () {
                      // TODO: Implement attachment functionality
                      print('Attachment tapped');
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Assets.icons.attachment.svg(
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  InkWell(
                    onTap: () {
                      // TODO: Implement share functionality
                      print('Share tapped');
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Assets.icons.share.svg(
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Right side: Text and loading indicator (with InkWell only here)
              InkWell(
                onTap: () {
                  final wasExpanded = _isExpanded;
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });

                  // Load related resources when expanding (going from collapsed to expanded)
                  if (!wasExpanded) {
                    context
                        .read<RecordsBloc>()
                        .add(RecordDetailLoaded(widget.displayModel.id));
                  }
                },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      if (isLoadingRelated)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Text(
                          _isExpanded ? 'Hide Related' : 'View Related',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (!isLoadingRelated) ...[
                        const SizedBox(width: Insets.extraSmall),
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRelatedResourcesSection(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, state) {
        if (state.recordDetailStatus == RecordDetailStatus.loading()) {
          return const Padding(
            padding: EdgeInsets.all(Insets.normal),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: Insets.small),
                  Text('Loading related resources...'),
                ],
              ),
            ),
          );
        }

        if (state.relatedResources.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Insets.normal),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 32,
                    color: context.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(height: Insets.small),
                  Text(
                    'No related resources found for this encounter',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(Insets.normal),
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Related Resources',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Insets.small),

              // Display related resources grouped by type
              ...state.relatedResources.entries.map((entry) {
                final resourceType = entry.key;
                final resources = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: Insets.small),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.extraSmall,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _getResourceTypeColor(resourceType).withAlpha(45),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getResourceTypeColor(resourceType),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          resourceType,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: _getResourceTypeColor(resourceType),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: Insets.small),
                      Expanded(
                        child: Text(
                          '${resources.length} ${resources.length == 1 ? 'item' : 'items'}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  String _getEncounterStatus() {
    final status = widget.displayModel.rawEncounter['status'] as String?;
    return status ?? '';
  }

  String? _getFormattedDateRange() {
    final startDate = widget.displayModel.startDate;
    final endDate = widget.displayModel.endDate;

    if (startDate == null) return null;

    try {
      final start = DateTime.parse(startDate);
      final startFormatted = DateFormat('MMM d, yyyy h:mm a').format(start);

      if (endDate != null) {
        final end = DateTime.parse(endDate);
        final endFormatted = DateFormat('MMM d, yyyy h:mm a').format(end);
        return '$startFormatted - $endFormatted';
      } else {
        return startFormatted;
      }
    } catch (_) {
      return startDate;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
        return Colors.green;
      case 'in-progress':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'planned':
        return Colors.orange;
      default:
        return Colors.grey;
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
      default:
        return Colors.grey;
    }
  }
}
