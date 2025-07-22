// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaImpl _$$MediaImplFromJson(Map<String, dynamic> json) => _$MediaImpl(
      id: json['id'] as String?,
      status: json['status'] as String?,
      type: json['type'] == null
          ? null
          : CodeableConcept.fromJson(json['type'] as Map<String, dynamic>),
      reasonCode: (json['reasonCode'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      deviceName: json['deviceName'] as String?,
      device: json['device'] == null
          ? null
          : Reference.fromJson(json['device'] as Map<String, dynamic>),
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      description: json['description'] as String?,
      content: json['content'] == null
          ? null
          : Attachment.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MediaImplToJson(_$MediaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'type': instance.type,
      'reasonCode': instance.reasonCode,
      'deviceName': instance.deviceName,
      'device': instance.device,
      'height': instance.height,
      'width': instance.width,
      'description': instance.description,
      'content': instance.content,
    };
