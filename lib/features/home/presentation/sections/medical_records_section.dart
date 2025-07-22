import 'package:flutter/material.dart';
import 'package:health_wallet/features/home/presentation/widgets/reorderable_grid.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/shaking_card.dart';

class MedicalRecordsSection extends StatelessWidget {
  final List<dynamic> overviewCards;
  final bool editMode;
  final VoidCallback? onLongPressCard;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final void Function(dynamic card)? onTapCard;

  const MedicalRecordsSection({
    super.key,
    required this.overviewCards,
    this.editMode = false,
    this.onLongPressCard,
    this.onReorder,
    this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableGrid<dynamic>(
      items: overviewCards,
      enabled: editMode,
      onReorder: onReorder ?? (a, b) {},
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2,
      itemBuilder: (context, card, index) => GestureDetector(
        onLongPress: onLongPressCard,
        child: ShakingCard(
          isShaking: editMode,
          child: GestureDetector(
            onTap: editMode ? null : () => onTapCard?.call(card),
            child: _buildOverviewCard(context, card),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, dynamic card) {
    final TextTheme textTheme = context.textTheme;
    Widget icon;

    // Map card titles to their corresponding icons
    switch (card.title) {
      case ClinicalDataTags.allergy:
        icon = Assets.icons.faceMask.svg();
        break;
      case ClinicalDataTags.medication:
        icon = Assets.icons.medication.svg();
        break;
      case ClinicalDataTags.condition:
        icon = Assets.icons.stethoscope.svg();
        break;
      case ClinicalDataTags.immunization:
        icon = Assets.icons.shield.svg();
        break;
      case ClinicalDataTags.labResult:
        icon = Assets.icons.lab.svg();
        break;
      case ClinicalDataTags.procedure:
        icon = Assets.icons.briefcaseProcedures.svg();
        break;
      case ClinicalDataTags.goal:
        icon = Assets.icons.improveRelevance.svg();
        break;
      case ClinicalDataTags.careTeam:
        icon = Assets.icons.eventsTeam.svg();
        break;
      case ClinicalDataTags.clinicalNotes:
        icon = Assets.icons.catalogNotes.svg();
        break;
      case ClinicalDataTags.files:
        icon = Assets.icons.documentFile.svg();
        break;
      case ClinicalDataTags.facilities:
        icon = Assets.icons.hospital.svg();
        break;
      case ClinicalDataTags.demographics:
        icon = Assets.icons.identification.svg();
        break;
      default:
        icon = const SizedBox.shrink();
    }
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16, height: 16, child: icon),
                const SizedBox(width: Insets.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.title,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      card.count,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
