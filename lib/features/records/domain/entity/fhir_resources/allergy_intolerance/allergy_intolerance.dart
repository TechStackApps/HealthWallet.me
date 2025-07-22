import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/note.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'allergy_intolerance.freezed.dart';
part 'allergy_intolerance.g.dart';

@freezed
class AllergyIntolerance with _$AllergyIntolerance {
  factory AllergyIntolerance({
    required String id,
    String? title,
    String? status,
    @JsonKey(name: 'recorded_date') String? recordedDate,
    @JsonKey(name: 'substance_coding') List<Coding>? substanceCoding,
    Reference? asserter,
    List<Note>? note,
    String? type,
    List<String>? category,
    Reference? patient,
    CodeableConcept? code,
  }) = _AllergyIntolerance;

  factory AllergyIntolerance.fromJson(Map<String, dynamic> json) =>
      _$AllergyIntoleranceFromJson(json);
}
