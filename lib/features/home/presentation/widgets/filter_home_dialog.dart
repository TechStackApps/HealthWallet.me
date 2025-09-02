import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_color.dart';
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
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _tempSelectedRecords = Map.from(widget.selectedRecords ?? {});
    _tempSelectedVitals = Map.from(widget.selectedVitals ?? {});
  }

  bool _canSave() {
    if (widget.type == FilterHomeType.records) {
      return _tempSelectedRecords.values.any((isSelected) => isSelected);
    } else {
      return _tempSelectedVitals.values.any((isSelected) => isSelected);
    }
  }

  void _selectAll() {
    setState(() {
      if (widget.type == FilterHomeType.records) {
        final keys =
            widget.orderedRecords ?? _tempSelectedRecords.keys.toList();
        for (final key in keys) {
          _tempSelectedRecords[key] = true;
        }
      } else {
        final keys = widget.orderedVitals ?? _tempSelectedVitals.keys.toList();
        for (final key in keys) {
          _tempSelectedVitals[key] = true;
        }
      }
      _showDropdown = false;
    });
  }

  void _clearAll() {
    setState(() {
      if (widget.type == FilterHomeType.records) {
        final keys =
            widget.orderedRecords ?? _tempSelectedRecords.keys.toList();
        for (final key in keys) {
          _tempSelectedRecords[key] = false;
        }
      } else {
        final keys = widget.orderedVitals ?? _tempSelectedVitals.keys.toList();
        for (final key in keys) {
          _tempSelectedVitals[key] = false;
        }
      }
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRecords = widget.type == FilterHomeType.records;
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final borderColor =
        context.isDarkMode ? AppColors.borderDark : AppColors.border;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(Insets.normal),
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.normal,
                      vertical: Insets.small,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isRecords ? 'Records' : 'Vitals',
                          style: AppTextStyle.bodyMedium
                              .copyWith(color: textColor),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: textColor,
                              size: 24,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            padding: const EdgeInsets.all(9),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Container(height: 1, color: borderColor),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(Insets.normal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 227,
                              child: Text(
                                'Choose the ${isRecords ? 'records' : 'vitals'} you want to see on your dashboard.',
                                style: AppTextStyle.labelLarge
                                    .copyWith(color: textColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showDropdown = !_showDropdown;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: textColor, width: 2),
                                      borderRadius: BorderRadius.circular(
                                          4), // Square checkbox
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    _showDropdown
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: textColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Insets.normal),
                        Container(height: 1, color: borderColor),
                        const SizedBox(height: Insets.normal),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 400),
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  isRecords ? _buildRecords() : _buildVitals(),
                            ),
                          ),
                        ),
                        const SizedBox(height: Insets.normal),
                        if (!_canSave())
                          Container(
                            padding: const EdgeInsets.all(Insets.smallNormal),
                            margin:
                                const EdgeInsets.only(bottom: Insets.normal),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .errorContainer
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.error.withOpacity(0.3),
                                  width: 1),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  size: 16,
                                  color: AppColors.error,
                                ),
                                const SizedBox(width: Insets.small),
                                Expanded(
                                  child: Text(
                                    'Select at least one ${isRecords ? 'record type' : 'vital sign'} to continue.',
                                    style: AppTextStyle.labelLarge
                                        .copyWith(color: AppColors.error),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Insets.small),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: AppTextStyle.buttonSmall
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                            const SizedBox(width: Insets.small),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _canSave()
                                    ? () {
                                        if (isRecords &&
                                            widget.onRecordsSaved != null) {
                                          widget.onRecordsSaved!(
                                              _tempSelectedRecords);
                                        } else if (!isRecords &&
                                            widget.onVitalsSaved != null) {
                                          widget.onVitalsSaved!(
                                              _tempSelectedVitals);
                                        }
                                        Navigator.of(context).pop();
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _canSave()
                                      ? AppColors.primary
                                      : textColor.withOpacity(0.2),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Insets.small),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Save',
                                  style: AppTextStyle.buttonSmall.copyWith(
                                    color: _canSave()
                                        ? Colors.white
                                        : textColor.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Dropdown overlay
              if (_showDropdown)
                Positioned(
                  top: 109,
                  left: Insets.normal,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor: Colors.black.withOpacity(0.12),
                    child: Container(
                      width: 318,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      child: Column(
                        children: [
                          _buildDropdownItem('Select all', _selectAll),
                          _buildDropdownItem('Clear all', _clearAll),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String text, VoidCallback onTap) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(
              text,
              style: AppTextStyle.labelLarge.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRecords() {
    final categories = widget.orderedRecords ?? HomeRecordsCategory.values;
    return categories.map((category) {
      return _buildFilterItem(
        category.display,
        _tempSelectedRecords[category] ?? false,
        (value) {
          setState(() {
            _tempSelectedRecords[category] = value ?? false;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildVitals() {
    final types = widget.orderedVitals ?? _tempSelectedVitals.keys.toList();
    return types.map((type) {
      return _buildFilterItem(
        type.title,
        _tempSelectedVitals[type] ?? true,
        (value) {
          setState(() {
            _tempSelectedVitals[type] = value ?? true;
          });
        },
      );
    }).toList();
  }

  Widget _buildFilterItem(
      String title, bool isSelected, Function(bool?) onChanged) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(color: textColor),
          ),
          GestureDetector(
            onTap: () => onChanged(!isSelected),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : textColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4), // Square checkboxes
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
