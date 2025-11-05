import 'package:flutter/material.dart';
import 'package:health_wallet/core/widgets/app_button.dart';
import 'package:health_wallet/core/theme/app_insets.dart';

class ImportPlaceholder extends StatelessWidget {
  final VoidCallback? onImportDocument;
  final VoidCallback? onPickImage;
  final VoidCallback? onScanDocument;

  const ImportPlaceholder({
    super.key,
    this.onImportDocument,
    this.onPickImage,
    this.onScanDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          Icons.cloud_download_outlined,
          size: 100,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'No documents yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Import or scan documents to get started',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 40),
        AppButton(
          label: 'Import Document',
          icon: const Icon(Icons.attach_file),
          variant: AppButtonVariant.primary,
          onPressed: onImportDocument,
        ),
        const SizedBox(height: Insets.small),
        AppButton(
          label: 'Pick Image from Gallery',
          icon: const Icon(Icons.photo_library),
          variant: AppButtonVariant.secondary,
          onPressed: onPickImage,
        ),
        const SizedBox(height: Insets.small),
        AppButton(
          label: 'Scan Document',
          icon: const Icon(Icons.document_scanner_outlined),
          variant: AppButtonVariant.transparent,
          onPressed: onScanDocument,
        ),
      ],
    );
  }
}

