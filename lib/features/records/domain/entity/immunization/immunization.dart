import 'package:freezed_annotation/freezed_annotation.dart';

part 'immunization.freezed.dart';
part 'immunization.g.dart';

@freezed
class Immunization with _$Immunization {
  const factory Immunization({
    required String name,
    required String date,
    String? lotNumber,
  }) = _Immunization;

  factory Immunization.fromJson(Map<String, dynamic> json) =>
      _$ImmunizationFromJson(json);
}
