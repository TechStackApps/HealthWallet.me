import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'care_team.freezed.dart';
part 'care_team.g.dart';

@freezed
class CareTeam with _$CareTeam {
  factory CareTeam({
    String? id,
    CodeableConcept? code,
    String? name,
    String? status,
    @JsonKey(name: 'period_start') String? periodStart,
    @JsonKey(name: 'period_end') String? periodEnd,
    List<CareTeamParticipant>? participants,
    List<CodeableConcept>? category,
    Reference? subject,
    Reference? encounter,
    @JsonKey(name: 'managing_organization') Reference? managingOrganization,
  }) = _CareTeam;

  factory CareTeam.fromJson(Map<String, dynamic> json) =>
      _$CareTeamFromJson(json);
}

@freezed
class CareTeamParticipant with _$CareTeamParticipant {
  factory CareTeamParticipant({
    Reference? reference,
    String? display,
    String? role,
    String? periodStart,
    String? periodEnd,
  }) = _CareTeamParticipant;

  factory CareTeamParticipant.fromJson(Map<String, dynamic> json) =>
      _$CareTeamParticipantFromJson(json);
}
