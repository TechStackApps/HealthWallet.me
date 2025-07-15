import 'package:freezed_annotation/freezed_annotation.dart';

part 'condition.freezed.dart';
part 'condition.g.dart';

@freezed
class Condition with _$Condition {
  const factory Condition({
    required String name,
    required String dateOfDiagnosis,
    String? status,
  }) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}
