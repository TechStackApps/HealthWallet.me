import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const FilterChipWidget({
    Key? key,
    required this.label,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      onDeleted: onDeleted,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      deleteIconColor: AppColors.primary,
      labelStyle: const TextStyle(color: AppColors.primary),
    );
  }
}
