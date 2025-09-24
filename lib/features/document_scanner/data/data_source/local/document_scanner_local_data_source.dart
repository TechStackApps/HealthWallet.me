import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/document_scanner/data/dto/document_scanner_dto.dart';

abstract class DocumentScannerLocalDataSource {
  Future<DocumentScannerDto> getCachedDocumentScanner();
  Future<void> cacheDocumentScanner(DocumentScannerDto documentScannerDto);
}

// @LazySingleton(as: DocumentScannerLocalDataSource)
// class DocumentScannerLocalDataSourceImpl
//     implements DocumentScannerLocalDataSource {
//   DocumentScannerLocalDataSourceImpl();

//   @override
//   Future<DocumentScannerDto> getCachedDocumentScanner() async {}

//   @override
//   Future<void> cacheDocumentScanner(
//       DocumentScannerDto documentScannerDto) async {}
// }
