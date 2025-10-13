// widgets/document_summary_card.dart
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class ScanSummaryCard extends StatelessWidget {
  final int scannedCount;
  final int importedImagesCount;
  final int importedPdfsCount;
  final int totalPagesForOcr;

  const ScanSummaryCard({
    super.key,
    required this.scannedCount,
    required this.importedImagesCount,
    required this.importedPdfsCount,
    required this.totalPagesForOcr,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan Summary',
              style: AppTextStyle.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (scannedCount > 0)
              Text(
                  '• $scannedCount scanned image${scannedCount > 1 ? 's' : ''}'),
            if (importedImagesCount > 0)
              Text(
                  '• $importedImagesCount imported image${importedImagesCount > 1 ? 's' : ''}'),
            if (importedPdfsCount > 0)
              Text(
                  '• $importedPdfsCount imported PDF${importedPdfsCount > 1 ? 's' : ''}'),
            const SizedBox(height: 8),
            Text(
              'Total: $totalPagesForOcr pages available for OCR preview',
              style: AppTextStyle.bodySmall.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
