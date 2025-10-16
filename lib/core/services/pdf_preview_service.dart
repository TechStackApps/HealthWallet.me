import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@injectable
class PdfPreviewService {
  /// Preview PDF from FHIR Media resource
  Future<void> previewPdfFromResource(
    BuildContext context,
    IFhirResource resource,
  ) async {
    if (resource.fhirType != FhirType.Media) {
      _showErrorSnackBar(context, 'This resource is not a PDF file');
      return;
    }

    try {
      // Extract file path from Media resource
      final rawResource = resource.rawResource;
      final content = rawResource['content'];

      if (content == null) {
        _showErrorSnackBar(context, 'No file content found');
        return;
      }

      String? filePath;

      // Check if it's a URL reference
      if (content['url'] != null) {
        filePath = content['url'] as String;
      }

      // Check if it's base64 data - decode and save to temp file
      if (content['data'] != null) {
        final base64Data = content['data'] as String;
        filePath =
            await _saveBase64ToTempFile(base64Data, resource.displayTitle);
      }

      if (filePath == null) {
        _showErrorSnackBar(context, 'No file path found');
        return;
      }

      // Open the PDF file
      final result = await OpenFile.open(filePath);

      if (result.type != ResultType.done) {
        _showWarningSnackBar(context, 'Could not open PDF: ${result.message}');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening PDF: $e');
    }
  }

  /// Preview PDF from file path
  Future<void> previewPdfFromFile(
    BuildContext context,
    String filePath,
  ) async {
    try {
      final result = await OpenFile.open(filePath);

      if (result.type != ResultType.done) {
        _showWarningSnackBar(context, 'Could not open PDF: ${result.message}');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening PDF: $e');
    }
  }

  /// Save base64 data to a temporary file and return the file path
  Future<String> _saveBase64ToTempFile(
      String base64Data, String fileName) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final cleanFileName = fileName.replaceAll(RegExp(r'[^\w\s-.]'), '_');
      final tempFileName = '${cleanFileName}_$timestamp.pdf';
      final tempFilePath = path.join(tempDir.path, tempFileName);

      // Decode base64 data
      final bytes = base64Decode(base64Data);

      // Write to temporary file
      final file = File(tempFilePath);
      await file.writeAsBytes(bytes);

      return tempFilePath;
    } catch (e) {
      throw Exception('Failed to save base64 data to temp file: $e');
    }
  }

  /// Show error snackbar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Show warning snackbar
  void _showWarningSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
