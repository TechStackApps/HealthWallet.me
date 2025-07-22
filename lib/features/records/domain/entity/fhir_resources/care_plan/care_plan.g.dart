// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarePlanImpl _$$CarePlanImplFromJson(Map<String, dynamic> json) =>
    _$CarePlanImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      status: json['status'] as String?,
      expiry: json['expiry'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasCategory: json['has_category'] as bool?,
      goals: (json['goals'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasGoals: json['has_goals'] as bool?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasAddresses: json['has_addresses'] as bool?,
      hasActivity: json['hasActivity'] as bool?,
      basedOn: json['basedOn'] as String?,
      partOf: json['partOf'] as String?,
      intent: json['intent'] as String?,
      description: json['description'] as String?,
      subject: json['subject'] == null
          ? null
          : Reference.fromJson(json['subject'] as Map<String, dynamic>),
      periodStart: json['period_start'] as String?,
      periodEnd: json['period_end'] as String?,
      author: json['author'] == null
          ? null
          : Reference.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CarePlanImplToJson(_$CarePlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': instance.status,
      'expiry': instance.expiry,
      'category': instance.category,
      'has_category': instance.hasCategory,
      'goals': instance.goals,
      'has_goals': instance.hasGoals,
      'addresses': instance.addresses,
      'has_addresses': instance.hasAddresses,
      'hasActivity': instance.hasActivity,
      'basedOn': instance.basedOn,
      'partOf': instance.partOf,
      'intent': instance.intent,
      'description': instance.description,
      'subject': instance.subject,
      'period_start': instance.periodStart,
      'period_end': instance.periodEnd,
      'author': instance.author,
    };
