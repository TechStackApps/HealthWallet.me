import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String>? allImages;
  final int? currentIndex;

  const ImagePreviewPage({
    super.key,
    required this.imagePath,
    this.title = 'Document Preview',
    this.allImages,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: currentIndex ?? 0,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          allImages != null 
            ? '${(currentIndex ?? 0) + 1} of ${allImages!.length}'
            : title,
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'info':
                  _showImageInfo(context, imagePath);
                  break;
                case 'delete':
                  _showDeleteConfirmation(context, imagePath);
                  break;
                case 'save_pdf':
                  _savePdfToDevice(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'info',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Image Info'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'save_pdf',
                child: ListTile(
                  leading: Icon(Icons.picture_as_pdf, color: Colors.orange),
                  title: Text('Save as PDF'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: allImages != null && allImages!.length > 1
          ? _buildPageView(pageController)
          : _buildSingleImage(),
    );
  }

  Widget _buildPageView(PageController pageController) {
    return PageView.builder(
      controller: pageController,
      itemCount: allImages!.length,
      itemBuilder: (context, index) {
        return _buildImageViewer(allImages![index]);
      },
    );
  }

  Widget _buildSingleImage() {
    return _buildImageViewer(imagePath);
  }

  Widget _buildImageViewer(String path) {
    return Center(
      child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 4.0,
        child: Image.file(
          File(path),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Path: $path',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showImageInfo(BuildContext context, String path) {
    final file = File(path);
    final fileName = path.split('/').last;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image Information'),
        content: FutureBuilder<FileStat>(
          future: file.stat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stat = snapshot.data!;
              final sizeInBytes = stat.size;
              final sizeInMB = (sizeInBytes / (1024 * 1024)).toStringAsFixed(2);
              final modified = stat.modified.toString().split('.').first;
              
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('File Name:', fileName),
                  _buildInfoRow('Size:', '$sizeInMB MB'),
                  _buildInfoRow('Modified:', modified),
                  _buildInfoRow('Path:', path),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String path) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: const Text('Are you sure you want to delete this document?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(true); // Return to previous screen with delete flag
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _savePdfToDevice(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Creating PDF...'),
          ],
        ),
      ),
    );

    try {
      final pdf = pw.Document();
      
      // Get all images or just the current one
      final List<String> imagesToSave = allImages ?? [imagePath];
      
      // Add each image as a page in the PDF
      for (final imagePath in imagesToSave) {
        final imageFile = File(imagePath);
        final imageBytes = await imageFile.readAsBytes();
        final image = pw.MemoryImage(imageBytes);
        
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image, fit: pw.BoxFit.contain),
              );
            },
          ),
        );
      }
      
      // Save PDF to downloads directory
      final directory = await getExternalStorageDirectory();
      final downloadsPath = '/storage/emulated/0/Download';
      final downloadsDir = Directory(downloadsPath);
      
      // Fallback to app directory if downloads not accessible
      final saveDir = await downloadsDir.exists() ? downloadsDir : directory!;
      
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'scanned_documents_$timestamp.pdf';
      final filePath = '${saveDir.path}/$fileName';
      
      final pdfFile = File(filePath);
      await pdfFile.writeAsBytes(await pdf.save());
      
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();
      
      // Show success dialog
      if (context.mounted) {
        _showPdfSuccessDialog(context, fileName, imagesToSave.length);
      }
      
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.of(context).pop();
      
      // Show error dialog
      if (context.mounted) {
        _showPdfErrorDialog(context, e.toString());
      }
    }
  }

  void _showPdfSuccessDialog(BuildContext context, String fileName, int pageCount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('PDF Saved!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Successfully created PDF with $pageCount page${pageCount > 1 ? 's' : ''}.'),
            const SizedBox(height: 8),
            Text('File: $fileName', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'The PDF has been saved to your device\'s Downloads folder.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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

  void _showPdfErrorDialog(BuildContext context, String error) {
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
            const Text('Failed to create PDF document.'),
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
}