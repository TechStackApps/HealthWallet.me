// health_wallet/features/document_scanner/domain/repository/document_scanner_repository.dart

abstract class DocumentScannerRepository {
  /// Scan documents and return as image files
  Future<List<String>> scanDocuments();
  
  /// Scan documents and return as PDF
  Future<List<String>> scanDocumentsAsPdf({int maxPages = 5});
  
  /// Scan documents using default mode (PDF on Android, Images on iOS)
  Future<List<String>> scanDocumentsDefault({int maxPages = 5});
  
  /// Save a scanned document to persistent storage
  /// Returns the new file path
  Future<String> saveScannedDocument(String sourcePath);
  
  /// Get list of all saved documents
  Future<List<String>> getSavedDocuments();
  
  /// Delete a specific document
  Future<void> deleteDocument(String imagePath);
  
  /// Clear all saved documents
  Future<void> clearAllDocuments();
}