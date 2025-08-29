import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'form_fields.dart';

class DialogHeader extends StatelessWidget {
  final Color textColor;
  final VoidCallback onCancel;

  const DialogHeader({
    super.key,
    required this.textColor,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.normal, vertical: Insets.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FormFields.buildIconButton(Assets.icons.user, textColor, onCancel),
              const SizedBox(width: Insets.small),
              Text('Edit details',
                  style: AppTextStyle.bodySmall
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          FormFields.buildIconButton(Assets.icons.close, textColor, onCancel),
        ],
      ),
    );
  }
}
