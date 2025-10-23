import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';

abstract class ScanRepository {
  // Document management
  Future<List<String>> scanDocuments();

  Future<List<String>> scanDocumentsAsPdf({int maxPages = 5});

  Future<List<String>> scanDocumentsDefault({int maxPages = 5});

  Future<String> saveScannedDocument(String sourcePath);

  Future<List<String>> getSavedDocuments();

  Future<void> deleteDocument(String imagePath);

  Future<void> clearAllDocuments();

  // Fhir Mapping
  Stream<double> downloadModel();

  Future<bool> checkModelExistence();

  Future<List<MappingResource>> mapResources(String medicalText);
}
