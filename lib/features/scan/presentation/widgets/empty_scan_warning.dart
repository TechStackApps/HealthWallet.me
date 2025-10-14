// widgets/empty_document_warning.dart
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';

class EmptyScanWarning extends StatelessWidget {
  const EmptyScanWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Insets.large),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border.all(color: Colors.orange[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.warning, color: Colors.orange[700], size: 40),
          const SizedBox(height: 8),
          Text(
            'No images available for OCR processing',
            style: AppTextStyle.bodyMedium.copyWith(
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Only PDFs were provided. They will be included in the encounter but OCR preview is not available.',
            style: AppTextStyle.bodySmall.copyWith(
              color: Colors.orange[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
