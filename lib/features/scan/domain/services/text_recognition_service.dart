import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:pdf_to_image_converter/pdf_to_image_converter.dart';
import 'package:path_provider/path_provider.dart';

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
      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      List<String> imagePaths = [];
      final tempDir = await getTemporaryDirectory();

      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        try {
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            final tempFile = File(
              '${tempDir.path}/pdf_page_${DateTime.now().millisecondsSinceEpoch}_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            imagePaths.add(tempFile.path);
          } else {}
        } catch (e) {}
      }

      await converter.closePdf();

      return imagePaths;
    } catch (e) {
      return [];
    }
  }

  Future<String> extractTextFromPDF(String pdfPath) async {
    try {
      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      String allText = '';
      final textRecognizer = TextRecognizer();

      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        try {
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            final tempDir = await getTemporaryDirectory();
            final tempFile = File(
              '${tempDir.path}/pdf_page_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            final inputImage = InputImage.fromFilePath(tempFile.path);

            final recognizedText = await textRecognizer.processImage(
              inputImage,
            );

            if (await tempFile.exists()) {
              await tempFile.delete();
            }

            if (recognizedText.text.isNotEmpty) {
              allText += '--- Page ${pageIndex + 1} ---\n';
              allText += recognizedText.text;
              allText += '\n\n';
            } else {}
          } else {}
        } catch (e) {
          allText += '--- Page ${pageIndex + 1} (Error) ---\n';
          allText += 'Error processing this page: $e\n\n';
        }
      }

      await converter.closePdf();
      await textRecognizer.close();

      if (allText.isNotEmpty) {
        return '''📸 PDF Text Extracted via Image OCR

File Details:
• Path: $pdfPath
• Pages: ${converter.pageCount}
• Text Length: ${allText.length} characters

Processing Method:
PDF converted to images using pdf_to_image_converter
Each page processed with Google ML Kit text recognition
Text combined from all pages

Extracted Text:
────────────────────────────────────────

$allText

────────────────────────────────────────

Text extraction completed successfully using PDF-to-image-to-OCR pipeline.''';
      } else {
        return '''📸 PDF Text Extraction Complete

File Details:
• Path: $pdfPath
• Pages: ${converter.pageCount}

Processing Method:
✅ PDF converted to images using pdf_to_image_converter
✅ Each page processed with Google ML Kit text recognition

Result: No readable text found in this PDF.

This could mean:
• The PDF contains only images/scanned content with no readable text
• The images are too low quality for OCR
• The text is in a language not well supported by ML Kit

Try with a higher quality PDF or different document.''';
      }
    } catch (e) {
      return '''PDF Text Extraction Error

File Details:
• Path: $pdfPath

Error: ${e.toString()}

This could be due to:
• Corrupted PDF file
• Unsupported PDF format
• File access issues
• PDF encryption/protection

Please try with a different PDF file.''';
    }
  }

  Future<List<String>> extractTextFromPDFPages(String pdfPath) async {
    try {
      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      List<String> pageTexts = [];
      final textRecognizer = TextRecognizer();

      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        try {
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            final tempDir = await getTemporaryDirectory();
            final tempFile = File(
              '${tempDir.path}/pdf_page_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            final inputImage = InputImage.fromFilePath(tempFile.path);

            final recognizedText = await textRecognizer.processImage(
              inputImage,
            );

            if (await tempFile.exists()) {
              await tempFile.delete();
            }

            pageTexts.add(
              recognizedText.text.isNotEmpty
                  ? recognizedText.text
                  : 'No text found on this page',
            );
          } else {
            pageTexts.add('Failed to process this page');
          }
        } catch (e) {
          pageTexts.add('Error processing this page: $e');
        }
      }

      await converter.closePdf();
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
