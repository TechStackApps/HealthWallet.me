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
  final GlobalKey? firstCardKey; // First card key
  final FocusNode? firstCardFocusNode;
  final Map<String, bool>? selectedVitals; // Add this to check filter state

  const VitalsSection({
    super.key,
    required this.vitals,
    required this.allAvailableVitals,
    this.editMode = false,
    this.vitalsExpanded = false,
    this.onReorder,
    this.onLongPressCard,
    this.onExpandToggle,
    this.firstCardKey,
    this.firstCardFocusNode,
    this.selectedVitals,
  });

  @override
  Widget build(BuildContext context) {
    final vitalsToShow = vitalsExpanded ? allAvailableVitals : vitals;

    print('🔄 VitalsSection build:');
    print('🔄 Expansion state: $vitalsExpanded');
    print('🔄 Edit mode: $editMode');
    print('🔄 Vitals to show count: ${vitalsToShow.length}');
    print('🔄 All available vitals count: ${allAvailableVitals.length}');
    print('🔄 Filtered vitals count: ${vitals.length}');
    print(
        '🔄 Show expand button: ${allAvailableVitals.isNotEmpty && allAvailableVitals.length > vitals.length && (selectedVitals == null || selectedVitals!.entries.where((e) => e.value).length < allAvailableVitals.length)}');
    print(
        '🔄 Selected vitals count: ${selectedVitals?.entries.where((e) => e.value).length ?? 0}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReorderableGrid<PatientVital>(
          items: vitalsToShow,
          enabled: editMode,
          onReorder: (oldIndex, newIndex) {
            if (vitalsExpanded) {
              print('🔄 Reordering in EXPANDED mode: $oldIndex -> $newIndex');
              onReorder?.call(oldIndex, newIndex);
            } else {
              final vitalToMove = vitals[oldIndex];
              final oldMasterIndex = allAvailableVitals
                  .indexWhere((v) => v.title == vitalToMove.title);
              final newMasterIndex = allAvailableVitals
                  .indexWhere((v) => v.title == vitals[newIndex].title);

              print('🔄 Reordering in COLLAPSED mode: $oldIndex -> $newIndex');
              print('🔄 Vital to move: ${vitalToMove.title}');
              print('🔄 Master indices: $oldMasterIndex -> $newMasterIndex');

              if (oldMasterIndex != -1 && newMasterIndex != -1) {
                onReorder?.call(oldMasterIndex, newMasterIndex);
              } else {
                print('🚨 Failed to find master indices for reordering');
              }
            }
          },
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.85,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, vital, index) => GestureDetector(
            onLongPress: onLongPressCard,
            child: index == 0 && firstCardFocusNode != null
                ? Focus(
                    focusNode: firstCardFocusNode!,
                    child:
                        _buildVitalSignCard(context, vital, key: firstCardKey),
                  )
                : _buildVitalSignCard(context, vital),
          ),
        ),
        if (allAvailableVitals.isNotEmpty &&
            (selectedVitals == null ||
                selectedVitals!.entries.where((e) => e.value).length <
                    allAvailableVitals.length))
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

  Widget _buildVitalSignCard(BuildContext context, PatientVital vital,
      {Key? key}) {
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
        icon = Assets.icons.bloodGlucose.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Respiratory Rate':
        icon = Assets.icons.alarm.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Weight':
        icon = Assets.icons.weight.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'Height':
        icon = Assets.icons.rulerHeight.svg(
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        );
        break;
      case 'BMI':
        icon = Assets.icons.bmi.svg(
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
      key: key,
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
