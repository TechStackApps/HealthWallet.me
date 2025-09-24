// Hybrid solution - minimal permission handling + scanner
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/document_scanner/presentation/pages/image_preview_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/features/document_scanner/presentation/bloc/document_scanner_bloc.dart';
import 'package:health_wallet/features/document_scanner/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/save_fhir_media_dialog.dart';

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

  MediaIntegrationService get _mediaIntegrationService => GetIt.instance.get<MediaIntegrationService>();

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
      _showPermissionDeniedDialog(context);
    } else {
      _showPermissionRequiredDialog(context);
    }
  }

  void _showPermissionRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Required'),
          content: const Text(
            'This app needs camera access to scan documents. Please grant permission to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleScanButtonPressed(context); // Retry
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Denied'),
          content: const Text(
            'Camera permission has been permanently denied. Please enable it in Settings to use the document scanner.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner'),
        actions: [
          BlocBuilder<DocumentScannerBloc, DocumentScannerState>(
            builder: (context, state) {
              if (state.scannedImagePaths.isNotEmpty) {
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
              final count = state.scannedImagePaths.length;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document(s) scanned successfully! Total: $count'),
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
              initial: () => _buildMainView(context, state, 'Scan Document'),
              loading: () => _buildLoadingView(),
              success: () => _buildMainView(context, state, 'Scan Another Document'),
              failure: (error) => _buildMainView(context, state, 'Try Again'),
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

  Widget _buildMainView(BuildContext context, DocumentScannerState state, String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.document_scanner_outlined),
              label: Text(buttonText),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () => _handleScanButtonPressed(context),
            ),
          ),
          
          if (state.scannedImagePaths.isEmpty) ...[
            const SizedBox(height: 40),
            Icon(
              Icons.document_scanner,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No documents scanned yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the scan button to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ] else ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Scanned Documents (${state.scannedImagePaths.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear All'),
                  onPressed: () => _showClearAllDialog(context),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: _buildImageGrid(context, state.scannedImagePaths),
            ),
            
            // Save as FHIR Media button
            if (state.scannedImagePaths.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  onPressed: () => _showSaveFhirMediaDialog(context, state.scannedImagePaths),
                  icon: const Icon(Icons.save_alt),
                  label: Text('Save as FHIR Media (${state.scannedImagePaths.length})'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 65),
          ],
        ],
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context, List<String> imagePaths) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        final imagePath = imagePaths[index];
        return Card(
          elevation: 4,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _openImagePreview(context, imagePath, imagePaths, index),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'image_$index',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error, color: Colors.red, size: 40),
                                      Text('Failed to load', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white, size: 20),
                            onPressed: () => _showDeleteConfirmation(context, imagePath, index),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                        ),
                      ),
                      // View indicator overlay
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.visibility, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Tap to view',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Document ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSaveFhirMediaDialog(BuildContext context, List<String> imagePaths) async {
    final result = await showDialog<SaveFhirMediaResult>(
      context: context,
      builder: (context) => SaveFhirMediaDialog(
        documentCount: imagePaths.length,
      ),
    );
    
    if (result != null && context.mounted) {
      _saveFhirMedia(context, imagePaths, result);
    }
  }

  void _saveFhirMedia(BuildContext context, List<String> imagePaths, SaveFhirMediaResult result) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Saving to medical records...'),
          ],
        ),
      ),
    );

    try {
      final resourceIds = await _mediaIntegrationService.saveScannedImagesAsFhirRecords(
        imagePaths: imagePaths,
        patientId: result.patientId,
        sourceId: result.sourceId,
        encounterId: result.encounterId,
        title: result.title,
      );

      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show success dialog
      if (context.mounted) {
        _showSuccessDialog(context, resourceIds.length, result.patientId, result.encounterId);
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();

      // Show error dialog
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
    }
  }

  void _showSuccessDialog(BuildContext context, int count, String patientId, String? encounterId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Success!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Successfully saved $count document${count > 1 ? 's' : ''} to your medical records.'),
            const SizedBox(height: 8),
            Text('Patient: $patientId', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (encounterId != null)
              Text('Encounter: $encounterId', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'The documents will now appear in your Records timeline as Media resources.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
            Navigator.of(context).pop();
            context.read<DocumentScannerBloc>()
              ..add(const DocumentScannerEvent.clearAllDocuments())
              ..clearPersistentState();
          },
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.router.push(RecordsRoute());
            },
            child: const Text('View Records'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Failed to save documents as FHIR Media resources.'),
            const SizedBox(height: 8),
            Text(
              'Error: $error',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _openImagePreview(BuildContext context, String imagePath, List<String> allImages, int index) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePath: imagePath,
          title: 'Document ${index + 1}',
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

  void _showDeleteConfirmation(BuildContext context, String imagePath, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Document'),
          content: Text('Are you sure you want to delete Document ${index + 1}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<DocumentScannerBloc>().add(
                  DocumentScannerEvent.deleteDocument(imagePath: imagePath),
                );
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
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Documents'),
          content: const Text('Are you sure you want to delete all scanned documents?'),
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