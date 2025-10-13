// pdf_generation_service.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;

@injectable
class PdfGenerationService {
  Future<String> createPdfFromImages({
    required List<String> imagePaths,
    required String fileName,
    String? title,
  }) async {
    if (imagePaths.isEmpty) {
      throw Exception('No images provided for PDF creation');
    }

    try {
      final pdf = pw.Document();

      for (int i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];
        final file = File(imagePath);

        if (!await file.exists()) {
          continue;
        }

        final imageBytes = await file.readAsBytes();
        final image = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(20),
            build: (pw.Context context) {
              return pw.Container(
                width: double.infinity,
                height: double.infinity,
                child: pw.Image(
                  image,
                  fit: pw.BoxFit.contain,
                ),
              );
            },
          ),
        );
      }

      // Save PDF to temporary directory
      final tempDir = await getTemporaryDirectory();
      final pdfPath = path.join(tempDir.path, '$fileName.pdf');
      final pdfFile = File(pdfPath);

      final pdfBytes = await pdf.save();
      await pdfFile.writeAsBytes(pdfBytes);

      return pdfPath;
    } catch (e) {
      throw Exception('Failed to create PDF from images: $e');
    }
  }

  Future<String> copyPdfWithNewName({
    required String sourcePdfPath,
    required String fileName,
  }) async {
    try {
      final sourceFile = File(sourcePdfPath);

      if (!await sourceFile.exists()) {
        throw Exception('Source PDF not found: $sourcePdfPath');
      }

      final tempDir = await getTemporaryDirectory();
      final newPdfPath = path.join(tempDir.path, '$fileName.pdf');
      final newPdfFile = File(newPdfPath);

      await sourceFile.copy(newPdfPath);

      return newPdfPath;
    } catch (e) {
      throw Exception('Failed to copy PDF: $e');
    }
  }

  Future<List<DocumentGroup>> groupAndConvertDocuments({
    required List<String> scannedImages,
    required List<String> importedImages,
    required List<String> importedPdfs,
  }) async {
    final List<DocumentGroup> groups = [];

    try {
      if (scannedImages.isNotEmpty) {
        final pdfPath = await createPdfFromImages(
          imagePaths: scannedImages,
          fileName: 'scanned_documents_${_generateId()}',
          title: 'Scanned Documents',
        );

        groups.add(DocumentGroup(
          type: DocumentGroupType.scannedImages,
          pdfPath: pdfPath,
          title: 'Scanned Documents (${scannedImages.length} pages)',
          originalCount: scannedImages.length,
        ));
      }

      if (importedImages.isNotEmpty) {
        final pdfPath = await createPdfFromImages(
          imagePaths: importedImages,
          fileName: 'imported_images_${_generateId()}',
          title: 'Imported Images',
        );

        groups.add(DocumentGroup(
          type: DocumentGroupType.importedImages,
          pdfPath: pdfPath,
          title: 'Imported Images (${importedImages.length} images)',
          originalCount: importedImages.length,
        ));
      }

      for (int i = 0; i < importedPdfs.length; i++) {
        final originalPdfPath = importedPdfs[i];
        final fileName = path.basenameWithoutExtension(originalPdfPath);

        final pdfPath = await copyPdfWithNewName(
          sourcePdfPath: originalPdfPath,
          fileName: 'pdf_${_generateId()}_$fileName',
        );

        groups.add(DocumentGroup(
          type: DocumentGroupType.importedPdf,
          pdfPath: pdfPath,
          title: 'PDF: $fileName',
          originalCount: 1,
        ));
      }

      return groups;
    } catch (e) {
      throw Exception('Failed to group and convert documents: $e');
    }
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

enum DocumentGroupType {
  scannedImages,
  importedImages,
  importedPdf,
}

class DocumentGroup {
  final DocumentGroupType type;
  final String pdfPath;
  final String title;
  final int originalCount;

  const DocumentGroup({
    required this.type,
    required this.pdfPath,
    required this.title,
    required this.originalCount,
  });
}
