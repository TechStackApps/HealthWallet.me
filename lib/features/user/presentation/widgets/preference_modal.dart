import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_header.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_user_section.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_patient_section.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_sync_section.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_settings_section.dart';

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
            const PreferenceHeader(),
            Divider(
              height: 1,
              color: borderColor,
            ),
            const Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Insets.normal),
                    PreferenceUserSection(),
                    SizedBox(height: Insets.medium),
                    PreferencePatientSection(),
                    SizedBox(height: Insets.medium),
                    PreferenceSyncSection(),
                    SizedBox(height: Insets.medium),
                    PreferenceSettingsSection(),
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
