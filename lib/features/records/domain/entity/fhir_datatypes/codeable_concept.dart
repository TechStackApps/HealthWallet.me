import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';

part 'codeable_concept.freezed.dart';
part 'codeable_concept.g.dart';

@freezed
class CodeableConcept with _$CodeableConcept {
  factory CodeableConcept({
    List<Coding>? coding,
    String? text,
  }) = _CodeableConcept;

  factory CodeableConcept.fromJson(Map<String, dynamic> json) =>
      _$CodeableConceptFromJson(json);
}
