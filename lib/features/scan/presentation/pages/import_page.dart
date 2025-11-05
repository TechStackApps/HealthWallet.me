import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/core/widgets/app_button.dart';
import 'package:health_wallet/core/widgets/custom_app_bar.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/scan/presentation/widgets/import_placeholder.dart';
import 'package:health_wallet/features/scan/presentation/helpers/document_handler.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/page_view_navigation_controller.dart';

class ImportPage extends StatelessWidget {
  final PageViewNavigationController? navigationController;

  const ImportPage({super.key, this.navigationController});

  @override
  Widget build(BuildContext context) {
    return ImportView(navigationController: navigationController);
  }
}

class ImportView extends StatefulWidget {
  final PageViewNavigationController? navigationController;

  const ImportView({super.key, this.navigationController});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> with DocumentHandler {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Import',
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              final hasImportedImages = state.importedImagePaths.isNotEmpty;
              final hasPdfs = state.savedPdfPaths.isNotEmpty;
              if (!hasImportedImages && !hasPdfs)
                return const SizedBox.shrink();

              return TextButton(
                onPressed: () {
                  context.read<ScanBloc>().add(const ClearImports());
                },
                child: const Text('Clear'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ScanBloc, ScanState>(
        builder: (context, state) {
          final hasDocuments = state.importedImagePaths.isNotEmpty ||
              state.savedPdfPaths.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (!hasDocuments) ...[
                  Expanded(
                    child: ImportPlaceholder(
                      onImportDocument: () => _handleImportDocument(context),
                      onPickImage: () => _handlePickImage(context),
                      onScanDocument: () => _navigateToScanTab(context),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: ScanGrid(
                      onAddScan: () {
                        _showImportOptionsDialog(context);
                      },
                      onScanTap: (filePath, index) =>
                          handleDocumentTap(context, filePath, index),
                      onDeleteScan: (filePath, index) =>
                          showDeleteConfirmation(context, filePath, index),
                      includeScannedImages: false,
                      includeImportedImages: true,
                      includeFiles: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActionButtons(
                      onProcessToFhir: () => navigateToFhirMapper(
                        context,
                        const <String>[],
                        state.importedImagePaths,
                        state.savedPdfPaths,
                      ),
                      onAttachToEncounter: () => showEncounterSelector(
                        context,
                        const <String>[],
                        state.importedImagePaths,
                        state.savedPdfPaths,
                      ),
                      onExtractText: null,
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToScanTab(BuildContext context) {
    widget.navigationController?.navigateToPage(2);
    // Trigger auto-scan after navigation settles
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          _triggerScan(context);
        }
      });
    });
  }

  Future<void> _triggerScan(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      if (context.mounted) {
        context.read<ScanBloc>().add(const ScanButtonPressed());
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      if (context.mounted) {
        DialogHelper.showPermissionDeniedDialog(context);
      }
    } else {
      if (context.mounted) {
        DialogHelper.showPermissionRequiredDialog(
          context,
          () => _triggerScan(context),
        );
      }
    }
  }

  Future<void> _handleImportDocument(BuildContext context) async {
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
  }

  Future<void> _handlePickImage(BuildContext context) async {
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
  }

  void _showImportOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Import Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              label: 'Import Document',
              icon: const Icon(Icons.attach_file),
              variant: AppButtonVariant.primary,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handleImportDocument(context);
              },
            ),
            const SizedBox(height: Insets.small),
            AppButton(
              label: 'Pick Image from Gallery',
              icon: const Icon(Icons.photo_library),
              variant: AppButtonVariant.secondary,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handlePickImage(context);
              },
            ),
            const SizedBox(height: Insets.small),
            AppButton(
              label: 'Scan Document',
              icon: const Icon(Icons.document_scanner_outlined),
              variant: AppButtonVariant.transparent,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _navigateToScanTab(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
