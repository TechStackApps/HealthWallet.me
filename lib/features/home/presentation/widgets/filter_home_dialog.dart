import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

enum FilterHomeType { records, vitals }

class FilterHomeDialog extends StatefulWidget {
  final FilterHomeType type;
  final Map<HomeRecordsCategory, bool>? selectedRecords;
  final Map<PatientVitalType, bool>? selectedVitals;
  final void Function(Map<HomeRecordsCategory, bool>)? onRecordsSaved;
  final void Function(Map<PatientVitalType, bool>)? onVitalsSaved;
  final List<HomeRecordsCategory>? orderedRecords;
  final List<PatientVitalType>? orderedVitals;

  const FilterHomeDialog({
    super.key,
    required this.type,
    this.selectedRecords,
    this.selectedVitals,
    this.onRecordsSaved,
    this.onVitalsSaved,
    this.orderedRecords,
    this.orderedVitals,
  });

  @override
  State<FilterHomeDialog> createState() => _FilterHomeDialogState();
}

class _FilterHomeDialogState extends State<FilterHomeDialog> {
  late Map<HomeRecordsCategory, bool> _tempSelectedRecords;
  late Map<PatientVitalType, bool> _tempSelectedVitals;

  @override
  void initState() {
    super.initState();
    _tempSelectedRecords = Map.from(widget.selectedRecords ?? {});
    _tempSelectedVitals = Map.from(widget.selectedVitals ?? {});
  }

  @override
  Widget build(BuildContext context) {
    final isRecords = widget.type == FilterHomeType.records;
    final borderColor = Theme.of(context).dividerColor;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(Insets.medium),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.normal,
                  vertical: Insets.small,
                ),
                child: DefaultTextStyle(
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: _buildHeader(isRecords: isRecords),
                ),
              ),
              Divider(height: 1, color: borderColor),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.normal,
                      vertical: Insets.small,
                    ),
                    child: DefaultTextStyle(
                      style: AppTextStyle.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: isRecords ? _buildRecords() : _buildVitals(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.normal,
                  vertical: Insets.small,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyle.labelLarge.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: Insets.small),
                    TextButton(
                      onPressed: () {
                        if (isRecords && widget.onRecordsSaved != null) {
                          widget.onRecordsSaved!(_tempSelectedRecords);
                        } else if (!isRecords && widget.onVitalsSaved != null) {
                          widget.onVitalsSaved!(_tempSelectedVitals);
                        }
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Save',
                        style: AppTextStyle.labelLarge.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({required bool isRecords}) {
    return Row(
      children: [
        Text(isRecords ? 'Records' : 'Vitals', style: AppTextStyle.bodyMedium),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              if (isRecords) {
                final keys =
                    widget.orderedRecords ?? _tempSelectedRecords.keys.toList();
                for (final key in keys) {
                  _tempSelectedRecords[key] = true;
                }
              } else {
                final keys =
                    widget.orderedVitals ?? _tempSelectedVitals.keys.toList();
                for (final key in keys) {
                  _tempSelectedVitals[key] = true;
                }
              }
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Select all',
            style: AppTextStyle.labelLarge.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: Insets.small),
        TextButton(
          onPressed: () {
            setState(() {
              if (isRecords) {
                final keys =
                    widget.orderedRecords ?? _tempSelectedRecords.keys.toList();
                for (final key in keys) {
                  _tempSelectedRecords[key] = false;
                }
              } else {
                final keys =
                    widget.orderedVitals ?? _tempSelectedVitals.keys.toList();
                for (final key in keys) {
                  _tempSelectedVitals[key] = false;
                }
              }
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.primary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Clear all',
            style: AppTextStyle.labelLarge.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRecords() {
    final categories = widget.orderedRecords ?? HomeRecordsCategory.values;
    return categories.map((category) {
      return CheckboxListTile(
        title: Text(
          category.display,
          style: AppTextStyle.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        value: _tempSelectedRecords[category] ?? false,
        onChanged: (bool? value) {
          setState(() {
            _tempSelectedRecords[category] = value ?? false;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildVitals() {
    final types = (widget.orderedVitals ?? _tempSelectedVitals.keys.toList());
    return types.map((type) {
      return CheckboxListTile(
        title: Text(
          type.title,
          style: AppTextStyle.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        value: _tempSelectedVitals[type] ?? true,
        onChanged: (bool? value) {
          setState(() {
            _tempSelectedVitals[type] = value ?? true;
          });
        },
      );
    }).toList();
  }
}
