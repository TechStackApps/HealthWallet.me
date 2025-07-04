import 'package:freezed_annotation/freezed_annotation.dart';

part 'medication.freezed.dart';
part 'medication.g.dart';

@freezed
class Medication with _$Medication {
  const factory Medication({
    required String name,
    required String dosage,
    required String frequency,
    String? reason,
  }) = _Medication;

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);
}
