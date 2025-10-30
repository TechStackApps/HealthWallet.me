import 'package:flutter/material.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_action_buttons.dart';

class PlaceholderScan extends StatelessWidget {
  final VoidCallback? onScan;

  const PlaceholderScan({
    super.key,
    this.onScan,
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
          'Scan or import documents to get started',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 40),
        ScanActionButtons(
          style: ScanActionButtonStyle.placeholder,
          onScanDocument: onScan,
        ),
      ],
    );
  }
}
