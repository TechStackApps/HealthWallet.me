import 'package:flutter/material.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_action_buttons.dart';

class AddDocumentBottomSheet extends StatelessWidget {
  const AddDocumentBottomSheet({
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
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Add Document',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 20),

              DocumentActionButtons(
                style: DocumentActionButtonStyle.bottomSheet,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
