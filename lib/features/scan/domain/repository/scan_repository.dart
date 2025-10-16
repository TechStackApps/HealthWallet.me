abstract class ScanRepository {
  Future<List<String>> scanDocuments();

  Future<List<String>> scanDocumentsAsPdf({int maxPages = 5});

  Future<List<String>> scanDocumentsDefault({int maxPages = 5});

  Future<String> saveScannedDocument(String sourcePath);

  Future<List<String>> getSavedDocuments();

  Future<void> deleteDocument(String imagePath);

  Future<void> clearAllDocuments();
}
