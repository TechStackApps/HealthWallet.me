import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/widgets/delete_confirmation_dialog.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class SourceListDialog extends StatefulWidget {
  final List<Source> sources;
  final String? selectedSource;
  final Function(Source) onSourceSelected;
  final Function(Source)? onSourceEdit;
  final Function(Source)? onSourceDelete;

  const SourceListDialog({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSourceSelected,
    this.onSourceEdit,
    this.onSourceDelete,
  });

  static void show(
    BuildContext context,
    List<Source> sources,
    String? selectedSource,
    Function(Source) onSourceSelected, {
    Function(Source)? onSourceEdit,
    Function(Source)? onSourceDelete,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SourceListDialog(
            sources: sources,
            selectedSource: selectedSource,
            onSourceSelected: onSourceSelected,
            onSourceEdit: onSourceEdit,
            onSourceDelete: onSourceDelete,
          ),
        );
      },
    );
  }

  @override
  State<SourceListDialog> createState() => _SourceListDialogState();
}

class _SourceListDialogState extends State<SourceListDialog> {
  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final iconColor = context.isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(Insets.medium),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Insets.normal, vertical: Insets.small),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)),
                        child: IconButton(
                          icon: Assets.icons.settings.svg(
                            colorFilter:
                                ColorFilter.mode(textColor, BlendMode.srcIn),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: Insets.small),
                      Text('Sources',
                          style: AppTextStyle.bodySmall
                              .copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: IconButton(
                      icon: Assets.icons.close.svg(
                        colorFilter:
                            ColorFilter.mode(textColor, BlendMode.srcIn),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: borderColor),
            // Content
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: Insets.small),
                itemCount: widget.sources.length,
                itemBuilder: (context, index) {
                  final source = widget.sources[index];
                  final isSelected = source.id == widget.selectedSource;
                  final isWallet = source.id == 'wallet';

                  return InkWell(
                    onTap: () {
                      widget.onSourceSelected(source);
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: Insets.small),
                      padding:
                          const EdgeInsets.symmetric(vertical: Insets.small),
                      child: Row(
                        children: [
                          // Source icon
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              isWallet
                                  ? Icons.account_balance_wallet
                                  : Icons.source,
                              size: 16,
                              color: isSelected
                                  ? context.colorScheme.primary
                                  : iconColor,
                            ),
                          ),
                          const SizedBox(width: Insets.small),
                          // Source info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getSourceDisplayName(context, source),
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? context.colorScheme.primary
                                        : textColor,
                                  ),
                                ),
                                if (source.id != 'wallet')
                                  Text(
                                    source.id,
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: iconColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Action buttons
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit button
                              if (widget.onSourceEdit != null && !isWallet)
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.onSourceEdit!(source);
                                    },
                                    child: Assets.icons.edit.svg(
                                      width: 20,
                                      color: context.theme.iconTheme.color ??
                                          context.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              // Delete button
                              if (widget.onSourceDelete != null &&
                                  !isWallet) ...[
                                const SizedBox(width: 16),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: GestureDetector(
                                    onTap: () => _showDeleteConfirmationDialog(
                                        context, source),
                                    child: Assets.icons.trashCan.svg(
                                      width: 20,
                                      color: context.theme.iconTheme.color ??
                                          context.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get the display name for a source (labelSource > name > id)
  String _getSourceDisplayName(BuildContext context, Source source) {
    if (source.labelSource?.isNotEmpty == true) {
      return source.labelSource!;
    }
    if (source.name?.isNotEmpty == true) {
      return source.name!;
    }
    // If source ID is too long, don't display it
    if (source.id.length > 20) {
      return context.l10n.unknownSource;
    }
    return source.id;
  }

  void _showDeleteConfirmationDialog(BuildContext context, Source source) {
    DeleteConfirmationDialog.show(
      context: context,
      title:
          'Are you sure you want to delete "${_getSourceDisplayName(context, source)}"?',
      onConfirm: () {
        widget.onSourceDelete!(source);
        Navigator.of(context).pop(); // Close the source list dialog too
      },
    );
  }
}
