import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class RecentRecordsSection extends StatelessWidget {
  final List<dynamic> recentRecords;
  final VoidCallback? onViewAll;
  final void Function(dynamic record)? onTapRecord;

  const RecentRecordsSection({
    super.key,
    required this.recentRecords,
    this.onViewAll,
    this.onTapRecord,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.homeRecentRecords,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                context.l10n.homeViewAll,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Insets.smallNormal),
        ...recentRecords
            .map((record) => _buildRecentRecordCard(context, record)),
      ],
    );
  }

  Widget _buildRecentRecordCard(BuildContext context, dynamic record) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final resourceJson = record.resourceJson;
    final title = resourceJson['code']?['text'] ??
        resourceJson['vaccineCode']?['text'] ??
        record.resourceType;
    final doctor = resourceJson['recorder']?['display'] ?? context.l10n.homeNA;
    final date = record.updatedAt.toString();
    final tag = record.resourceType;
    return GestureDetector(
      onTap: () => onTapRecord?.call(record),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.small,
                      vertical: Insets.extraSmall,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    doctor,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    date,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
