// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_study.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResearchStudyImpl _$$ResearchStudyImplFromJson(Map<String, dynamic> json) =>
    _$ResearchStudyImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      categoryCoding: json['category_coding'] == null
          ? null
          : Coding.fromJson(json['category_coding'] as Map<String, dynamic>),
      focusCoding: json['focus_coding'] == null
          ? null
          : Coding.fromJson(json['focus_coding'] as Map<String, dynamic>),
      protocolReference: json['protocol_reference'] == null
          ? null
          : Reference.fromJson(
              json['protocol_reference'] as Map<String, dynamic>),
      partOfReference: json['part_of_reference'] == null
          ? null
          : Reference.fromJson(
              json['part_of_reference'] as Map<String, dynamic>),
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => ResearchStudyContact.fromJson(e as Map<String, dynamic>))
          .toList(),
      keywordConcepts: (json['keyword_concepts'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      period: json['period'] == null
          ? null
          : ResearchStudyPeriod.fromJson(
              json['period'] as Map<String, dynamic>),
      enrollmentReferences: (json['enrollment_references'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsorReference: json['sponsor_reference'] == null
          ? null
          : Reference.fromJson(
              json['sponsor_reference'] as Map<String, dynamic>),
      principalInvestigatorReference:
          json['principal_investigator_reference'] == null
              ? null
              : Reference.fromJson(json['principal_investigator_reference']
                  as Map<String, dynamic>),
      siteReferences: (json['site_references'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      arms: (json['arms'] as List<dynamic>?)
          ?.map((e) => ResearchStudyArm.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] as String?,
      primaryPurposeType: json['primary_purpose_type'] as String?,
    );

Map<String, dynamic> _$$ResearchStudyImplToJson(_$ResearchStudyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'category_coding': instance.categoryCoding,
      'focus_coding': instance.focusCoding,
      'protocol_reference': instance.protocolReference,
      'part_of_reference': instance.partOfReference,
      'contacts': instance.contacts,
      'keyword_concepts': instance.keywordConcepts,
      'period': instance.period,
      'enrollment_references': instance.enrollmentReferences,
      'sponsor_reference': instance.sponsorReference,
      'principal_investigator_reference':
          instance.principalInvestigatorReference,
      'site_references': instance.siteReferences,
      'comments': instance.comments,
      'description': instance.description,
      'arms': instance.arms,
      'location': instance.location,
      'primary_purpose_type': instance.primaryPurposeType,
    };

_$ResearchStudyContactImpl _$$ResearchStudyContactImplFromJson(
        Map<String, dynamic> json) =>
    _$ResearchStudyContactImpl(
      name: json['name'] as String?,
      telecoms: (json['telecoms'] as List<dynamic>?)
          ?.map((e) => Telecom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ResearchStudyContactImplToJson(
        _$ResearchStudyContactImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'telecoms': instance.telecoms,
    };

_$ResearchStudyPeriodImpl _$$ResearchStudyPeriodImplFromJson(
        Map<String, dynamic> json) =>
    _$ResearchStudyPeriodImpl(
      start: json['start'] as String?,
      end: json['end'] as String?,
    );

Map<String, dynamic> _$$ResearchStudyPeriodImplToJson(
        _$ResearchStudyPeriodImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$ResearchStudyArmImpl _$$ResearchStudyArmImplFromJson(
        Map<String, dynamic> json) =>
    _$ResearchStudyArmImpl(
      name: json['name'] as String?,
      description: json['description'] as String?,
      coding: json['coding'] == null
          ? null
          : Coding.fromJson(json['coding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResearchStudyArmImplToJson(
        _$ResearchStudyArmImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'coding': instance.coding,
    };
