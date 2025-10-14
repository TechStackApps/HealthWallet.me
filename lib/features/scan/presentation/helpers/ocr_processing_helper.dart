import 'package:health_wallet/features/scan/domain/services/text_recognition_service.dart';

class OcrProcessingHelper {
  final TextRecognitionService _textRecognitionService;

  OcrProcessingHelper({TextRecognitionService? textRecognitionService})
      : _textRecognitionService =
            textRecognitionService ?? TextRecognitionService();


  Future<List<String>> convertPdfsToImages(List<String> pdfPaths) async {
    final convertedImages = <String>[];

    for (final pdfPath in pdfPaths) {
      final images = await _textRecognitionService.convertPdfToImages(pdfPath);
      convertedImages.addAll(images);
    }

    return convertedImages;
  }


  Future<List<String>> processOcrForImages(List<String> imagePaths) async {
    final pageTexts = <String>[];

    for (int i = 0; i < imagePaths.length; i++) {
      final imagePath = imagePaths[i];

      final text =
          await _textRecognitionService.recognizeTextFromImage(imagePath);

      if (text.isNotEmpty && !text.startsWith('Error recognizing text:')) {
        pageTexts.add(text);
      } else {
        pageTexts.add('No text could be extracted from this page.');
      }
    }

    return pageTexts;
  }


  Future<List<String>> prepareAllImages({
    required List<String> scannedImages,
    required List<String> importedImages,
    required List<String> importedPdfs,
  }) async {
    final allImages = <String>[];


    allImages.addAll(scannedImages);
    allImages.addAll(importedImages);


    if (importedPdfs.isNotEmpty) {
      try {
        final convertedImages = await convertPdfsToImages(importedPdfs);
        allImages.addAll(convertedImages);
      } catch (e) {

      }
    }

    return allImages;
  }
}
