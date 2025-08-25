import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';

class SourceSelectorWidget extends StatelessWidget {
  final List<Source> sources;
  final String? selectedSource;
  final Function(String) onSourceChanged;
  final Patient? currentPatient; // Add current patient parameter

  const SourceSelectorWidget({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSourceChanged,
    this.currentPatient, // Make it optional but available
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    // Get sources for the current patient based on patient's sourceId
    final patientSources = _getPatientSources();

    if (patientSources.isEmpty) {
      return const SizedBox.shrink();
    } else if (patientSources.length == 1) {
      // Single source for patient - show as text
      final source = patientSources.first;
      return Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Source: ',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Expanded(
              child: Text(
                source.name?.isNotEmpty == true ? source.name! : source.id,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      );
    } else {
      // Multiple sources per patient - show dropdown
      return Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.homeSource,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: Insets.small),
            Expanded(
              child: DropdownButton<String>(
                value: selectedSource ?? _getDefaultSourceId(),
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onSourceChanged(newValue);
                  }
                },
                items: _buildDropdownItems(patientSources, textTheme),
              ),
            ),
          ],
        ),
      );
    }
  }

  /// Get sources for the current patient based on patient's sourceId
  List<Source> _getPatientSources() {
    if (currentPatient == null || currentPatient!.sourceId.isEmpty) {
      // If no patient or no sourceId, return all sources
      return sources.where((source) => source.id != 'All').toList();
    }

    // Filter sources to only include the current patient's source
    return sources
        .where((source) => source.id == currentPatient!.sourceId)
        .toList();
  }

  /// Get the default source ID for the dropdown
  String _getDefaultSourceId() {
    if (currentPatient != null && currentPatient!.sourceId.isNotEmpty) {
      // Use patient's sourceId as default
      return currentPatient!.sourceId;
    }

    // Fallback to 'All' if no patient source
    final patientSources = _getPatientSources();
    if (patientSources.isNotEmpty) {
      return patientSources.first.id;
    }

    return 'All';
  }

  /// Build dropdown items for multiple sources
  List<DropdownMenuItem<String>> _buildDropdownItems(
    List<Source> patientSources,
    TextTheme textTheme,
  ) {
    // Create dropdown items for each patient source
    final sourceItems = patientSources.map((source) {
      return DropdownMenuItem<String>(
        value: source.id,
        child: Text(
          source.name?.isNotEmpty == true ? source.name! : source.id,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.bodySmall,
        ),
      );
    }).toList();

    // Add "All" option at the top if there are multiple sources
    if (patientSources.length > 1) {
      sourceItems.insert(
        0,
        DropdownMenuItem<String>(
          value: 'All',
          child: Text(
            'All', // Use hardcoded text since context is not available here
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textTheme.bodySmall,
          ),
        ),
      );
    }

    return sourceItems;
  }
}
