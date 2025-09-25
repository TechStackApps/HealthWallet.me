import 'package:flutter/material.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_action_buttons.dart';

class PlaceholderDocument extends StatelessWidget {
  final VoidCallback? onScanDocument;
  final VoidCallback? onImportDocument;
  final VoidCallback? onPickImage;

  const PlaceholderDocument({
    super.key,
    this.onScanDocument,
    this.onImportDocument,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          Icons.document_scanner,
          size: 100,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'No documents scanned yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tap the scan button to get started',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 40),
        DocumentActionButtons(
          style: DocumentActionButtonStyle.placeholder,
          onScanDocument: onScanDocument,
          onImportDocument: onImportDocument,
          onPickImage: onPickImage,
        ),
      ],
    );
  }
}
