import 'package:flutter/material.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_action_buttons.dart';

class AddScanBottomSheet extends StatelessWidget {
  const AddScanBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),


              Text(
                'Add Scan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 20),

              ScanActionButtons(
                style: ScanActionButtonStyle.bottomSheet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
