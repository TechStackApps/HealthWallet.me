import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';

class SourceSelectorWidget extends StatelessWidget {
  final List<Source> sources;
  final String? selectedSource;
  final Function(String) onSourceChanged;

  const SourceSelectorWidget({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSourceChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    // Get all sources for the current patient (filter out any 'All' placeholder)
    final patientSources =
        sources.where((source) => source.id != 'All').toList();

    if (patientSources.isEmpty) {
      return const SizedBox.shrink();
    } else if (patientSources.length == 1) {
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
                patientSources.first.name?.isNotEmpty == true
                    ? patientSources.first.name!
                    : patientSources.first.id,
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
      // Multiple sources per patient - show dropdown with "All" option
      // (This case won't happen for your patients since they each have only 1 source)
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
                value: selectedSource ?? 'All', // Default to 'All' if not set
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onSourceChanged(newValue);
                  }
                },
                items: () {
                  // Create dropdown items for each source
                  final sourceItems = patientSources.map((source) {
                    return DropdownMenuItem<String>(
                      value: source.id,
                      child: Text(
                        source.name?.isNotEmpty == true
                            ? source.name!
                            : source.id,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodySmall,
                      ),
                    );
                  }).toList();

                  // Add "All" option at the top
                  sourceItems.insert(
                    0,
                    DropdownMenuItem<String>(
                      value: 'All',
                      child: Text(
                        context.l10n.homeAll,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  );

                  return sourceItems;
                }(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
