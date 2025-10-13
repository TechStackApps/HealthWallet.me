import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'patient_record.freezed.dart';

@freezed
class PatientRecord with _$PatientRecord {
  const PatientRecord._(); // Private constructor for getters

  const factory PatientRecord({
    @Default('') String id,
    @Default('') String patientId,
    String? sourceId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PatientRecord;

  factory PatientRecord.fromDto(PatientRecordDto dto) => PatientRecord(
        id: dto.id,
        patientId: dto.patientId,
        sourceId: dto.sourceId,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
      );
}
