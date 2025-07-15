import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergy.freezed.dart';
part 'allergy.g.dart';

@freezed
class Allergy with _$Allergy {
  const factory Allergy({
    required String dateRecorded,
    required String allergyType,
    required String allergicTo,
    String? reaction,
    required String onset,
    String? resolutionAge,
  }) = _Allergy;

  factory Allergy.fromJson(Map<String, dynamic> json) =>
      _$AllergyFromJson(json);
}
