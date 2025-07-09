import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/user/presentation/widgets/profile_content.dart';
import 'package:health_wallet/core/theme/app_color.dart';

class PreferenceModal extends StatelessWidget {
  const PreferenceModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<UserProfileBloc>(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const _PreferenceDialog(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _PreferenceDialog extends StatelessWidget {
  const _PreferenceDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(Insets.medium),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Preferences',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.popDialog();
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: AppColors.border,
            ),
            const Flexible(
              child: SingleChildScrollView(
                child: ProfileContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
