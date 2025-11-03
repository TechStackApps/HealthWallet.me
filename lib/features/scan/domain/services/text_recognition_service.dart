import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

@injectable
class TextRecognitionService {
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  Future<String> recognizeTextFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );
      return recognizedText.text;
    } catch (e) {
      return 'Error recognizing text: ${e.toString()}';
    }
  }

  Future<String> recognizeTextFromXFile(XFile image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );
      return recognizedText.text;
    } catch (e) {
      return 'Error recognizing text: ${e.toString()}';
    }
  }

  Future<List<String>> convertPdfToImages(String pdfPath) async {
    try {
      final List<String> imagePaths = [];
      final tempDir = await getTemporaryDirectory();
      final bytes = await File(pdfPath).readAsBytes();
      int index = 1;
      const double dpi = 200; // higher DPI for better OCR fidelity
      await for (final page in Printing.raster(bytes, dpi: dpi)) {
        try {
          final pngBytes = await page.toPng();
          final decoded = img.decodePng(pngBytes);
          if (decoded == null) {
            throw Exception('Failed to decode PNG for page $index');
          }

          // Flatten any transparency onto a white background and save as PNG
          var whiteBg = img.Image(width: decoded.width, height: decoded.height);
          img.fill(whiteBg, color: img.ColorRgba8(255, 255, 255, 255));
          img.compositeImage(whiteBg, decoded);
          final pngOut = img.encodePng(whiteBg, level: 6);

          final tempFile = File(
            '${tempDir.path}/pdf_page_${DateTime.now().millisecondsSinceEpoch}_$index.png',
          );
          await tempFile.writeAsBytes(pngOut);
          imagePaths.add(tempFile.path);
        } catch (e) {
          // ignore per-page rasterization errors
        }
        index++;
      }
      return imagePaths;
    } catch (e) {
      return [];
    }
  }

  Future<String> extractTextFromPDF(String pdfPath) async {
    try {
      String allText = '';
      final textRecognizer = TextRecognizer();
      final tempDir = await getTemporaryDirectory();
      int index = 1;
      final bytes = await File(pdfPath).readAsBytes();
      await for (final page in Printing.raster(bytes, dpi: 144)) {
        File? tempFile;
        try {
          final png = await page.toPng();
          tempFile = File('${tempDir.path}/pdf_page_$index.png');
          await tempFile.writeAsBytes(png);
          final inputImage = InputImage.fromFilePath(tempFile.path);
          final recognizedText = await textRecognizer.processImage(inputImage);
          if (recognizedText.text.isNotEmpty) {
            allText += '--- Page $index ---\n';
            allText += recognizedText.text;
            allText += '\n\n';
          }
        } catch (e) {
          allText += '--- Page $index (Error) ---\n';
          allText += 'Error processing this page: $e\n\n';
        } finally {
          if (tempFile != null && await tempFile.exists()) {
            await tempFile.delete();
          }
        }
        index++;
      }
      await textRecognizer.close();

      if (allText.isNotEmpty) {
        return allText;
      } else {
        return 'No readable text found.';
      }
    } catch (e) {
      return 'Error processing PDF: ${e.toString()}';
    }
  }

  Future<List<String>> extractTextFromPDFPages(String pdfPath) async {
    try {
      final List<String> pageTexts = [];
      final textRecognizer = TextRecognizer();
      final tempDir = await getTemporaryDirectory();
      int index = 1;
      final bytes = await File(pdfPath).readAsBytes();
      await for (final page in Printing.raster(bytes, dpi: 144)) {
        File? tempFile;
        try {
          final png = await page.toPng();
          tempFile = File('${tempDir.path}/pdf_page_$index.png');
          await tempFile.writeAsBytes(png);
          final inputImage = InputImage.fromFilePath(tempFile.path);
          final recognizedText = await textRecognizer.processImage(inputImage);
          pageTexts.add(
            recognizedText.text.isNotEmpty
                ? recognizedText.text
                : 'No text found on this page',
          );
        } catch (e) {
          pageTexts.add('Error processing this page: $e');
        } finally {
          if (tempFile != null && await tempFile.exists()) {
            await tempFile.delete();
          }
        }
        index++;
      }
      await textRecognizer.close();
      return pageTexts;
    } catch (e) {
      return ['Error processing PDF: ${e.toString()}'];
    }
  }

  bool isPDF(String filePath) {
    return filePath.toLowerCase().endsWith('.pdf');
  }

  bool isImage(String filePath) {
    final imageExtensions = [
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.webp',
      '.tiff'
    ];
    final lowerPath = filePath.toLowerCase();
    return imageExtensions.any((ext) => lowerPath.endsWith(ext));
  }

  Future<String> extractTextFromFile(String filePath) async {
    if (isPDF(filePath)) {
      return await extractTextFromPDF(filePath);
    } else if (isImage(filePath)) {
      return await recognizeTextFromImage(filePath);
    } else {
      return 'Unsupported file type. Please select a PDF or image file.';
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}
