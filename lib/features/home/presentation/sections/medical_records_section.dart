import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/presentation/widgets/reorderable_grid.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/shaking_card.dart';

class MedicalRecordsSection extends StatelessWidget {
  final List<OverviewCard> overviewCards;
  final bool editMode;
  final VoidCallback? onLongPressCard;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final void Function(OverviewCard card)? onTapCard;

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
    return ReorderableGrid<OverviewCard>(
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

  Widget _buildOverviewCard(BuildContext context, OverviewCard card) {
    final TextTheme textTheme = context.textTheme;

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
                SizedBox(
                    width: 16, height: 16, child: card.category.icon.svg()),
                const SizedBox(width: Insets.small),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.category.display,
                      style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: Insets.small),
                    Text(
                      card.count,
                      style: AppTextStyle.titleSmall,
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
