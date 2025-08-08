import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class RecentRecordsSection extends StatelessWidget {
  final List<IFhirResource> recentRecords;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...recentRecords
            .map((record) => _buildRecentRecordCard(context, record)),
      ],
    );
  }

  Widget _buildRecentRecordCard(BuildContext context, IFhirResource record) {
    final title = record.title;
    final date = record.date.toString();
    final tag = record.fhirType.display;

    // Get icon based on resource type
    Widget icon;
    switch (record.fhirType) {
      case FhirType.Medication:
      case FhirType.MedicationRequest:
      case FhirType.MedicationStatement:
        icon = Assets.icons.medication.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case FhirType.Immunization:
        icon = Assets.icons.shield.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case FhirType.CareTeam:
        icon = Assets.icons.eventsTeam.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      default:
        icon = Assets.icons.documentFile.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
    }

    return GestureDetector(
      onTap: () => onTapRecord?.call(record),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.theme.dividerColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                context.colorScheme.onSurface.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: icon,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tag,
                                style: AppTextStyle.labelSmall.copyWith(
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Completed',
                    style: AppTextStyle.labelMedium.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Assets.icons.user.svg(
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Dr. Sarah Johnson',
                        style: AppTextStyle.labelLarge.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Assets.icons.calendar.svg(
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
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
