import 'dart:io';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'record_attachment.freezed.dart';

@freezed
class RecordAttachment with _$RecordAttachment {
  const RecordAttachment._(); // Private constructor for getters

  const factory RecordAttachment({
    @Default(0) int id,
    @Default('') String patientRecordId,
    @Default('') String mediaId,
    @Default('completed') String status,
    @Default('') String contentType,
    String? title,
    int? size,
    Uint8List? data, // Base64 decoded data
    String? filePath,
    String? subjectReference,
    String? encounterReference,
    @Default('document') String mediaType,
    String? mediaSubtype,
    String? identifierSystem,
    String? identifierValue,
    @Default('usual') String identifierUse,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RecordAttachment;

  factory RecordAttachment.fromDto(RecordAttachmentDto dto) => RecordAttachment(
        id: dto.id,
        patientRecordId: dto.patientRecordId,
        mediaId: dto.mediaId,
        status: dto.status,
        contentType: dto.contentType,
        title: dto.title,
        size: dto.size,
        data: dto.data,
        filePath: dto.filePath,
        subjectReference: dto.subjectReference,
        encounterReference: dto.encounterReference,
        mediaType: dto.mediaType,
        mediaSubtype: dto.mediaSubtype,
        identifierSystem: dto.identifierSystem,
        identifierValue: dto.identifierValue,
        identifierUse: dto.identifierUse,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
      );

  /// Get the file as a File object if filePath is available
  File? get file {
    if (filePath != null && filePath!.isNotEmpty) {
      return File(filePath!);
    }
    return null;
  }

  /// Check if this attachment has file data stored as BLOB
  bool get hasData => data != null && data!.isNotEmpty;

  /// Check if this attachment has a file path
  bool get hasFilePath => filePath != null && filePath!.isNotEmpty;

  /// Get display name for the attachment
  String get displayName {
    if (title != null && title!.isNotEmpty) {
      return title!;
    }
    if (filePath != null) {
      return filePath!.split('/').last;
    }
    return 'Attachment $id';
  }

  /// Get file extension from content type or file path
  String get fileExtension {
    if (filePath != null) {
      return filePath!.split('.').last.toLowerCase();
    }

    switch (contentType.toLowerCase()) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'application/pdf':
        return 'pdf';
      default:
        return 'bin';
    }
  }
}
