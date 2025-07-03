import 'package:freezed_annotation/freezed_annotation.dart';

part 'lab_result.freezed.dart';
part 'lab_result.g.dart';

@freezed
class LabResult with _$LabResult {
  const factory LabResult({
    required String name,
    required String date,
    required String value,
    required String unit,
    String? referenceRange,
  }) = _LabResult;

  factory LabResult.fromJson(Map<String, dynamic> json) =>
      _$LabResultFromJson(json);
}
