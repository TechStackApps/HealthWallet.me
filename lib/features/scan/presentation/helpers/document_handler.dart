import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/pages/image_preview_page.dart';
import 'package:health_wallet/features/scan/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:health_wallet/features/scan/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:auto_route/auto_route.dart';

/// Mixin providing common document handling functionality for scan and import pages.
///
/// This mixin extracts duplicate code for navigating to FHIR mapper,
/// attaching documents to encounters, and handling document taps/deletion.
mixin DocumentHandler<T extends StatefulWidget> on State<T> {
  /// Navigate to the FHIR mapper page after loading the model.
  Future<void> navigateToFhirMapper(
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
    } catch (e) {
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to create encounter: $e');
      }
    }
  }

  /// Show encounter selector and attach documents to the selected encounter.
  Future<void> showEncounterSelector(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
  ) async {
    final selectedEncounter = await AttachToEncounterSheet.show(context);

    if (selectedEncounter != null && context.mounted) {
      await attachToEncounter(
        context,
        scannedImages,
        importedImages,
        savedPdfs,
        selectedEncounter,
      );
    }
  }

  /// Attach documents to the specified encounter.
  Future<void> attachToEncounter(
    BuildContext context,
    List<String> scannedImages,
    List<String> importedImages,
    List<String> savedPdfs,
    String encounterId,
  ) async {
    DialogHelper.showLoadingDialog(
      context,
      'Attaching documents to encounter...',
    );

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

  /// Handle tap on a document (image or PDF).
  Future<void> handleDocumentTap(
    BuildContext context,
    String filePath,
    int index,
  ) async {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);

    if (isPdf) {
      await openPdfWithSystemApp(context, filePath);
      return;
    }

    // It's an image, open preview
    final allImages = [
      ...state.scannedImagePaths,
      ...state.importedImagePaths,
    ];

    final currentIndex = allImages.indexOf(filePath);
    if (currentIndex == -1) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePath: filePath,
          title: 'Page ${currentIndex + 1}',
          allImages: allImages,
          currentIndex: currentIndex,
        ),
      ),
    );

    if (result == true && context.mounted) {
      context.read<ScanBloc>().add(
            DeleteDocument(imagePath: filePath),
          );
    }
  }

  /// Open a PDF file with the system's default PDF viewer.
  Future<void> openPdfWithSystemApp(
      BuildContext context, String pdfPath) async {
    try {
      final result = await OpenFile.open(pdfPath);
      if (result.type != ResultType.done) {
        // PDF could not be opened, silently fail
      }
    } catch (e) {
      // Error opening PDF, silently fail
    }
  }

  /// Show confirmation dialog before deleting a document.
  void showDeleteConfirmation(
    BuildContext context,
    String filePath,
    int index,
  ) {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);
    final fileName = filePath.split('/').last;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
}
