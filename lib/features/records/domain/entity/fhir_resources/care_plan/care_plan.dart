import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'care_plan.freezed.dart';
part 'care_plan.g.dart';

@freezed
class CarePlan with _$CarePlan {
  factory CarePlan({
    String? id,
    CodeableConcept? code,
    String? status,
    String? expiry,
    List<CodeableConcept>? category,
    @JsonKey(name: 'has_category') bool? hasCategory,
    List<Reference>? goals,
    @JsonKey(name: 'has_goals') bool? hasGoals,
    List<Reference>? addresses,
    @JsonKey(name: 'has_addresses') bool? hasAddresses,
    bool? hasActivity,
    String? basedOn,
    String? partOf,
    String? intent,
    String? description,
    Reference? subject,
    @JsonKey(name: 'period_start') String? periodStart,
    @JsonKey(name: 'period_end') String? periodEnd,
    Reference? author,
  }) = _CarePlan;

  factory CarePlan.fromJson(Map<String, dynamic> json) =>
      _$CarePlanFromJson(json);
}
