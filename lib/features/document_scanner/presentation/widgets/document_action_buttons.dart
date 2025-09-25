import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_wallet/features/document_scanner/presentation/bloc/document_scanner_bloc.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/dialog_helper.dart';

enum DocumentActionButtonStyle {
  placeholder,
  bottomSheet,
}

class DocumentActionButtons extends StatelessWidget {
  final DocumentActionButtonStyle style;
  final VoidCallback? onScanDocument;
  final VoidCallback? onImportDocument;
  final VoidCallback? onPickImage;

  const DocumentActionButtons({
    super.key,
    this.style = DocumentActionButtonStyle.placeholder,
    this.onScanDocument,
    this.onImportDocument,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildScanDocumentButton(context),
        SizedBox(
            height: style == DocumentActionButtonStyle.bottomSheet ? 12 : 20),
        _buildImportDocumentButton(context),
        SizedBox(
            height: style == DocumentActionButtonStyle.bottomSheet ? 12 : 20),
        _buildPickImageButton(context),
        if (style == DocumentActionButtonStyle.bottomSheet)
          const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScanDocumentButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: style == DocumentActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.document_scanner_outlined),
        label: const Text('Scan Document'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: () => _handleScanDocument(context),
      ),
    );
  }

  Widget _buildImportDocumentButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: style == DocumentActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.attach_file),
        label: const Text('Import Document'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
          backgroundColor: style == DocumentActionButtonStyle.bottomSheet
              ? theme.colorScheme.primary
              : Colors.blue,
          foregroundColor: style == DocumentActionButtonStyle.bottomSheet
              ? theme.colorScheme.onPrimary
              : Colors.white,
        ),
        onPressed: () => _handleImportDocument(context),
      ),
    );
  }

  Widget _buildPickImageButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: style == DocumentActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.photo_library),
        label: const Text('Pick Image'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
          backgroundColor: style == DocumentActionButtonStyle.bottomSheet
              ? theme.colorScheme.secondary
              : Colors.purple,
          foregroundColor: style == DocumentActionButtonStyle.bottomSheet
              ? theme.colorScheme.onSecondary
              : Colors.white,
        ),
        onPressed: () => _handlePickImage(context),
      ),
    );
  }

  Future<void> _handleScanDocument(BuildContext context) async {
    // Call custom callback if provided
    if (onScanDocument != null) {
      onScanDocument!();
      return;
    }

    // Default implementation
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context
            .read<DocumentScannerBloc>()
            .add(const DocumentScannerEvent.scanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      DialogHelper.showPermissionDeniedDialog(context);
    } else {
      DialogHelper.showPermissionRequiredDialog(
        context,
        () => _handleScanDocument(context),
      );
    }

    // Close bottom sheet AFTER processing (if in bottom sheet context)
    if (style == DocumentActionButtonStyle.bottomSheet && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleImportDocument(BuildContext context) async {
    // Call custom callback if provided
    if (onImportDocument != null) {
      onImportDocument!();
      return;
    }

    // Default implementation
    try {
      // Add a small delay to ensure any previous file operations are complete
      await Future.delayed(const Duration(milliseconds: 100));

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // Enable multiple file selection
        allowCompression: false,
        withData: false, // Changed to false to avoid memory issues
        withReadStream: false,
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'jpg',
          'jpeg',
          'png',
          'gif',
          'bmp',
          'webp',
          'tiff'
        ],
      );

      if (result != null && result.files.isNotEmpty) {
        // Process each selected file
        for (final file in result.files) {
          String finalFilePath = '';

          // Handle file based on platform
          if (file.path != null) {
            // Mobile platforms - use the original path
            finalFilePath = file.path!;
          } else {
            // Web platform - this shouldn't happen with withData: false
            continue;
          }

          // Verify file exists and add to bloc
          if (finalFilePath.isNotEmpty) {
            final fileExists = await File(finalFilePath).exists();

            if (fileExists) {
              if (context.mounted) {
                // Check if it's a PDF that needs to be converted to images
                if (finalFilePath.toLowerCase().endsWith('.pdf')) {
                  // For now, we'll treat PDFs as images by adding them directly
                  // In a production app, you would use a PDF-to-image converter here
                  // For this implementation, we'll store the PDF path as an image
                  context.read<DocumentScannerBloc>().add(
                        DocumentScannerEvent.documentImported(
                            filePath: finalFilePath),
                      );
                } else {
                  // Handle regular images
                  context.read<DocumentScannerBloc>().add(
                        DocumentScannerEvent.documentImported(
                            filePath: finalFilePath),
                      );
                }
              }
            }
          }
        }
      } else {}
    } catch (e) {
      // Error handling - no UI feedback needed
    }

    // Close bottom sheet AFTER processing (if in bottom sheet context)
    if (style == DocumentActionButtonStyle.bottomSheet && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handlePickImage(BuildContext context) async {
    // Call custom callback if provided
    if (onPickImage != null) {
      onPickImage!();
      return;
    }

    // Default implementation
    try {
      // Add a small delay to ensure any previous file operations are complete
      await Future.delayed(const Duration(milliseconds: 100));

      final ImagePicker picker = ImagePicker();

      // Simple gallery pick - let the plugin handle everything
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Verify file exists before adding
        final fileExists = await File(image.path).exists();

        if (fileExists) {
          // Add the image to the scanned documents
          if (context.mounted) {
            try {
              context.read<DocumentScannerBloc>().add(
                    DocumentScannerEvent.documentImported(filePath: image.path),
                  );
            } catch (e) {}
          } else {}
        } else {
          // Image file not found - no UI feedback needed
        }
      } else {}

      // Close bottom sheet AFTER processing the image (if in bottom sheet context)
      if (style == DocumentActionButtonStyle.bottomSheet && context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Image picker error - no UI feedback needed
    }
  }
}
