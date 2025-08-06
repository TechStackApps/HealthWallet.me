import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/pages/record_detail_page.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:get_it/get_it.dart';

class EncounterCard extends StatefulWidget {
  final IFhirResource encounter;

  const EncounterCard({super.key, required this.encounter});

  @override
  State<EncounterCard> createState() => _EncounterCardState();
}

class _EncounterCardState extends State<EncounterCard> {
  bool _isExpanded = false;
  final Map<String, String> _resolvedNames = {};

  @override
  Widget build(BuildContext context) {
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
    final encounter = widget.encounter as Encounter;

    return InkWell(
      onTap: () {
        // Navigate to encounter detail page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecordDetailPage(resource: widget.encounter),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encounter type and status
          Text(
            _getEncounterTitle(encounter),
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Date
          if (encounter.date != null) ...[
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(encounter.date!),
                  style: AppTextStyle.labelLarge.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Practitioner info
          if (encounter.participant?.isNotEmpty == true) ...[
            Row(
              children: [
                Assets.icons.user.svg(width: 16),
                const SizedBox(width: Insets.smaller),
                Expanded(
                  child: Text(
                    _getParticipantNames(encounter),
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Organization info
          if (encounter.serviceProvider != null) ...[
            Row(
              children: [
                Assets.icons.hospital.svg(width: 16),
                const SizedBox(width: Insets.smaller),
                Expanded(
                  child: Text(
                    _getServiceProviderName(encounter),
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpandButton(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordsState>(
      builder: (context, state) {
        final isLoadingRelated =
            state.recordDetailStatus == RecordDetailStatus.loading();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                      .add(RecordDetailLoaded(widget.encounter.resourceId));
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
                        style: AppTextStyle.bodySmall,
                      ),
                    if (!isLoadingRelated) ...[
                      const SizedBox(width: Insets.extraSmall),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.chevron_right,
                        size: 16,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // TODO: Implement license draft notes functionality
                    print('License draft notes tapped');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.licenseDraftNotes.svg(
                      width: 24,
                    ),
                  ),
                ),
                const SizedBox(width: Insets.normal),
                InkWell(
                  onTap: () {
                    // TODO: Implement attachment functionality
                    print('Attachment tapped');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.attachment.svg(width: 24),
                  ),
                ),
                const SizedBox(width: Insets.normal),
                InkWell(
                  onTap: () {
                    // TODO: Implement share functionality
                    print('Share tapped');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Assets.icons.share.svg(width: 24),
                  ),
                ),
              ],
            ),
          ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Insets.extraSmall,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getResourceTypeColor(resourceType)
                                  .withAlpha(45),
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
                      const SizedBox(height: Insets.extraSmall),
                      // Display individual resources
                      ...resources
                          .map((resource) => Padding(
                                padding: const EdgeInsets.only(
                                    left: Insets.small, bottom: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color:
                                            _getResourceTypeColor(resourceType),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: Insets.extraSmall),
                                    Expanded(
                                      child: Text(
                                        resource.primaryDisplay,
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
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

  // Helper methods for extracting FHIR R4 data
  String _getEncounterTitle(Encounter encounter) {
    // Use the title field directly if available
    if (encounter.title.isNotEmpty) {
      return encounter.title;
    }

    // Fallback to encounter type or status
    if (encounter.type?.isNotEmpty == true) {
      final firstType = encounter.type!.first;
      return firstType.text?.valueString ??
          firstType.coding?.firstOrNull?.display?.valueString ??
          'Encounter';
    }

    return 'Encounter';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _getParticipantNames(Encounter encounter) {
    if (encounter.participant?.isEmpty ?? true) {
      return 'No participants';
    }

    // Get the first participant's name (most common case)
    final firstParticipant = encounter.participant!.first;
    if (firstParticipant.individual?.reference?.valueString != null) {
      final reference = firstParticipant.individual!.reference!.valueString!;

      // Check if we already resolved this reference
      if (_resolvedNames.containsKey(reference)) {
        return _resolvedNames[reference]!;
      } else {
        // Resolve the reference asynchronously
        _resolveReference(reference);

        // Show fallback while resolving
        if (reference.contains('/')) {
          final parts = reference.split('/');
          return parts.length >= 2 ? parts[parts.length - 2] : 'Participant';
        }
        return 'Practitioner';
      }
    }

    return 'No participants';
  }

  String _getServiceProviderName(Encounter encounter) {
    if (encounter.serviceProvider?.reference?.valueString != null) {
      final reference = encounter.serviceProvider!.reference!.valueString!;

      // Check if we already resolved this reference
      if (_resolvedNames.containsKey(reference)) {
        return _resolvedNames[reference]!;
      } else {
        // Resolve the reference asynchronously
        _resolveReference(reference);

        // Show fallback while resolving
        if (reference.contains('/')) {
          final parts = reference.split('/');
          return parts.length >= 2 ? parts[parts.length - 2] : 'Organization';
        }
        return 'Organization';
      }
    }
    return 'No organization';
  }

  Future<void> _resolveReference(String reference) async {
    try {
      // Get the repository through dependency injection
      final repository = GetIt.instance<RecordsRepository>();
      final displayName = await repository.getReferenceDisplayName(reference);

      if (displayName != null && mounted) {
        setState(() {
          _resolvedNames[reference] = displayName;
        });
      }
    } catch (e) {
      // Handle error silently
    }
  }

  /// Get color for resource type
  Color _getResourceTypeColor(String resourceType) {
    switch (resourceType.toLowerCase()) {
      case 'observation':
        return Colors.blue;
      case 'procedure':
        return Colors.green;
      case 'medicationrequest':
        return Colors.orange;
      case 'diagnosticreport':
        return Colors.purple;
      case 'immunization':
        return Colors.teal;
      case 'servicerequest':
        return Colors.indigo;
      case 'media':
        return Colors.pink;
      case 'adverseevent':
        return Colors.red;
      case 'careteam':
        return Colors.cyan;
      case 'condition':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
