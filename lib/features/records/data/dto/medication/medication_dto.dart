import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/medication/medication.dart';

part 'medication_dto.freezed.dart';
part 'medication_dto.g.dart';

@freezed
class MedicationDto with _$MedicationDto {
  const factory MedicationDto({
    required String name,
    required String dosage,
    required String frequency,
    String? reason,
  }) = _MedicationDto;

  factory MedicationDto.fromDomain(Medication medication) {
    return MedicationDto(
      name: medication.name,
      dosage: medication.dosage,
      frequency: medication.frequency,
      reason: medication.reason,
    );
  }

  factory MedicationDto.fromJson(Map<String, dynamic> json) =>
      _$MedicationDtoFromJson(json);
}

extension MedicationDtoX on MedicationDto {
  Medication toDomain() {
    return Medication(
      name: name,
      dosage: dosage,
      frequency: frequency,
      reason: reason,
    );
  }
}
