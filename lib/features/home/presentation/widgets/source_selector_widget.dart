import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';

class SourceSelectorWidget extends StatelessWidget {
  final List<Source> sources;
  final String? selectedSource;
  final Function(String) onSourceChanged;
  final Patient? currentPatient;
  final Function(Source)? onSourceTap;

  const SourceSelectorWidget({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSourceChanged,
    this.currentPatient,
    this.onSourceTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final patientSources = _getPatientSources();

    if (patientSources.isEmpty) {
      return const SizedBox.shrink();
    } else if (patientSources.length == 1) {
      // Single source for patient - show as tappable text
      final source = patientSources.first;
      return Container(
        constraints: const BoxConstraints(maxWidth: 150),
        child: InkWell(
          onTap: () => onSourceTap?.call(source),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Source: ',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Flexible(
                  child: Text(
                    _getSourceDisplayName(source),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Multiple sources per patient - show dropdown
      return Container(
        constraints: const BoxConstraints(maxWidth: 150),
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
            Flexible(
              child: DropdownButton<String>(
                value: selectedSource ?? _getDefaultSourceId(),
                isExpanded: false,
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

  /// Get the display name for a source (labelSource > name > id)
  String _getSourceDisplayName(Source source) {
    if (source.labelSource?.isNotEmpty == true) {
      return source.labelSource!;
    }
    if (source.name?.isNotEmpty == true) {
      return source.name!;
    }
    // If source ID is too long, don't display it
    if (source.id.length > 20) {
      return 'Unknown Source';
    }
    return source.id;
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
          _getSourceDisplayName(source),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textTheme.bodySmall,
        ),
      );
    }).toList();

    if (patientSources.length > 1) {
      sourceItems.insert(
        0,
        DropdownMenuItem<String>(
          value: 'All',
          child: Text(
            'All',
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
