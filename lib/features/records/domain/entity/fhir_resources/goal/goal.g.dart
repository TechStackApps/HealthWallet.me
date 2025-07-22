// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      hasStatus: json['has_status'] as bool?,
      startDate: json['start_date'] as String?,
      hasCategory: json['has_category'] as bool?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasUdi: json['has_udi'] as bool?,
      udi: json['udi'] as String?,
      hasAddresses: json['hasAddresses'] as bool?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      outcomeReference: json['outcome_reference'] as String?,
      achievementStatus: json['achievement_status'] == null
          ? null
          : Coding.fromJson(json['achievement_status'] as Map<String, dynamic>),
      priority: json['priority'] == null
          ? null
          : Coding.fromJson(json['priority'] as Map<String, dynamic>),
      subject: json['subject'] == null
          ? null
          : Reference.fromJson(json['subject'] as Map<String, dynamic>),
      statusDate: json['status_date'] as String?,
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'has_status': instance.hasStatus,
      'start_date': instance.startDate,
      'has_category': instance.hasCategory,
      'category': instance.category,
      'has_udi': instance.hasUdi,
      'udi': instance.udi,
      'hasAddresses': instance.hasAddresses,
      'author': instance.author,
      'description': instance.description,
      'outcome_reference': instance.outcomeReference,
      'achievement_status': instance.achievementStatus,
      'priority': instance.priority,
      'subject': instance.subject,
      'status_date': instance.statusDate,
    };
