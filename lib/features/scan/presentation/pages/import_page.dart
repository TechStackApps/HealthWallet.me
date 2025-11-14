import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/scan/domain/entity/processing_session.dart';
import 'package:health_wallet/features/scan/presentation/widgets/session_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/core/widgets/app_button.dart';
import 'package:health_wallet/core/widgets/custom_app_bar.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/scan/presentation/widgets/import_actions.dart';
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
      appBar: const CustomAppBar(
        title: 'Import',
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ScanBloc, ScanState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          log("Import: ${state.status}");
          if (state.status case SessionCreated(:final session)) {
            navigateToFhirMapper(context, session);
          }
        },
        builder: (context, state) {
          List<ProcessingSession> importSessions = state.sessions
              .where((element) => element.origin == ProcessingOrigin.import)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (importSessions.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Active import sessions:",
                          style: AppTextStyle.buttonLarge,
                        ),
                        const SizedBox(height: 24),
                        SessionList(sessions: importSessions),
                      ],
                    ),
                  ),
                ImportActions(
                  onImportDocument: () => _handleImportDocument(context),
                  onPickImage: () => _handlePickImage(context),
                  onScanDocument: () => _navigateToScanTab(context),
                ),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => _ImportOptionsBottomSheet(
        onImportDocument: () {
          Navigator.of(sheetContext).pop();
          _handleImportDocument(context);
        },
        onPickImage: () {
          Navigator.of(sheetContext).pop();
          _handlePickImage(context);
        },
      ),
    );
  }
}

class _ImportOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onImportDocument;
  final VoidCallback onPickImage;

  const _ImportOptionsBottomSheet({
    required this.onImportDocument,
    required this.onPickImage,
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
                'Import Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
