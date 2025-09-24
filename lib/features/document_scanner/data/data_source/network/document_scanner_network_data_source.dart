import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/document_scanner/data/dto/document_scanner_dto.dart';

abstract class DocumentScannerNetworkDataSource {
  Future<DocumentScannerDto> fetchDocumentScanner();
}

// @LazySingleton(as: DocumentScannerNetworkDataSource)
// class DocumentScannerNetworkDataSourceImpl
//     implements DocumentScannerNetworkDataSource {
//   DocumentScannerNetworkDataSourceImpl();

//   @override
//   Future<DocumentScannerDto> fetchDocumentScanner() async {}
// }
