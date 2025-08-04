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
    final TextTheme textTheme = context.textTheme;
    Color cardColor;
    Widget statusIcon;
    Widget icon;
    final String title = vital.title;
    final String value = vital.value;
    final String unit = vital.unit;
    final String status = vital.status;

    switch (title) {
      case 'Heart Rate':
        icon = Assets.icons.heartFavorite.svg();
        break;
      case 'Blood Pressure':
        icon = Assets.icons.drop.svg();
        break;
      case 'Temperature':
        icon = Assets.icons.temperature.svg();
        break;
      case 'Blood Oxygen':
        icon = Assets.icons.activity.svg();
        break;
      default:
        icon = const SizedBox.shrink();
    }

    switch (status) {
      case 'Normal':
        cardColor = AppColors.success.withAlpha(25);
        statusIcon =
            Assets.icons.checkmarkCircleOutline.svg(width: 18, height: 18);
        break;
      case 'High':
      case 'Low':
        cardColor = AppColors.warning.withAlpha(25);
        statusIcon = Assets.icons.warning.svg(width: 18, height: 18);
        break;
      default:
        cardColor = Theme.of(context).colorScheme.surface;
        statusIcon = const SizedBox.shrink();
    }

    return Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
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
                Text(title, style: AppTextStyle.bodySmall),
                const Spacer(),
                statusIcon,
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: AppTextStyle.titleLarge,
                ),
                const SizedBox(width: Insets.extraSmall),
                Text(
                  unit,
                  style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
