import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_wallet/core/widgets/app_button.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';

enum ScanActionButtonStyle {
  placeholder,
  bottomSheet,
}

class ScanActionButtons extends StatelessWidget {
  final ScanActionButtonStyle style;
  final VoidCallback? onScanDocument;
  final bool showScanButton;
  final bool showImportButton;

  const ScanActionButtons({
    super.key,
    this.style = ScanActionButtonStyle.placeholder,
    this.onScanDocument,
    this.showScanButton = true,
    this.showImportButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showScanButton) _buildScanDocumentButton(context),
        if (showScanButton && showImportButton)
          SizedBox(
              height: style == ScanActionButtonStyle.bottomSheet ? 12 : 20),
        if (showImportButton) _buildImportButton(context),
        if (style == ScanActionButtonStyle.bottomSheet)
          const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScanDocumentButton(BuildContext context) {
    return AppButton(
      label: 'Scan Document',
      icon: const Icon(Icons.document_scanner_outlined),
      variant: AppButtonVariant.transparent,
      onPressed: () => _handleScanDocument(context),
      padding: style == ScanActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(
              horizontal: Insets.medium,
              vertical: 20,
            )
          : null,
    );
  }

  Widget _buildImportButton(BuildContext context) {
    return AppButton(
      label: 'Import document / image',
      icon: const Icon(Icons.attach_file),
      variant: AppButtonVariant.primary,
      backgroundColor:
          style == ScanActionButtonStyle.bottomSheet ? null : Colors.blue,
      onPressed: () => _handleImport(context),
      padding: style == ScanActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(
              horizontal: Insets.medium,
              vertical: 20,
            )
          : null,
    );
  }

  Future<void> _handleScanDocument(BuildContext context) async {
    if (onScanDocument != null) {
      onScanDocument!();
      return;
    }

    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context.read<ScanBloc>().add(const ScanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      DialogHelper.showPermissionDeniedDialog(context);
    } else {
      DialogHelper.showPermissionRequiredDialog(
        context,
        () => _handleScanDocument(context),
      );
    }

    if (style == ScanActionButtonStyle.bottomSheet && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleImport(BuildContext context) async {
    await _DocumentImportHandler.handleImportDocument(context);
  }
}

class AddScanBottomSheet extends StatelessWidget {
  const AddScanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScanBottomSheetWrapper(
      title: 'Add Scan',
      child: Column(
        children: [
          _buildScanDocumentButton(context),
          const SizedBox(height: 12),
          _buildImportDocumentButton(context),
          const SizedBox(height: 12),
          _buildPickImageButton(context),
        ],
      ),
    );
  }

  Widget _buildScanDocumentButton(BuildContext context) {
    return AppButton(
      label: 'Scan Document',
      icon: const Icon(Icons.document_scanner_outlined),
      variant: AppButtonVariant.transparent,
      onPressed: () => _handleScanDocument(context),
    );
  }

  Widget _buildImportDocumentButton(BuildContext context) {
    return AppButton(
      label: 'Import Document',
      icon: const Icon(Icons.attach_file),
      variant: AppButtonVariant.primary,
      onPressed: () => _handleImportDocument(context),
    );
  }

  Widget _buildPickImageButton(BuildContext context) {
    return AppButton(
      label: 'Pick Image',
      icon: const Icon(Icons.photo_library),
      variant: AppButtonVariant.secondary,
      onPressed: () => _handlePickImage(context),
    );
  }

  Future<void> _handleScanDocument(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context.read<ScanBloc>().add(const ScanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      DialogHelper.showPermissionDeniedDialog(context);
    } else {
      DialogHelper.showPermissionRequiredDialog(
        context,
        () => _handleScanDocument(context),
      );
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handleImportDocument(BuildContext context) async {
    await _DocumentImportHandler.handleImportDocument(context);
  }

  Future<void> _handlePickImage(BuildContext context) async {
    await _DocumentImportHandler.handlePickImage(context);
  }
}

// Reusable bottom sheet wrapper
class _ScanBottomSheetWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const _ScanBottomSheetWrapper({
    required this.title,
    required this.child,
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
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              child,
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable document import handlers
class _DocumentImportHandler {
  static Future<void> handleImportDocument(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowCompression: false,
        withData: false,
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
        for (final file in result.files) {
          String finalFilePath = '';

          if (file.path != null) {
            finalFilePath = file.path!;
          } else {
            continue;
          }

          if (finalFilePath.isNotEmpty) {
            final fileExists = await File(finalFilePath).exists();

            if (fileExists) {
              if (context.mounted) {
                context.read<ScanBloc>().add(
                      DocumentImported(filePath: finalFilePath),
                    );
              }
            }
          }
        }
      }
    } catch (e) {
      // Handle error silently
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  static Future<void> handlePickImage(BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final fileExists = await File(image.path).exists();

        if (fileExists) {
          if (context.mounted) {
            try {
              context.read<ScanBloc>().add(
                    DocumentImported(filePath: image.path),
                  );
            } catch (e) {
              // Handle error silently
            }
          }
        }
      }
    } catch (e) {
      // Handle error silently
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
