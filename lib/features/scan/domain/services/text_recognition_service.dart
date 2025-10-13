import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_to_image_converter/pdf_to_image_converter.dart';
import 'package:path_provider/path_provider.dart';

class TextRecognitionService {
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  /// Extract text from an image file
  Future<String> recognizeTextFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );
      return recognizedText.text;
    } catch (e) {
      print('Error recognizing text from image: $e');
      return 'Error recognizing text: ${e.toString()}';
    }
  }

  /// Extract text from an XFile (from image picker)
  Future<String> recognizeTextFromXFile(XFile image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );
      return recognizedText.text;
    } catch (e) {
      print('Error recognizing text from XFile: $e');
      return 'Error recognizing text: ${e.toString()}';
    }
  }

  /// Convert PDF to images and return the image file paths
  Future<List<String>> convertPdfToImages(String pdfPath) async {
    try {
      print('Converting PDF to images: $pdfPath');

      // Step 1: Convert PDF to images using pdf_to_image_converter
      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      print('PDF opened successfully. Pages: ${converter.pageCount}');

      List<String> imagePaths = [];
      final tempDir = await getTemporaryDirectory();

      // Step 2: Convert each page to image and save to temporary files
      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        print('Converting page ${pageIndex + 1}/${converter.pageCount}');

        try {
          // Convert PDF page to image
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            print(
              'Page ${pageIndex + 1} converted to image (${imageBytes.length} bytes)',
            );

            // Save image bytes to temporary file
            final tempFile = File(
              '${tempDir.path}/pdf_page_${DateTime.now().millisecondsSinceEpoch}_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            print('Saved page ${pageIndex + 1} image to: ${tempFile.path}');
            imagePaths.add(tempFile.path);
          } else {
            print('Failed to convert page ${pageIndex + 1} to image');
          }
        } catch (e) {
          print('Error converting page ${pageIndex + 1}: $e');
        }
      }

      // Clean up
      await converter.closePdf();

      print('Successfully converted PDF to ${imagePaths.length} images');
      return imagePaths;
    } catch (e) {
      print('Error converting PDF to images: $e');
      return [];
    }
  }

  /// Convert PDF to images and extract text using Google ML Kit
  Future<String> extractTextFromPDF(String pdfPath) async {
    try {
      print('Converting PDF to images: $pdfPath');

      // Step 1: Convert PDF to images using pdf_to_image_converter
      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      print('PDF opened successfully. Pages: ${converter.pageCount}');

      String allText = '';
      final textRecognizer = TextRecognizer();

      // Step 2: Process each page as an image with Google ML Kit
      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        print('Processing page ${pageIndex + 1}/${converter.pageCount}');

        try {
          // Convert PDF page to image
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            print(
              'Page ${pageIndex + 1} converted to image (${imageBytes.length} bytes)',
            );

            // Save image bytes to temporary file and use InputImage.fromFilePath
            final tempDir = await getTemporaryDirectory();
            final tempFile = File(
              '${tempDir.path}/pdf_page_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            print('Saved page ${pageIndex + 1} image to: ${tempFile.path}');

            // Use InputImage.fromFilePath which is more reliable
            final inputImage = InputImage.fromFilePath(tempFile.path);

            final recognizedText = await textRecognizer.processImage(
              inputImage,
            );

            print('ML Kit processing result for page ${pageIndex + 1}:');
            print('- Text length: ${recognizedText.text.length}');
            print('- Blocks count: ${recognizedText.blocks.length}');

            // Clean up temporary file
            if (await tempFile.exists()) {
              await tempFile.delete();
            }

            if (recognizedText.text.isNotEmpty) {
              allText += '--- Page ${pageIndex + 1} ---\n';
              allText += recognizedText.text;
              allText += '\n\n';
              print(
                'Extracted ${recognizedText.text.length} characters from page ${pageIndex + 1}',
              );
            } else {
              print('No text found on page ${pageIndex + 1}');
            }
          } else {
            print('Failed to convert page ${pageIndex + 1} to image');
          }
        } catch (e) {
          print('Error processing page ${pageIndex + 1}: $e');
          allText += '--- Page ${pageIndex + 1} (Error) ---\n';
          allText += 'Error processing this page: $e\n\n';
        }
      }

      // Clean up
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
      print('Error extracting text from PDF: $e');
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

  /// Extract text from PDF pages individually for page-by-page comparison
  Future<List<String>> extractTextFromPDFPages(String pdfPath) async {
    try {
      print('Extracting text from PDF pages individually: $pdfPath');

      final converter = PdfImageConverter();
      await converter.openPdf(pdfPath);

      print('PDF opened successfully. Pages: ${converter.pageCount}');

      List<String> pageTexts = [];
      final textRecognizer = TextRecognizer();

      // Process each page individually
      for (int pageIndex = 0; pageIndex < converter.pageCount; pageIndex++) {
        print('Processing page ${pageIndex + 1}/${converter.pageCount}');

        try {
          // Convert PDF page to image
          final imageBytes = await converter.renderPage(pageIndex);

          if (imageBytes != null && imageBytes.isNotEmpty) {
            print(
              'Page ${pageIndex + 1} converted to image (${imageBytes.length} bytes)',
            );

            // Save image bytes to temporary file and use InputImage.fromFilePath
            final tempDir = await getTemporaryDirectory();
            final tempFile = File(
              '${tempDir.path}/pdf_page_${pageIndex + 1}.png',
            );
            await tempFile.writeAsBytes(imageBytes);

            print('Saved page ${pageIndex + 1} image to: ${tempFile.path}');

            // Use InputImage.fromFilePath which is more reliable
            final inputImage = InputImage.fromFilePath(tempFile.path);

            final recognizedText = await textRecognizer.processImage(
              inputImage,
            );

            print('ML Kit processing result for page ${pageIndex + 1}:');
            print('- Text length: ${recognizedText.text.length}');
            print('- Blocks count: ${recognizedText.blocks.length}');

            // Clean up temporary file
            if (await tempFile.exists()) {
              await tempFile.delete();
            }

            // Add page text to list
            pageTexts.add(
              recognizedText.text.isNotEmpty
                  ? recognizedText.text
                  : 'No text found on this page',
            );

            print(
              'Extracted ${recognizedText.text.length} characters from page ${pageIndex + 1}',
            );
          } else {
            print('Failed to convert page ${pageIndex + 1} to image');
            pageTexts.add('Failed to process this page');
          }
        } catch (e) {
          print('Error processing page ${pageIndex + 1}: $e');
          pageTexts.add('Error processing this page: $e');
        }
      }

      // Clean up
      await converter.closePdf();
      await textRecognizer.close();

      print('Extracted text from ${pageTexts.length} pages');
      return pageTexts;
    } catch (e) {
      print('Error extracting text from PDF pages: $e');
      return ['Error processing PDF: ${e.toString()}'];
    }
  }

  /// Check if file is a PDF
  bool isPDF(String filePath) {
    return filePath.toLowerCase().endsWith('.pdf');
  }

  /// Check if file is an image
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

  /// Extract text from any file (PDF or image)
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
