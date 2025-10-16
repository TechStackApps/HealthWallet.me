import 'package:flutter/material.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_action_buttons.dart';

class PlaceholderScan extends StatelessWidget {
  final VoidCallback? onScan;
  final VoidCallback? onImport;
  final VoidCallback? onPickImage;

  const PlaceholderScan({
    super.key,
    this.onScan,
    this.onImport,
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
          'No scans yet',
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
        ScanActionButtons(
          style: ScanActionButtonStyle.placeholder,
          onScanDocument: onScan,
          onImportDocument: onImport,
          onPickImage: onPickImage,
        ),
      ],
    );
  }
}
