import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/scan/data/dto/scan_dto.dart';

abstract class ScanNetworkDataSource {
  Future<ScanDto> fetchScan();
}

// @LazySingleton(as: ScanNetworkDataSource)
// class ScanNetworkDataSourceImpl
//     implements ScanNetworkDataSource {
//   DocumentScannerNetworkDataSourceImpl();

//   @override
//   Future<ScanDto> fetchScan() async {}
// }
