// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EncounterImpl _$$EncounterImplFromJson(Map<String, dynamic> json) =>
    _$EncounterImpl(
      id: json['id'] as String?,
      status: json['status'] as String?,
      participant: (json['participant'] as List<dynamic>?)
          ?.map((e) => EncounterParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EncounterImplToJson(_$EncounterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'participant': instance.participant,
    };

_$EncounterParticipantImpl _$$EncounterParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$EncounterParticipantImpl(
      individual: json['individual'] == null
          ? null
          : Reference.fromJson(json['individual'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EncounterParticipantImplToJson(
        _$EncounterParticipantImpl instance) =>
    <String, dynamic>{
      'individual': instance.individual,
    };

_$ReferenceImpl _$$ReferenceImplFromJson(Map<String, dynamic> json) =>
    _$ReferenceImpl(
      reference: json['reference'] as String?,
      display: json['display'] as String?,
    );

Map<String, dynamic> _$$ReferenceImplToJson(_$ReferenceImpl instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'display': instance.display,
    };
