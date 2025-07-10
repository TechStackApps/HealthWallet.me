import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
class Goal with _$Goal {
  const factory Goal({
    String? id,
    String? title,
    String? status,
    @JsonKey(name: 'has_status') bool? hasStatus,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'has_category') bool? hasCategory,
    List<CodeableConcept>? category,
    @JsonKey(name: 'has_udi') bool? hasUdi,
    String? udi,
    bool? hasAddresses,
    String? author,
    String? description,
    @JsonKey(name: 'outcome_reference') String? outcomeReference,
    @JsonKey(name: 'achievement_status') Coding? achievementStatus,
    Coding? priority,
    Reference? subject,
    @JsonKey(name: 'status_date') String? statusDate,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
