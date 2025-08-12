import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/user_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/patient_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/sync_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/widgets/settings_section.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class PreferenceModal extends StatelessWidget {
  const PreferenceModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<UserBloc>(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const PreferenceModal(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(Insets.medium),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
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
                      icon: Assets.icons.close.svg(
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.onSurface,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () {
                        context.popDialog();
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: borderColor,
            ),
            const Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Insets.normal),
                    UserSection(),
                    SizedBox(height: Insets.medium),
                    PatientSection(),
                    SizedBox(height: Insets.medium),
                    SyncSection(),
                    SizedBox(height: Insets.medium),
                    SettingsSection(),
                    SizedBox(height: Insets.normal),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
