import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/pages/image_preview_page.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_action_buttons.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_grid.dart';
import 'package:health_wallet/features/scan/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_file/open_file.dart';

class ImportPage extends StatelessWidget {
  final PageController? pageController;

  const ImportPage({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return const ImportView();
  }
}

class ImportView extends StatefulWidget {
  const ImportView({super.key});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import'),
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
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Icon(
                          Icons.cloud_download_outlined,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No documents yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Import or scan documents to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 40),
                        ScanActionButtons(
                          style: ScanActionButtonStyle.placeholder,
                          onScanDocument: () {
                            _navigateToScanTab(context);
                          },
                        ),
                      ],
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
                      includeScannedImages: false,
                      includeImportedImages: true,
                      includeFiles: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ActionButtons(
                      onProcessToFhir: () => _navigateToFhirMapper(
                        context,
                        const <String>[],
                        state.importedImagePaths,
                        state.savedPdfPaths,
                      ),
                      onAttachToEncounter: () => _showEncounterSelector(
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
    final element = context.findAncestorWidgetOfExactType<ImportPage>();
    if (element?.pageController != null) {
      element!.pageController!.animateToPage(
        2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _showAddScanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<ScanBloc>(),
        child: const ImportOptionsBottomSheet(),
      ),
    );
  }

  Future<void> _handleScanTap(
      BuildContext context, String filePath, int index) async {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);

    if (isPdf) {
      _openPdfWithSystemApp(context, filePath);
      return;
    }

    final allImages = [
      ...state.scannedImagePaths,
      ...state.importedImagePaths,
    ];

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePath: filePath,
          title: 'Page ${index + 1}',
          allImages: allImages,
          currentIndex: index,
        ),
      ),
    );

    if (result == true) {
      context.read<ScanBloc>().add(
            DeleteDocument(imagePath: filePath),
          );
    }
  }

  void _openPdfWithSystemApp(BuildContext context, String pdfPath) async {
    try {
      final result = await OpenFile.open(pdfPath);
      if (result.type != ResultType.done) {}
    } catch (_) {}
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

  Future<void> _navigateToFhirMapper(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> pdfs,
  ) async {
    try {
      final result = await context.router.push<bool>(const LoadModelRoute());
      if (result == true && context.mounted) {
        context.router.push(FhirMapperRoute(
          scannedImages: scannedImages,
          importedImages: importedImages,
          importedPdfs: pdfs,
        ));
      }
    } catch (_) {}
  }

  void _showEncounterSelector(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> pdfs,
  ) {
    _selectEncounterAndAttach(context, scannedImages, importedImages, pdfs);
  }

  Future<void> _selectEncounterAndAttach(
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
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        DialogHelper.showErrorDialog(context, 'Failed to create encounter: $e');
      }
    }
  }
}
