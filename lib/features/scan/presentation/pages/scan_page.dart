import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:health_wallet/core/widgets/custom_app_bar.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';

// Your current widgets/helpers
import 'package:health_wallet/features/scan/presentation/widgets/documents_grid.dart' as legacy;
import 'package:health_wallet/features/scan/presentation/widgets/scan_placeholder.dart' as legacy;
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart' as legacy_actions;
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/scan/presentation/helpers/document_handler.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/page_view_navigation_controller.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/navigation_settled_callback_mixin.dart';

// Incoming widgets/helpers
import 'package:health_wallet/core/utils/deep_link_file_cache.dart';
import 'package:health_wallet/features/scan/presentation/widgets/add_scan_bottom_sheet.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/placeholder_scan.dart';
import 'package:health_wallet/features/scan/presentation/pages/image_preview_page.dart';
import 'package:health_wallet/features/scan/presentation/pages/process_to_fhir_page.dart';
import 'package:health_wallet/features/scan/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:open_file/open_file.dart';

// Services/entities used in incoming flow
import 'package:health_wallet/features/scan/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

@RoutePage()
class ScanPage extends StatelessWidget {
  // Keep your navigationController for Dashboard integration
  final PageViewNavigationController? navigationController;

  // Also accept deep-link params (incoming)
  final String? importedFilePath;
  final String? providerName;

  const ScanPage({
    super.key,
    this.navigationController,
    @QueryParam() this.importedFilePath,
    @QueryParam() this.providerName,
  });

  @override
  Widget build(BuildContext context) {
    // Your current code assumes an existing ScanBloc higher up; incoming wraps with provider.
    // To be safe, only create if absent.
    final bloc = context.read<ScanBloc?>();
    if (bloc != null) {
      return ScanView(
        navigationController: navigationController,
        importedFilePath: importedFilePath,
        providerName: providerName,
      );
    }
    return BlocProvider(
      create: (_) => GetIt.instance.get<ScanBloc>(),
      child: ScanView(
        navigationController: navigationController,
        importedFilePath: importedFilePath,
        providerName: providerName,
      ),
    );
  }
}

class ScanView extends StatefulWidget {
  final PageViewNavigationController? navigationController;
  final String? importedFilePath;
  final String? providerName;

