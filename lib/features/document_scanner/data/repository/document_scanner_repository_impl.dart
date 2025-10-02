// health_wallet/features/document_scanner/data/repository/document_scanner_repository_impl.dart

import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:health_wallet/features/document_scanner/domain/repository/document_scanner_repository.dart';

@LazySingleton(as: DocumentScannerRepository)
class DocumentScannerRepositoryImpl implements DocumentScannerRepository {
  
  @override
  Future<List<String>> scanDocuments() async {
    try {
      
      // Use getScannedDocumentAsImages for consistent image output
      final scannedResult = await FlutterDocScanner().getScannedDocumentAsImages(
        page: 10, // Allow up to 10 pages
      );
      
      if (scannedResult == null) {
        return [];
      }
      
      List<String> imagePaths = [];
      
      // Handle different return types
      if (scannedResult is List) {
        imagePaths = scannedResult.cast<String>();
      } else if (scannedResult is String) {
        // Check if it's an error message
        if (scannedResult.contains('Failed') || 
            scannedResult.contains('Unknown') ||
            scannedResult.contains('platform documents')) {
          throw Exception('Scanner error: $scannedResult');
        }
        imagePaths = [scannedResult];
      } else {
        imagePaths = [scannedResult.toString()];
      }
      
      // Filter out any invalid paths
      final validPaths = imagePaths.where((path) => 
        path.isNotEmpty && 
        !path.contains('Failed') && 
        !path.contains('Unknown')
      ).toList();
      
      return validPaths;
      
    } on PlatformException catch (e) {
      throw Exception('Scanner platform error: ${e.message ?? e.code}');
    } catch (e) {
      throw Exception('Failed to scan documents: $e');
    }
  }

  @override
  Future<List<String>> scanDocumentsAsPdf({int maxPages = 5}) async {
    try {      
      final scannedResult = await FlutterDocScanner().getScannedDocumentAsPdf(
        page: maxPages,
      );
      
      if (scannedResult == null) {
        return [];
      }
      
      if (scannedResult is String && 
          (scannedResult.contains('Failed') || scannedResult.contains('Unknown'))) {
        throw Exception('PDF scanner error: $scannedResult');
      }
      
      final pdfPath = scannedResult.toString();
      return [pdfPath];
      
    } on PlatformException catch (e) {
      throw Exception('PDF Scanner platform error: ${e.message ?? e.code}');
    } catch (e) {
      throw Exception('Failed to scan PDF documents: $e');
    }
  }

  @override
  Future<List<String>> scanDocumentsDefault({int maxPages = 5}) async {
    try {
      final scannedResult = await FlutterDocScanner().getScanDocuments(
        page: maxPages,
      );
      
      if (scannedResult == null) {
        return [];
      }
      
      List<String> documentPaths = [];
      
      if (scannedResult is List) {
        documentPaths = scannedResult.cast<String>();
      } else if (scannedResult is String) {
        if (scannedResult.contains('Failed') || scannedResult.contains('Unknown')) {
          throw Exception('Default scanner error: $scannedResult');
        }
        documentPaths = [scannedResult];
      } else {
        documentPaths = [scannedResult.toString()];
      }
      
      final validPaths = documentPaths.where((path) => 
        path.isNotEmpty && 
        !path.contains('Failed') && 
        !path.contains('Unknown')
      ).toList();
      
      return validPaths;
      
    } on PlatformException catch (e) {
      throw Exception('Default Scanner platform error: ${e.message ?? e.code}');
    } catch (e) {
      throw Exception('Failed to scan documents in default mode: $e');
    }
  }

  @override
  Future<String> saveScannedDocument(String sourcePath) async {
    try {      
      final directory = await getApplicationDocumentsDirectory();
      final scanDir = Directory(path.join(directory.path, 'scanned_documents'));
      
      if (!await scanDir.exists()) {
        await scanDir.create(recursive: true);
      }
      
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        throw Exception('Source file does not exist: $sourcePath');
      }
      
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(sourcePath);
      final newFileName = 'document_$timestamp$extension';
      final newPath = path.join(scanDir.path, newFileName);
      
      await sourceFile.copy(newPath);
      
      return newPath;
    } catch (e) {
      throw Exception('Failed to save document: $e');
    }
  }

  @override
  Future<List<String>> getSavedDocuments() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final scanDir = Directory(path.join(directory.path, 'scanned_documents'));
      
      if (!await scanDir.exists()) {
        return [];
      }
      
      final files = await scanDir
          .list()
          .where((entity) => entity is File)
          .cast<File>()
          .toList();
      
      final documentPaths = files
          .map((file) => file.path)
          .where((path) => _isValidDocumentFile(path))
          .toList();
      
      // Sort by modification date (newest first)
      documentPaths.sort((a, b) {
        final aFile = File(a);
        final bFile = File(b);
        return bFile.lastModifiedSync().compareTo(aFile.lastModifiedSync());
      });
      
      return documentPaths;
      
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> deleteDocument(String imagePath) async {
    try {      
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      } else {
        print('⚠️ Repository: File does not exist, cannot delete: $imagePath');
      }
    } catch (e) {
      throw Exception('Failed to delete document: $e');
    }
  }

 @override
Future<void> clearAllDocuments({
  List<String>? scannedImagePaths,
  List<String>? importedImagePaths,
  List<String>? importedPdfPaths,
}) async {
  try {
    // Delete scanned images directory (original approach)
    final directory = await getApplicationDocumentsDirectory();
    final scanDir = Directory(path.join(directory.path, 'scanned_documents'));
    
    if (await scanDir.exists()) {
      await scanDir.delete(recursive: true);
      print('✓ Deleted scanned documents directory');
    }

    // Delete specific imported images
    if (importedImagePaths != null) {
      for (var imagePath in importedImagePaths) {
        try {
          final file = File(imagePath);
          if (await file.exists()) {
            await file.delete();
            print('✓ Deleted imported image: $imagePath');
          }
        } catch (e) {
          print('⚠️ Failed to delete imported image: $imagePath - $e');
        }
      }
    }

    // Delete specific imported PDFs
    if (importedPdfPaths != null) {
      for (var pdfPath in importedPdfPaths) {
        try {
          final file = File(pdfPath);
          if (await file.exists()) {
            await file.delete();
            print('✓ Deleted imported PDF: $pdfPath');
          }
        } catch (e) {
          print('⚠️ Failed to delete imported PDF: $pdfPath - $e');
        }
      }
    }

  } catch (e) {
    throw Exception('Failed to clear all documents: $e');
  }
}

bool _isValidDocumentFile(String filePath) {
  final extension = path.extension(filePath).toLowerCase();
  return extension == '.jpg' || 
         extension == '.jpeg' || 
         extension == '.png' || 
         extension == '.pdf';
}
}