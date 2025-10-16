import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'record_note.freezed.dart';

@freezed
class RecordNote with _$RecordNote {
  const RecordNote._(); // Private constructor for getters

  const factory RecordNote({
    @Default(0) int id,
    @Default('') String patientRecordId,
    @Default('') String content,
    required DateTime timestamp,
  }) = _RecordNote;

  factory RecordNote.fromDto(RecordNoteDto dto) => RecordNote(
        id: dto.id,
        patientRecordId: dto.patientRecordId,
        content: dto.content,
        timestamp: dto.timestamp,
      );
}
