// Updated document_scanner_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/features/document_scanner/presentation/pages/process_to_fhir_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/features/document_scanner/presentation/pages/image_preview_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/features/document_scanner/presentation/bloc/document_scanner_bloc.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/attach_to_encounter_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/add_document_bottom_sheet.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_grid.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/placeholder_document.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/action_buttons.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/dialog_helper.dart';
import 'package:health_wallet/features/document_scanner/domain/services/text_recognition_service.dart';

@RoutePage()
class DocumentScannerPage extends StatelessWidget {
  final PageController? pageController;

  const DocumentScannerPage({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<DocumentScannerBloc>(),
      child: DocumentScannerView(pageController: pageController),
    );
  }
}

class DocumentScannerView extends StatefulWidget {
  final PageController? pageController;

  const DocumentScannerView({super.key, this.pageController});

  @override
  State<DocumentScannerView> createState() => _DocumentScannerViewState();
}

class _DocumentScannerViewState extends State<DocumentScannerView> {
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

    final currentState = context.read<DocumentScannerBloc>().state;

    // Only auto-start if no documents are already scanned
    if (currentState.scannedImagePaths.isEmpty) {
      await _handleScanButtonPressed(context);
    }
  }

  Future<void> _handleScanButtonPressed(BuildContext context) async {
    // Simple permission check and request
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
        () => _handleScanButtonPressed(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner'),
        actions: [
          BlocBuilder<DocumentScannerBloc, DocumentScannerState>(
            builder: (context, state) {
              if (state.scannedImagePaths.isNotEmpty ||
                  state.savedPdfPaths.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () => _showClearAllDialog(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<DocumentScannerBloc, DocumentScannerState>(
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
                      'Document(s) scanned successfully! Total: $totalCount'),
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
        child: BlocBuilder<DocumentScannerBloc, DocumentScannerState>(
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
          Text('Opening document scanner...'),
        ],
      ),
    );
  }

  Widget _buildMainView(BuildContext context, DocumentScannerState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (state.scannedImagePaths.isEmpty &&
              state.savedPdfPaths.isEmpty) ...[
            // Empty state
            Expanded(
              child: PlaceholderDocument(),
            ),
          ] else ...[
            // Documents scanned - show grid with add button
            Expanded(
              child: DocumentGrid(
                onAddDocument: () => _showAddDocumentBottomSheet(context),
                onDocumentTap: (filePath, index) =>
                    _handleDocumentTap(context, filePath, index),
                onDeleteDocument: (filePath, index) =>
                    _showDeleteConfirmation(context, filePath, index),
              ),
            ),

            // Bottom action buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ActionButtons(
                onCreateEncounter: () => _navigateToCreateEncounter(
                    context, state.scannedImagePaths),
                onAttachToEncounter: () =>
                    _showEncounterSelector(context, state.scannedImagePaths),
                onExtractText:
                    null, // Removed - will be in Create Encounter page
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToCreateEncounter(
      BuildContext context, List<String> imagePaths) async {
    // Show loading dialog
    DialogHelper.showLoadingDialog(context, 'Converting PDFs to images...');

    try {
      // For encounter creation, we need all documents as images for OCR
      // Convert PDFs to images first
      final allImagePaths = <String>[];

      // Add existing images
      allImagePaths.addAll(imagePaths);

      // Convert PDFs to images
      final textRecognitionService = TextRecognitionService();
      final pdfPaths = context.read<DocumentScannerBloc>().state.savedPdfPaths;

      for (final pdfPath in pdfPaths) {
        print('Converting PDF to images: $pdfPath');
        final convertedImages =
            await textRecognitionService.convertPdfToImages(pdfPath);
        allImagePaths.addAll(convertedImages);
        print('Converted PDF to ${convertedImages.length} images');
      }

      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Navigate to ProcessToFHIRPage with all images
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => ProcessToFHIRPage(imagePaths: allImagePaths),
        ),
      );

      if (result == true && context.mounted) {
        // Clear all documents after successful encounter creation
        context.read<DocumentScannerBloc>().add(
              const DocumentScannerEvent.clearAllDocuments(),
            );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show error dialog
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to convert PDFs: $e');
      }
    }
  }

  void _showEncounterSelector(
      BuildContext context, List<String> imagePaths) async {
    // Show loading dialog
    DialogHelper.showLoadingDialog(context, 'Converting PDFs to images...');

    try {
      // For attaching to existing encounters, we also need all documents as images
      // Convert PDFs to images first
      final allImagePaths = <String>[];

      // Add existing images
      allImagePaths.addAll(imagePaths);

      // Convert PDFs to images
      final textRecognitionService = TextRecognitionService();
      final pdfPaths = context.read<DocumentScannerBloc>().state.savedPdfPaths;

      for (final pdfPath in pdfPaths) {
        print('Converting PDF to images: $pdfPath');
        final convertedImages =
            await textRecognitionService.convertPdfToImages(pdfPath);
        allImagePaths.addAll(convertedImages);
        print('Converted PDF to ${convertedImages.length} images');
      }

      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      final selectedEncounter = await AttachToEncounterSheet.show(context);

      if (selectedEncounter != null && context.mounted) {
        _attachToEncounter(context, allImagePaths, selectedEncounter);
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show error dialog
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, 'Failed to convert PDFs: $e');
      }
    }
  }

  void _attachToEncounter(
      BuildContext context, List<String> imagePaths, String encounterId) async {
    // Show loading dialog
    DialogHelper.showLoadingDialog(context, 'Attaching to encounter...');

    try {
      // TODO: Implement attachment logic
      // This would call your media integration service to attach the images to the selected encounter
      await Future.delayed(
          const Duration(seconds: 1)); // Simulate async operation

      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show success dialog
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: context.read<DocumentScannerBloc>(),
            child: DialogHelper.buildAttachmentSuccessDialog(
                context, imagePaths.length, encounterId),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show error dialog
      if (context.mounted) {
        DialogHelper.showErrorDialog(context, e.toString());
      }
    }
  }

  void _handleDocumentTap(BuildContext context, String filePath, int index) {
    final state = context.read<DocumentScannerBloc>().state;
    final isImage = state.scannedImagePaths.contains(filePath);

    if (isImage) {
      _openImagePreview(
        context,
        filePath,
        state.scannedImagePaths,
        state.scannedImagePaths.indexOf(filePath),
      );
    } else {
      // For PDFs, open directly with system app
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

    // If user deleted the image from preview, trigger deletion in bloc
    if (result == true) {
      context.read<DocumentScannerBloc>().add(
            DocumentScannerEvent.deleteDocument(imagePath: imagePath),
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

  void _showAddDocumentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<DocumentScannerBloc>(),
        child: const AddDocumentBottomSheet(),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, String filePath, int index) {
    final state = context.read<DocumentScannerBloc>().state;
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
                  context.read<DocumentScannerBloc>().add(
                        DocumentScannerEvent.deletePdf(pdfPath: filePath),
                      );
                } else {
                  context.read<DocumentScannerBloc>().add(
                        DocumentScannerEvent.deleteDocument(
                            imagePath: filePath),
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
    final state = context.read<DocumentScannerBloc>().state;
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
                context.read<DocumentScannerBloc>().add(
                      const DocumentScannerEvent.clearAllDocuments(),
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
}
