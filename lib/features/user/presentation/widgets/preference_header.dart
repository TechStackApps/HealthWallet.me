import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class PreferenceHeader extends StatelessWidget {
  const PreferenceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.normal,
        vertical: Insets.small,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Preferences',
            style: AppTextStyle.bodyMedium,
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: Assets.icons.close.svg(),
              onPressed: () {
                context.popDialog();
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
