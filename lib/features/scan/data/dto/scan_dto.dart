import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:health_wallet/features/scan/domain/entity/scan.dart';

part 'scan_dto.freezed.dart';

@freezed
class ScanDto with _$ScanDto {
  const ScanDto._();

  const factory ScanDto() = _ScanDto;

  // factory DocumentScannerDto.fromJson(Map<String, dynamic> json) =>
  //     _$DocumentScannerDtoFromJson(json);

  factory ScanDto.fromEntity(Scan scan) => ScanDto();

  Scan toEntity() => Scan();
}
