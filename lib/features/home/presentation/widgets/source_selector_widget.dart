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

    final actualSources =
        sources.where((source) => source.id != 'All').toList();

    if (actualSources.length == 1) {
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
                actualSources.first.id,
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
    } else if (actualSources.length > 1) {
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
                value: selectedSource,
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onSourceChanged(newValue);
                  }
                },
                items: () {
                  final sourceItems = actualSources.map((source) {
                    return DropdownMenuItem<String>(
                      value: source.id,
                      child: Text(
                        source.id,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodySmall,
                      ),
                    );
                  }).toList();

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
    } else {
      return const SizedBox.shrink();
    }
  }
}
