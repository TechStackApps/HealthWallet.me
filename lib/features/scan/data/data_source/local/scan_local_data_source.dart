import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/scan/data/dto/scan_dto.dart';

abstract class ScanLocalDataSource {
  Future<ScanDto> getCachedScan();
  Future<void> cacheScan(ScanDto scanDto);
}

// @LazySingleton(as: ScanLocalDataSource)
// class ScanLocalDataSourceImpl
//     implements ScanLocalDataSource {
//   DocumentScannerLocalDataSourceImpl();

//   @override
//   Future<ScanDto> getCachedScan() async {}

//   @override
//   Future<void> cacheScan(
//       ScanDto scanDto) async {}
// }
