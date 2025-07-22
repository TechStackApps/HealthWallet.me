import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/patient/patient.dart';

part 'practitioner.freezed.dart';
part 'practitioner.g.dart';

@freezed
class Practitioner with _$Practitioner {
  factory Practitioner({
    required String id,
    @HumanNameConverter() List<HumanName>? name,
    String? gender,
  }) = _Practitioner;

  factory Practitioner.fromJson(Map<String, dynamic> json) =>
      _$PractitionerFromJson(json);
}
