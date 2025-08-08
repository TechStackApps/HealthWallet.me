import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/widgets/reorderable_grid.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class VitalsSection extends StatelessWidget {
  final List<dynamic> vitals;
  final bool editMode;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final VoidCallback? onLongPressCard;

  const VitalsSection({
    super.key,
    required this.vitals,
    this.editMode = false,
    this.onReorder,
    this.onLongPressCard,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableGrid<dynamic>(
      items: vitals,
      enabled: editMode,
      onReorder: onReorder ?? (a, b) {},
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      itemBuilder: (context, vital, index) => GestureDetector(
        onLongPress: onLongPressCard,
        child: _buildVitalSignCard(context, vital),
      ),
    );
  }

  Widget _buildVitalSignCard(BuildContext context, dynamic vital) {
    final String title = vital.title;
    final String value = vital.value;
    final String unit = vital.unit;
    final String status = vital.status;

    // Get icon based on vital type
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
      default:
        icon = const SizedBox.shrink();
    }

    // Get card color and status icon based on status
    Color cardColor;
    Widget statusIcon;
    Color statusIconColor;

    switch (status) {
      case 'Normal':
        cardColor = context.isDarkMode
            ? AppColors.successDark.withOpacity(0.08)
            : AppColors.success.withOpacity(0.08);
        statusIconColor = AppColors.success;
        statusIcon = Assets.icons.checkmarkCircleOutline.svg(
          colorFilter: ColorFilter.mode(statusIconColor, BlendMode.srcIn),
        );
        break;
      case 'High':
      case 'Low':
        cardColor = context.isDarkMode
            ? AppColors.errorDark.withOpacity(0.08)
            : AppColors.error.withOpacity(0.08);
        statusIconColor = AppColors.error;
        statusIcon = Assets.icons.warning.svg(
          colorFilter: ColorFilter.mode(statusIconColor, BlendMode.srcIn),
        );
        break;
      default:
        cardColor = context.colorScheme.surface;
        statusIconColor = AppColors.warning;
        statusIcon = Assets.icons.warning.svg(
          colorFilter: ColorFilter.mode(statusIconColor, BlendMode.srcIn),
        );
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
                    style: AppTextStyle.bodySmall.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                statusIcon,
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppTextStyle.titleSmall.copyWith(
                    color: context.colorScheme.onSurface,
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
