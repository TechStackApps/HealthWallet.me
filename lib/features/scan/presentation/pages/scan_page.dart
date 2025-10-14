import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/features/scan/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/scan/presentation/pages/process_to_fhir_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/features/scan/presentation/pages/image_preview_page.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:health_wallet/features/scan/presentation/widgets/add_scan_bottom_sheet.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/placeholder_scan.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';

@RoutePage()
class ScanPage extends StatelessWidget {
  final PageController? pageController;

  const ScanPage({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<ScanBloc>(),
      child: ScanView(pageController: pageController),
    );
  }
}

class ScanView extends StatefulWidget {
  final PageController? pageController;

  const ScanView({super.key, this.pageController});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  bool _hasAutoScanned = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoStartScanning();
    });
  }

  Future<void> _autoStartScanning() async {
    if (_hasAutoScanned) return;
    _hasAutoScanned = true;

    final currentState = context.read<ScanBloc>().state;

    if (currentState.scannedImagePaths.isEmpty) {
      await _handleScanButtonPressed(context);
    }
  }

  Future<void> _handleScanButtonPressed(BuildContext context) async {
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
        () => _handleScanButtonPressed(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state.scannedImagePaths.isNotEmpty ||
                  state.savedPdfPaths.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showClearAllDialog(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<ScanBloc, ScanState>(
        listener: (context, state) {
          state.status.when(
            initial: () {},
            loading: () {},
            success: () {
              final imageCount = state.scannedImagePaths.length;
              final pdfCount = state.savedPdfPaths.length;
              final totalCount = imageCount + pdfCount;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Scan(s) completed successfully! Total: $totalCount'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            failure: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Scan failed: $error'),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () => _handleScanButtonPressed(context),
                  ),
                ),
              );
            },
          );
        },
        child: BlocBuilder<ScanBloc, ScanState>(
          builder: (context, state) {
            return state.status.when(
              initial: () => _buildMainView(context, state),
              loading: () => _buildLoadingView(),
              success: () => _buildMainView(context, state),
              failure: (error) => _buildMainView(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Opening scanner...'),
        ],
      ),
    );
  }

  Widget _buildMainView(BuildContext context, ScanState state) {
    final allImages = [...state.scannedImagePaths, ...state.importedImagePaths];
    final hasScans = allImages.isNotEmpty || state.savedPdfPaths.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!hasScans) ...[
            Expanded(
                child: PlaceholderScan(
              onScan: () => _handleDirectScan(context),
              onImport: () => _handleDirectImport(context),
            )),
          ] else ...[
            Expanded(
              child: ScanGrid(
                onAddScan: () => _showAddScanBottomSheet(context),
                onScanTap: (filePath, index) =>
                    _handleScanTap(context, filePath, index),
                onDeleteScan: (filePath, index) =>
                    _showDeleteConfirmation(context, filePath, index),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ActionButtons(
                onCreateEncounter: () => _navigateToCreateEncounter(
                  context,
                  state.scannedImagePaths,
                  state.importedImagePaths,
                  state.savedPdfPaths,
                ),
                onAttachToEncounter: () => _showEncounterSelector(
                  context,
                  state.scannedImagePaths,
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
  }

  void _navigateToCreateEncounter(
      BuildContext context,
      List<String> scannedImages,
      List<String> importedImages,
      List<String> pdfs) async {
    try {
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => ProcessToFHIRPage(
            scannedImages: scannedImages,
            importedImages: importedImages,
            importedPdfs: pdfs,
          ),
        ),
      );

      if (result == true && context.mounted) {
        context.read<ScanBloc>().add(const ScanEvent.clearAllDocuments());
      }
    } catch (e) {
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to create encounter: $e');
      }
    }
  }

  void _showEncounterSelector(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
  ) async {
    final selectedEncounter = await AttachToEncounterSheet.show(context);

    if (selectedEncounter != null && context.mounted) {
      _attachToEncounter(
          context, scannedImages, importedImages, savedPdfs, selectedEncounter);
    }
  }

  void _attachToEncounter(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
    String encounterId,
  ) async {
    DialogHelper.showLoadingDialog(
        context, 'Attaching documents to encounter...');

    try {
      final homeState = context.read<HomeBloc>().state;
      final patientState = context.read<PatientBloc>().state;

      final selectedPatient = patientState.patients.isNotEmpty
          ? patientState.patients.firstWhere(
              (p) => p.id == patientState.selectedPatientId,
              orElse: () => patientState.patients.first,
            )
          : null;

      final patient = selectedPatient ?? homeState.patient;
      final patientId = patient?.resourceId ?? 'patient-default';
      final patientName = patient?.displayTitle ?? 'Unknown Patient';

      final sourceTypeService = GetIt.instance.get<SourceTypeService>();
      final walletSource = await sourceTypeService.getWritableSourceForPatient(
        patientId: patientId,
        patientName: patientName,
        availableSources: homeState.sources,
      );

      final existingSources = homeState.sources.map((s) => s.id).toList();
      final isNewWalletSource = !existingSources.contains(walletSource.id);

      if (isNewWalletSource && patient != null) {
        await _duplicatePatientToWalletSource(patient, walletSource.id);
      }

      if (context.mounted) {
        context.read<PatientBloc>().add(
              PatientPatientsLoaded(),
            );
      }

      final mediaIntegrationService =
          GetIt.instance.get<MediaIntegrationService>();

      await mediaIntegrationService.saveGroupedDocumentsAsFhirRecords(
        scannedImages: scannedImages,
        importedImages: importedImages,
        importedPdfs: savedPdfs,
        patientId: patientId,
        encounterId: encounterId,
        sourceId: walletSource.id,
        title: 'Attached Documents',
      );

      if (context.mounted) Navigator.of(context).pop();

      if (context.mounted) {
        final bloc = context.read<ScanBloc>();
        final totalDocuments =
            scannedImages.length + importedImages.length + savedPdfs.length;

        DialogHelper.showAttachmentSuccessDialog(
          context,
          totalDocuments,
          encounterId,
          bloc,
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();

      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to attach documents: $e');
      }
    }
  }

  void _handleScanTap(BuildContext context, String filePath, int index) {
    final state = context.read<ScanBloc>().state;
    final isImage = state.scannedImagePaths.contains(filePath);

    if (isImage) {
      _openImagePreview(
        context,
        filePath,
        state.scannedImagePaths,
        state.scannedImagePaths.indexOf(filePath),
      );
    } else {
      _openPdfWithSystemApp(context, filePath);
    }
  }

  void _openImagePreview(BuildContext context, String imagePath,
      List<String> allImages, int index) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePath: imagePath,
          title: 'Page ${index + 1}',
          allImages: allImages,
          currentIndex: index,
        ),
      ),
    );

    if (result == true) {
      context.read<ScanBloc>().add(
            ScanEvent.deleteDocument(imagePath: imagePath),
          );
    }
  }

  void _openPdfWithSystemApp(BuildContext context, String pdfPath) async {
    try {
      final result = await OpenFile.open(pdfPath);

      if (result.type != ResultType.done) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open PDF: ${result.message}'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showAddScanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<ScanBloc>(),
        child: const AddScanBottomSheet(),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, String filePath, int index) {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);
    final fileName = filePath.split('/').last;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(isPdf ? 'Delete PDF' : 'Delete Page'),
          content: Text(
              'Are you sure you want to delete ${isPdf ? 'PDF: $fileName' : 'Page ${index + 1}'}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (isPdf) {
                  context.read<ScanBloc>().add(
                        ScanEvent.deletePdf(pdfPath: filePath),
                      );
                } else {
                  context.read<ScanBloc>().add(
                        ScanEvent.deleteDocument(imagePath: filePath),
                      );
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showClearAllDialog(BuildContext context) {
    final state = context.read<ScanBloc>().state;
    final totalDocuments =
        state.scannedImagePaths.length + state.savedPdfPaths.length;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Documents'),
          content: Text(
              'Are you sure you want to delete all $totalDocuments document${totalDocuments > 1 ? 's' : ''}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<ScanBloc>().add(
                      const ScanEvent.clearAllDocuments(),
                    );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _duplicatePatientToWalletSource(
      Patient? patient, String walletSourceId) async {
    if (patient == null) return;

    try {
      final database = GetIt.instance.get<AppDatabase>();

      final walletPatient = patient.copyWith(
        id: patient.id,
        sourceId: walletSourceId,
      );

      final patientJson = patient.rawResource;
      final resourceId = patient.id;

      final dto = FhirResourceCompanion.insert(
        id: '${walletSourceId}_$resourceId',
        sourceId: drift.Value(walletSourceId),
        resourceId: drift.Value(resourceId),
        resourceType: drift.Value('Patient'),
        title: drift.Value(walletPatient.displayTitle),
        date: drift.Value(walletPatient.birthDate?.valueString != null
            ? DateTime.tryParse(walletPatient.birthDate!.valueString!) ??
                DateTime.now()
            : DateTime.now()),
        resourceRaw: jsonEncode(patientJson),
        encounterId: const drift.Value.absent(),
        subjectId: drift.Value(resourceId),
      );

      await database.into(database.fhirResource).insertOnConflictUpdate(dto);
    } catch (e) {}
  }

  Future<void> _handleDirectScan(BuildContext context) async {
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
        () => _handleDirectScan(context),
      );
    }
  }

  Future<void> _handleDirectImport(BuildContext context) async {
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
      }
    } catch (e) {}
  }
}
