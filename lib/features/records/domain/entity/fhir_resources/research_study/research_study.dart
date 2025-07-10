import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/telecom.dart';

part 'research_study.freezed.dart';
part 'research_study.g.dart';

@freezed
class ResearchStudy with _$ResearchStudy {
  factory ResearchStudy({
    String? id,
    String? title,
    String? status,
    @JsonKey(name: 'category_coding') Coding? categoryCoding,
    @JsonKey(name: 'focus_coding') Coding? focusCoding,
    @JsonKey(name: 'protocol_reference') Reference? protocolReference,
    @JsonKey(name: 'part_of_reference') Reference? partOfReference,
    List<ResearchStudyContact>? contacts,
    @JsonKey(name: 'keyword_concepts') List<CodeableConcept>? keywordConcepts,
    ResearchStudyPeriod? period,
    @JsonKey(name: 'enrollment_references')
    List<Reference>? enrollmentReferences,
    @JsonKey(name: 'sponsor_reference') Reference? sponsorReference,
    @JsonKey(name: 'principal_investigator_reference')
    Reference? principalInvestigatorReference,
    @JsonKey(name: 'site_references') List<Reference>? siteReferences,
    List<String>? comments,
    String? description,
    List<ResearchStudyArm>? arms,
    String? location,
    @JsonKey(name: 'primary_purpose_type') String? primaryPurposeType,
  }) = _ResearchStudy;

  factory ResearchStudy.fromJson(Map<String, dynamic> json) =>
      _$ResearchStudyFromJson(json);
}

@freezed
class ResearchStudyContact with _$ResearchStudyContact {
  factory ResearchStudyContact({
    String? name,
    List<Telecom>? telecoms,
  }) = _ResearchStudyContact;

  factory ResearchStudyContact.fromJson(Map<String, dynamic> json) =>
      _$ResearchStudyContactFromJson(json);
}

@freezed
class ResearchStudyPeriod with _$ResearchStudyPeriod {
  factory ResearchStudyPeriod({
    String? start,
    String? end,
  }) = _ResearchStudyPeriod;

  factory ResearchStudyPeriod.fromJson(Map<String, dynamic> json) =>
      _$ResearchStudyPeriodFromJson(json);
}

@freezed
class ResearchStudyArm with _$ResearchStudyArm {
  factory ResearchStudyArm({
    String? name,
    String? description,
    Coding? coding,
  }) = _ResearchStudyArm;

  factory ResearchStudyArm.fromJson(Map<String, dynamic> json) =>
      _$ResearchStudyArmFromJson(json);
}
