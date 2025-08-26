import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? filterLabel;
  final VoidCallback? onFilterTap;
  final Widget? trailing;
  final ColorScheme colorScheme;
  final VoidCallback? onTap;
  final Widget? subtitle;
  final bool showDivider;
  final bool isEditMode;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.filterLabel,
    this.onFilterTap,
    this.trailing,
    required this.colorScheme,
    this.onTap,
    this.subtitle,
    this.showDivider = false,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null && !isEditMode) ...[
                    const SizedBox(width: 16),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (isEditMode && filterLabel != null && onFilterTap != null)
              InkWell(
                onTap: onFilterTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.filter.svg(
                        colorFilter: ColorFilter.mode(
                          colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        filterLabel!,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (trailing != null)
              trailing!
            else
              const SizedBox.shrink(),
          ],
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Divider(
              color: colorScheme.outline.withValues(alpha: 0.2),
              height: 1,
            ),
          ),
      ],
    );
  }
}
