import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

@freezed
class Patient with _$Patient {
  factory Patient({
    required String id,
    List<HumanName>? name,
    String? gender,
    DateTime? birthDate,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
}

@freezed
class HumanName with _$HumanName {
  factory HumanName({
    String? family,
    List<String>? given,
  }) = _HumanName;

  factory HumanName.fromJson(Map<String, dynamic> json) =>
      _$HumanNameFromJson(json);
}

class HumanNameConverter
    implements JsonConverter<HumanName, Map<String, dynamic>> {
  const HumanNameConverter();

  @override
  HumanName fromJson(Map<String, dynamic> json) => HumanName.fromJson(json);

  @override
  Map<String, dynamic> toJson(HumanName object) => object.toJson();
}
