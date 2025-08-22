import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/widgets/reorderable_grid.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';

class VitalsSection extends StatelessWidget {
  final List<PatientVital> vitals;
  final List<PatientVital> allAvailableVitals;
  final bool editMode;
  final bool vitalsExpanded;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final VoidCallback? onLongPressCard;
  final VoidCallback? onExpandToggle;

  const VitalsSection({
    super.key,
    required this.vitals,
    required this.allAvailableVitals,
    this.editMode = false,
    this.vitalsExpanded = false,
    this.onReorder,
    this.onLongPressCard,
    this.onExpandToggle,
  });

  @override
  Widget build(BuildContext context) {
    final vitalsToShow = vitalsExpanded ? allAvailableVitals : vitals;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vitals Grid
        ReorderableGrid<PatientVital>(
          items: vitalsToShow,
          enabled: editMode,
          onReorder: onReorder ?? (a, b) {},
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.85,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, vital, index) => GestureDetector(
            onLongPress: onLongPressCard,
            child: _buildVitalSignCard(context, vital),
          ),
        ),

        if (allAvailableVitals.isNotEmpty &&
            allAvailableVitals.length > vitals.length)
          Padding(
            padding: const EdgeInsets.only(top: Insets.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: onExpandToggle,
                  icon: Icon(
                    vitalsExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                    color: context.colorScheme.primary,
                  ),
                  label: Text(
                    vitalsExpanded ? 'Show Less' : 'Show All',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.small,
                      vertical: Insets.extraSmall,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildVitalSignCard(BuildContext context, PatientVital vital) {
    final String title = vital.title;
    final String value = vital.value;
    final String unit = vital.unit;
    final String? status = vital.status;

    Widget icon;
    switch (title) {
      case 'Heart Rate':
        icon = Assets.icons.heartFavorite.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Blood Pressure':
        icon = Assets.icons.drop.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Temperature':
        icon = Assets.icons.temperature.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Blood Oxygen':
        icon = Assets.icons.activity.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Blood Glucose':
        icon = Assets.icons.drop.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      default:
        icon = const SizedBox.shrink();
    }

    Color cardColor = context.colorScheme.surface;
    Widget? statusIcon;
    Color? statusIconColor;

    if (status != null && status.isNotEmpty) {
      switch (status) {
        case 'Normal':
          cardColor = context.isDarkMode
              ? AppColors.successDark.withOpacity(0.08)
              : AppColors.success.withOpacity(0.08);
          statusIconColor = AppColors.success;
          statusIcon = Assets.icons.checkmarkCircleOutline.svg(
            colorFilter: ColorFilter.mode(statusIconColor!, BlendMode.srcIn),
          );
          break;
        case 'High':
        case 'Low':
          cardColor = context.isDarkMode
              ? AppColors.errorDark.withOpacity(0.08)
              : AppColors.error.withOpacity(0.08);
          statusIconColor = AppColors.error;
          statusIcon = Assets.icons.warning.svg(
            colorFilter: ColorFilter.mode(statusIconColor!, BlendMode.srcIn),
          );
          break;
        case 'Abnormal':
        case 'Critically Abnormal':
        case 'Critically High':
        case 'Critically Low':
          cardColor = context.isDarkMode
              ? AppColors.errorDark.withOpacity(0.12)
              : AppColors.error.withOpacity(0.12);
          statusIconColor = AppColors.error;
          statusIcon = Assets.icons.warning.svg(
            colorFilter: ColorFilter.mode(statusIconColor!, BlendMode.srcIn),
          );
          break;
        case 'Uncertain':
        case 'Intermediate':
          cardColor = context.isDarkMode
              ? AppColors.warningDark.withOpacity(0.08)
              : AppColors.warning.withOpacity(0.08);
          statusIconColor = AppColors.warning;
          statusIcon = Assets.icons.warning.svg(
            colorFilter: ColorFilter.mode(statusIconColor!, BlendMode.srcIn),
          );
          break;
        default:
          cardColor = context.colorScheme.surface;
          statusIcon = null;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
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
              children: [
                SizedBox(height: 16, width: 16, child: icon),
                const SizedBox(width: Insets.smaller),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (statusIcon != null) statusIcon,
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.titleSmall.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
