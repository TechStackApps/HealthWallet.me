import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/home/presentation/widgets/source_list_dialog.dart';
import 'package:health_wallet/features/home/presentation/widgets/source_label_edit_dialog.dart';

class SourceSelectorWidget extends StatelessWidget {
  final List<Source> sources;
  final String? selectedSource;
  final Function(String) onSourceChanged;
  final Patient? currentPatient;
  final Function(Source)? onSourceTap;
  final Function(Source)? onSourceLabelEdit;
  final Function(Source)? onSourceDelete;

  const SourceSelectorWidget({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSourceChanged,
    this.currentPatient,
    this.onSourceTap,
    this.onSourceLabelEdit,
    this.onSourceDelete,
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
          onTap: () => _showSourceListDialog(context),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${context.l10n.source}: ',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Flexible(
                  child: Text(
                    _getSourceDisplayName(context, source),
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
      // Multiple sources per patient - show tappable text that opens dialog
      return Container(
        constraints: const BoxConstraints(maxWidth: 150),
        child: InkWell(
          onTap: () => _showSourceListDialog(context),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                  child: Text(
                    _getSelectedSourceDisplayName(context),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  /// Get the display name for a source (labelSource > name > id)
  String _getSourceDisplayName(BuildContext context, Source source) {
    if (source.labelSource?.isNotEmpty == true) {
      return source.labelSource!;
    }
    if (source.name?.isNotEmpty == true) {
      return source.name!;
    }
    // If source ID is too long, don't display it
    if (source.id.length > 20) {
      return context.l10n.unknownSource;
    }
    return source.id;
  }

  /// Get sources for the current patient based on patient's sourceId
  List<Source> _getPatientSources() {
    // Always return all sources (excluding 'All') regardless of patient selection
    final allSources = sources.where((source) => source.id != 'All').toList();

    // Sort to put Wallet first, then others
    allSources.sort((a, b) {
      if (a.id == 'wallet') return -1;
      if (b.id == 'wallet') return 1;
      return a.id.compareTo(b.id);
    });

    return allSources;
  }

  /// Show source list dialog
  void _showSourceListDialog(BuildContext context) {
    final patientSources = _getPatientSources();

    SourceListDialog.show(
      context,
      patientSources,
      selectedSource,
      (source) {
        // Change the source
        onSourceChanged(source.id);
      },
      onSourceEdit: onSourceLabelEdit != null
          ? (source) {
              SourceLabelEditDialog.show(
                context,
                source,
                (newLabel) {
                  onSourceLabelEdit!(source);
                  // Close the source list dialog after successful edit
                  Navigator.of(context).pop();
                },
              );
            }
          : null,
      onSourceDelete: onSourceDelete,
    );
  }

  /// Get the display name for the currently selected source
  String _getSelectedSourceDisplayName(BuildContext context) {
    final patientSources = _getPatientSources();
    final currentSource = patientSources.firstWhere(
      (source) => source.id == selectedSource,
      orElse: () =>
          patientSources.isNotEmpty ? patientSources.first : Source(id: 'All'),
    );

    if (selectedSource == 'All') {
      return 'All';
    }

    return _getSourceDisplayName(context, currentSource);
  }
}