  const ScanView({
    super.key,
    this.navigationController,
    this.importedFilePath,
    this.providerName,
  });

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView>
    with DocumentHandler, NavigationSettledCallbackMixin {
  bool _hasAutoScanned = false;
  bool _hasImportedDeepLink = false;

  // Wire NavigationSettledCallbackMixin to Scan tab index = 2 (as in your current dashboard)
  @override
  PageViewNavigationController? get navigationController =>
      widget.navigationController;

  @override
  void initState() {
    super.initState();
    initializeNavigationSettledListener(2);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleDeepLinkImport();
      // Only auto-scan if no deep link import occurred
      if (!_hasImportedDeepLink) {
        await _autoStartScanning();
      }
    });
  }

  @override
  void dispose() {
    disposeNavigationSettledListener();
    super.dispose();
  }

  @override
  void onPageSettled() {
    // Your behavior: auto start when landing on tab
    _autoStartScanning();
  }

  @override
  void onPageLeft() {
    setState(() {
      _hasAutoScanned = false;
    });
  }

  Future<void> _handleDeepLinkImport() async {
    if (_hasImportedDeepLink) return;

    // First, check routed params (optional)
    final routedPath = widget.importedFilePath;
    if (routedPath != null && routedPath.isNotEmpty) {
      final exists = await File(routedPath).exists();
      if (exists && mounted) {
        context.read<ScanBloc>().add(
              ScanEvent.documentImported(filePath: routedPath),
            );
        _hasImportedDeepLink = true;
        _showSnack('Document from ${widget.providerName ?? "provider"} imported!');
        return;
      }
    }

    // Then check cached file from DeepLinkHandler (incoming behavior)
    final cached = DeepLinkFileCache.instance.getAndClearFile();
    if (cached != null && cached['filePath'] != null) {
      final filePath = cached['filePath'] as String;
      final exists = await File(filePath).exists();
      if (exists && mounted) {
        context.read<ScanBloc>().add(
              ScanEvent.documentImported(filePath: filePath),
            );
        _hasImportedDeepLink = true;
        _showSnack('Document from ${cached['providerName'] ?? "provider"} imported!');
      }
    }
  }

  Future<void> _autoStartScanning() async {
    if (_hasAutoScanned || _hasImportedDeepLink) return;
    _hasAutoScanned = true;

    final currentState = context.read<ScanBloc>().state;
    final hasAnyFiles = currentState.scannedImagePaths.isNotEmpty ||
        currentState.importedImagePaths.isNotEmpty ||
        currentState.savedPdfPaths.isNotEmpty;

    if (!hasAnyFiles) {
      await _handleScanButtonPressed(context);
    }
  }

  void _resetAutoScanFlag() {
    if (_hasAutoScanned) {
      setState(() {
        _hasAutoScanned = false;
      });
      resetTriggerFlag();
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
      // Keep your CustomAppBar and Clear action if items exist
      appBar: CustomAppBar(
        title: 'Scan',
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              final hasAny = state.scannedImagePaths.isNotEmpty ||
                  state.savedPdfPaths.isNotEmpty ||
                  state.importedImagePaths.isNotEmpty;
              if (!hasAny) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => _showClearAllDialog(context),
                child: const Text('Clear'),
              );
            },
          ),
        ],
      ),
      body: BlocListener<ScanBloc, ScanState>(
        listenWhen: (previous, current) {
          // Your previous listener: when items became empty, allow re-auto-scan if still on tab
          final prevAny = previous.scannedImagePaths.isNotEmpty ||
              previous.importedImagePaths.isNotEmpty ||
              previous.savedPdfPaths.isNotEmpty;
          final nowAny = current.scannedImagePaths.isNotEmpty ||
              current.importedImagePaths.isNotEmpty ||
              current.savedPdfPaths.isNotEmpty;
          return prevAny && !nowAny;
        },
        listener: (context, state) {
          if (mounted && widget.navigationController?.currentPage == 2) {
            _resetAutoScanFlag();
            _autoStartScanning();
          }
        },
        child: BlocListener<ScanBloc, ScanState>(
          listener: (context, state) {
            // Incoming UX: toast on success/failure
            state.status.when(
              initial: () {},
              loading: () {},
              success: () {
                final total = state.scannedImagePaths.length +
                    state.importedImagePaths.length +
                    state.savedPdfPaths.length;
                _showSnack('Scan(s) completed successfully! Total: $total');
              },
              failure: (error) {
                _showSnackAction(
                  'Scan failed: $error',
                  'Retry',
                  () => _handleScanButtonPressed(context),
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
    final hasAny = allImages.isNotEmpty || state.savedPdfPaths.isNotEmpty;

    // Prefer incoming new UI (PlaceholderScan + ScanGrid + AddScanBottomSheet).
    // Keep your legacy widgets behind a flag if you want to toggle later.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!hasAny) ...[
            Expanded(
              child: PlaceholderScan(
                onScan: () => _handleDirectScan(context),
                onImport: () => _handleDirectImport(context),
              ),
            ),
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
              child: legacy_actions.ActionButtons(
                // Keep incoming “Create encounter” flow mapped onto your button set
                onProcessToFhir: () => _navigateToCreateEncounter(
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
          ],
        ],
      ),
    );
  }

  Future<void> _handleDirectScan(BuildContext context) async {
    // Same as _handleScanButtonPressed; kept separate to mirror your code
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
          'tiff',
        ],
      );
      if (result == null || result.files.isEmpty) return;

      for (final file in result.files) {
        final path = file.path;
        if (path == null || path.isEmpty) continue;

        final exists = await File(path).exists();
        if (!exists) continue;

        if (context.mounted) {
          // For now treat PDFs as importable items; future: convert pdf->images
          context.read<ScanBloc>().add(
                ScanEvent.documentImported(filePath: path),
              );
        }
      }
    } catch (_) {
      // swallow errors silently per incoming code
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

  void _handleScanTap(BuildContext context, String filePath, int index) {
    final state = context.read<ScanBloc>().state;
    final isImage = state.scannedImagePaths.contains(filePath) ||
        state.importedImagePaths.contains(filePath);
    if (isImage) {
      _openImagePreview(
        context,
        filePath,
        [...state.scannedImagePaths, ...state.importedImagePaths],
        index,
      );
    } else {
      _openPdfWithSystemApp(context, filePath);
    }
  }

  Future<void> _openImagePreview(
      BuildContext context, String imagePath, List<String> all, int index) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePath: imagePath,
          title: 'Page ${index + 1}',
          allImages: all,
          currentIndex: index,
        ),
      ),
    );
    if (result == true && context.mounted) {
      context.read<ScanBloc>().add(
            ScanEvent.deleteDocument(imagePath: imagePath),
          );
    }
  }

  Future<void> _openPdfWithSystemApp(BuildContext context, String pdfPath) async {
    try {
      final result = await OpenFile.open(pdfPath);
      if (result.type != ResultType.done && context.mounted) {
        _showSnack('Could not open PDF: ${result.message}', bg: Colors.orange);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnack('Error opening PDF: $e', bg: Colors.red);
      }
    }
  }

  void _showDeleteConfirmation(BuildContext context, String filePath, int index) {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);
    final fileName = filePath.split('/').last;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isPdf ? 'Delete PDF' : 'Delete Page'),
          content: Text(
            'Are you sure you want to delete ${isPdf ? 'PDF: $fileName' : 'Page ${index + 1}'}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
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
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showClearAllDialog(BuildContext context) {
    final state = context.read<ScanBloc>().state;
    final total = state.scannedImagePaths.length +
        state.importedImagePaths.length +
        state.savedPdfPaths.length;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Documents'),
          content: Text(
            'Are you sure you want to delete all $total document${total == 1 ? '' : 's'}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<ScanBloc>().add(
                      const ScanEvent.clearAllDocuments(),
                    );
              },
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToCreateEncounter(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> pdfs,
  ) async {
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

  Future<void> _showEncounterSelector(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
  ) async {
    final selectedEncounter = await AttachToEncounterSheet.show(context);
    if (selectedEncounter != null && context.mounted) {
      await _attachToEncounter(
        context,
        scannedImages,
        importedImages,
        savedPdfs,
        selectedEncounter,
      );
    }
  }

  Future<void> _attachToEncounter(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
    String encounterId,
  ) async {
    DialogHelper.showLoadingDialog(context, 'Attaching documents to encounter...');
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
        context.read<PatientBloc>().add(PatientPatientsLoaded());
      }

      final mediaIntegrationService = GetIt.instance.get<MediaIntegrationService>();
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
        final total = scannedImages.length + importedImages.length + savedPdfs.length;
        DialogHelper.showAttachmentSuccessDialog(
          context,
          total,
          encounterId,
          context.read<ScanBloc>(),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to attach documents: $e');
      }
    }
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
        date: drift.Value(
          patient.birthDate?.valueString != null
              ? DateTime.tryParse(patient.birthDate!.valueString!) ?? DateTime.now()
              : DateTime.now(),
        ),
        resourceRaw: jsonEncode(patientJson),
        encounterId: const drift.Value.absent(),
        subjectId: drift.Value(resourceId),
      );
      await database.into(database.fhirResource).insertOnConflictUpdate(dto);
    } catch (_) {
      // swallow to avoid UX disruption
    }
  }

  void _showSnack(String msg, {Color? bg}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: bg),
    );
    // no-op return
  }

  void _showSnackAction(String msg, String action, VoidCallback onPressed) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(label: action, onPressed: onPressed),
      ),
    );
  }
}
