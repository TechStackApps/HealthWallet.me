// services/pdf_storage_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class PdfStorageService {
  
  /// Save a PDF file to permanent storage and return the new path
  Future<String?> savePdfToStorage({
    required String sourcePdfPath,
    String? customFileName,
  }) async {
    try {
      // Request storage permission
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Check if source file exists
      final sourceFile = File(sourcePdfPath);
      if (!await sourceFile.exists()) {
        throw Exception('Source PDF file not found');
      }

      // Generate filename
      final fileName = customFileName ?? 'health_document_${DateTime.now().millisecondsSinceEpoch}.pdf';
      
      // Get the documents directory (permanent storage)
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/$fileName';

      // Copy the file to permanent storage
      await sourceFile.copy(newPath);

      print('PDF saved to permanent storage: $newPath');
      return newPath;

    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
  }

  /// Get all saved PDFs
  Future<List<String>> getSavedPdfs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync();
      
      return files
          .where((file) => file.path.toLowerCase().endsWith('.pdf'))
          .map((file) => file.path)
          .toList();
    } catch (e) {
      print('Error getting saved PDFs: $e');
      return [];
    }
  }

  /// Delete a saved PDF
  Future<bool> deletePdf(String pdfPath) async {
    try {
      final file = File(pdfPath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting PDF: $e');
      return false;
    }
  }

  /// Get PDF file info
  Future<Map<String, dynamic>> getPdfInfo(String pdfPath) async {
    try {
      final file = File(pdfPath);
      if (await file.exists()) {
        final stats = await file.stat();
        return {
          'name': file.path.split('/').last,
          'size': _formatFileSize(stats.size),
          'created': stats.modified,
          'path': pdfPath,
        };
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  /// Check and request storage permission
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      }
      
      final result = await Permission.storage.request();
      return result.isGranted;
    }
    
    // iOS doesn't require explicit storage permission for app documents
    return true;
  }

  /// Format file size in human-readable format
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}