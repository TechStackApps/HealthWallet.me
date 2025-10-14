import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/scan/data/dto/scan_dto.dart';

abstract class ScanLocalDataSource {
  Future<ScanDto> getCachedScan();
  Future<void> cacheScan(ScanDto scanDto);
}



