import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:health_wallet/features/document_scanner/domain/entity/document_scanner.dart';

part 'document_scanner_dto.freezed.dart';

@freezed
class DocumentScannerDto with _$DocumentScannerDto {
  const DocumentScannerDto._();

  const factory DocumentScannerDto() = _DocumentScannerDto;

  // factory DocumentScannerDto.fromJson(Map<String, dynamic> json) =>
  //     _$DocumentScannerDtoFromJson(json);

  factory DocumentScannerDto.fromEntity(DocumentScanner documentScanner) =>
      DocumentScannerDto();

  DocumentScanner toEntity() => DocumentScanner();
}
