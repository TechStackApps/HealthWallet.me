import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'record_attachment.freezed.dart';

@freezed
class RecordAttachment with _$RecordAttachment {
  const factory RecordAttachment({
    @Default(0) int id,
    @Default('') String resourceId,
    required File file,
    required DateTime timestamp,
  }) = _RecordAttachment;

  factory RecordAttachment.fromDto(RecordAttachmentDto dto) => RecordAttachment(
        id: dto.id,
        resourceId: dto.resourceId,
        file: File(dto.filePath),
        timestamp: dto.timestamp,
      );

}
