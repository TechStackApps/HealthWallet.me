import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'dropdown_field.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class FormFields {
  static Widget buildFieldLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.smaller),
      child: Text(label,
          style: AppTextStyle.bodySmall.copyWith(
            color: context.isDarkMode
                ? AppColors.textPrimaryDark
                : AppColors.textPrimary,
          )),
    );
  }

  static Widget buildDropdownField(
    BuildContext context,
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFieldLabel(context, label),
        DropdownField(
          value: value,
          items: items,
          onChanged: onChanged,
          isSelected: true,
        ),
      ],
    );
  }

  static Widget buildActionButtons({
    required VoidCallback onCancel,
    required VoidCallback onSave,
    required bool isLoading,
  }) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: Insets.small),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text('Cancel', style: AppTextStyle.buttonSmall),
          ),
        ),
        const SizedBox(width: Insets.small),
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: Insets.small),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text('Save details', style: AppTextStyle.buttonSmall),
          ),
        ),
      ],
    );
  }

  static Widget buildIconButton(
    dynamic icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: IconButton(
        icon: icon.svg(
          width: 24.0,
          height: 24.0,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
