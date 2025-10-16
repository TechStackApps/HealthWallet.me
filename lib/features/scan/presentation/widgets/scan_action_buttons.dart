import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';

enum ScanActionButtonStyle {
  placeholder,
  bottomSheet,
}

class ScanActionButtons extends StatelessWidget {
  final ScanActionButtonStyle style;
  final VoidCallback? onScanDocument;
  final VoidCallback? onImportDocument;
  final VoidCallback? onPickImage;

  const ScanActionButtons({
    super.key,
    this.style = ScanActionButtonStyle.placeholder,
    this.onScanDocument,
    this.onImportDocument,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildScanDocumentButton(context),
        SizedBox(height: style == ScanActionButtonStyle.bottomSheet ? 12 : 20),
        _buildImportDocumentButton(context),
        SizedBox(height: style == ScanActionButtonStyle.bottomSheet ? 12 : 20),
        _buildPickImageButton(context),
        if (style == ScanActionButtonStyle.bottomSheet)
          const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScanDocumentButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: style == ScanActionButtonStyle.placeholder
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
      padding: style == ScanActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.attach_file),
        label: const Text('Import Document'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
          backgroundColor: style == ScanActionButtonStyle.bottomSheet
              ? theme.colorScheme.primary
              : Colors.blue,
          foregroundColor: style == ScanActionButtonStyle.bottomSheet
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
      padding: style == ScanActionButtonStyle.placeholder
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.photo_library),
        label: const Text('Pick Image'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
          backgroundColor: style == ScanActionButtonStyle.bottomSheet
              ? theme.colorScheme.secondary
              : Colors.purple,
          foregroundColor: style == ScanActionButtonStyle.bottomSheet
              ? theme.colorScheme.onSecondary
              : Colors.white,
        ),
        onPressed: () => _handlePickImage(context),
      ),
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
        context.read<ScanBloc>().add(const ScanEvent.scanButtonPressed());
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

  Future<void> _handleImportDocument(BuildContext context) async {

    if (onImportDocument != null) {
      onImportDocument!();
      return;
    }


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

                if (finalFilePath.toLowerCase().endsWith('.pdf')) {



                  context.read<ScanBloc>().add(
                        ScanEvent.documentImported(filePath: finalFilePath),
                      );
                } else {

                  context.read<ScanBloc>().add(
                        ScanEvent.documentImported(filePath: finalFilePath),
                      );
                }
              }
            }
          }
        }
      } else {}
    } catch (e) {

    }


    if (style == ScanActionButtonStyle.bottomSheet && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _handlePickImage(BuildContext context) async {

    if (onPickImage != null) {
      onPickImage!();
      return;
    }


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
                    ScanEvent.documentImported(filePath: image.path),
                  );
            } catch (e) {}
          } else {}
        } else {

        }
      } else {}


      if (style == ScanActionButtonStyle.bottomSheet && context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {

    }
  }
}
