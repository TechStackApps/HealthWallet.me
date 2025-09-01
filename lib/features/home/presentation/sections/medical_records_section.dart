import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/presentation/widgets/reorderable_grid.dart';
import 'package:health_wallet/core/theme/app_insets.dart';

import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/shaking_card.dart';

class MedicalRecordsSection extends StatelessWidget {
  final List<OverviewCard> overviewCards;
  final bool editMode;
  final VoidCallback? onLongPressCard;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final void Function(OverviewCard card)? onTapCard;
  final GlobalKey? firstCardKey; // Add this for onboarding focus
  final FocusNode? firstCardFocusNode;

  const MedicalRecordsSection({
    super.key,
    required this.overviewCards,
    this.editMode = false,
    this.onLongPressCard,
    this.onReorder,
    this.onTapCard,
    this.firstCardKey,
    this.firstCardFocusNode,
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
      itemBuilder: (context, card, index) {
        final cardWidget =
            (index == 0 && firstCardFocusNode != null && !editMode)
                ? Focus(
                    focusNode: firstCardFocusNode!,
                    child: _buildOverviewCard(context, card, key: firstCardKey),
                  )
                : _buildOverviewCard(context, card);

        if (editMode) {
          return ShakingCard(
            isShaking: true,
            child: cardWidget,
          );
        } else {
          return ShakingCard(
            isShaking: false,
            child: GestureDetector(
              onTap: () => onTapCard?.call(card),
              onLongPress: onLongPressCard,
              child: cardWidget,
            ),
          );
        }
      },
    );
  }

  Widget _buildOverviewCard(BuildContext context, OverviewCard card,
      {Key? key}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: card.category.icon.svg(
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: Insets.small),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.category.display,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: Insets.small),
                      Text(
                        card.count,
                        style: AppTextStyle.titleSmall.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
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
