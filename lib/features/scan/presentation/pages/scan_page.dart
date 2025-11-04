import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/features/scan/presentation/pages/image_preview_page.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/placeholder_scan.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';

@RoutePage()
class ScanPage extends StatelessWidget {
  final PageController? pageController;

  const ScanPage({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return ScanView(pageController: pageController);
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
  void _onPageControllerChanged() {
    final page = widget.pageController?.page;
    if (page != null && page.round() == 2) {
      _autoStartScanning();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.pageController?.addListener(_onPageControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final page = widget.pageController?.page;
      if (page != null && page.round() == 2) {
        _autoStartScanning();
      }
    });
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_onPageControllerChanged);
    super.dispose();
  }

  Future<void> _autoStartScanning() async {
    if (_hasAutoScanned) return;
    _hasAutoScanned = true;

    final currentState = context.read<ScanBloc>().state;

    final hasAnyFiles = currentState.scannedImagePaths.isNotEmpty ||
                        currentState.importedImagePaths.isNotEmpty ||
                        currentState.savedPdfPaths.isNotEmpty;

    if (!hasAnyFiles) {
      await _handleScanButtonPressed(context);
    }
  }

  Future<void> _handleScanButtonPressed(BuildContext context) async {
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
              if (state.scannedImagePaths.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () {
                  context.read<ScanBloc>().add(const ClearScans());
                },
                child: const Text('Clear'),
              );
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
              // Success handled by UI state updates
            },
            failure: (error) {
              // Error handled by UI state updates
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
    final hasScans = state.scannedImagePaths.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!hasScans) ...[
            Expanded(
                child: PlaceholderScan(
              onScan: () => _handleDirectScan(context),
            )),
          ] else ...[
            Expanded(
              child: ScanGrid(
                onAddScan: () => _handleDirectScan(context),
                onScanTap: (filePath, index) =>
                    _handleScanTap(context, filePath, index),
                onDeleteScan: (filePath, index) =>
                    _showDeleteConfirmation(context, filePath, index),
                includeScannedImages: true,
                includeImportedImages: false,
                includeFiles: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ActionButtons(
                onProcessToFhir: () => _navigateToFhirMapper(
                  context,
                  state.scannedImagePaths,
                  const <String>[],
                  const <String>[],
                ),
                onAttachToEncounter: () => _showEncounterSelector(
                  context,
                  state.scannedImagePaths,
                  const <String>[],
                  const <String>[],
                ),
                onExtractText: null,
              ),
            ),
          ]
        ],
      ),
    );
  }

  void _navigateToFhirMapper(BuildContext context, List<String> scannedImages,
      List<String> importedImages, List<String> pdfs) async {
    try {
      final result = await context.router.push<bool>(const LoadModelRoute());

      if (result == true && context.mounted) {
        context.router.push(FhirMapperRoute(
          scannedImages: scannedImages,
          importedImages: importedImages,
          importedPdfs: pdfs,
        ));
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
      final patientId = patient?.id ?? 'patient-default';
      final patientName = patient?.displayTitle ?? 'Unknown Patient';

      final sourceTypeService = GetIt.instance.get<SourceTypeService>();
      final walletSource = await sourceTypeService.getWritableSourceForPatient(
        patientId: patientId,
        patientName: patientName,
        availableSources: homeState.sources,
      );

      if (context.mounted) {
        context.read<PatientBloc>().add(
              PatientPatientsLoaded(),
            );
      }

      final documentReferenceService =
          GetIt.instance.get<DocumentReferenceService>();

      await documentReferenceService.saveGroupedDocumentsAsFhirRecords(
        scannedImages: scannedImages,
        importedImages: importedImages,
        importedPdfs: savedPdfs,
        patientId: patientId,
        encounterId: encounterId,
        sourceId: walletSource.id,
        title: 'Attached Documents',
      );

      if (context.mounted) {
        context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
      }

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
            DeleteDocument(imagePath: imagePath),
          );
    }
  }

  void _openPdfWithSystemApp(BuildContext context, String pdfPath) async {
    try {
      final result = await OpenFile.open(pdfPath);

      if (result.type != ResultType.done) {
        // PDF could not be opened, silently fail
      }
    } catch (e) {
      // Error opening PDF, silently fail
    }
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
                        DeletePdf(pdfPath: filePath),
                      );
                } else {
                  context.read<ScanBloc>().add(
                        DeleteDocument(imagePath: filePath),
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

  Future<void> _handleDirectScan(BuildContext context) async {
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
        () => _handleDirectScan(context),
      );
    }
  }
}
