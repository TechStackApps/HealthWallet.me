import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'condition.freezed.dart';
part 'condition.g.dart';

@freezed
class Condition with _$Condition {
  const factory Condition({
    String? id,
    CodeableConcept? code,
    @JsonKey(name: 'code_text') String? codeText,
    @JsonKey(name: 'code_id') String? codeId,
    @JsonKey(name: 'code_system') String? codeSystem,
    @JsonKey(name: 'severity_text') String? severityText,
    @JsonKey(name: 'has_asserter') bool? hasAsserter,
    Reference? asserter,
    @JsonKey(name: 'has_body_site') bool? hasBodySite,
    @JsonKey(name: 'body_site') List<CodeableConcept>? bodySite,
    @JsonKey(name: 'clinical_status') String? clinicalStatus,
    @JsonKey(name: 'date_recorded') String? dateRecorded,
    @JsonKey(name: 'onset_datetime') String? onsetDatetime,
    @JsonKey(name: 'abatement_datetime') String? abatementDatetime,
    String? note,
  }) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}
