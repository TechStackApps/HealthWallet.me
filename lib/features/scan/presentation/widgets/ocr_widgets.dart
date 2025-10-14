import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class ProcessOcrButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProcessOcrButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.text_fields),
        label: const Text(
          'Process OCR',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class OcrProcessingIndicator extends StatelessWidget {
  const OcrProcessingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Insets.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withOpacity(0.3),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Processing OCR...',
            style: AppTextStyle.bodyMedium.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class ExtractedTextDisplay extends StatelessWidget {
  final String extractedText;
  final int currentPageIndex;

  const ExtractedTextDisplay({
    super.key,
    required this.extractedText,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Extracted Text - Page ${currentPageIndex + 1}',
          style: AppTextStyle.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: Insets.normal),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Insets.normal),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            extractedText,
            style: AppTextStyle.bodyMedium.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class FhirProcessingInfoCard extends StatelessWidget {
  const FhirProcessingInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Insets.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.text_fields,
                color: context.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'OCR to FHIR format',
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Future FHIR processing will be implemented here to automatically extract structured data from the OCR text.',
            style: AppTextStyle.bodySmall.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}