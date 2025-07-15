// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllergyImpl _$$AllergyImplFromJson(Map<String, dynamic> json) =>
    _$AllergyImpl(
      dateRecorded: json['dateRecorded'] as String,
      allergyType: json['allergyType'] as String,
      allergicTo: json['allergicTo'] as String,
      reaction: json['reaction'] as String?,
      onset: json['onset'] as String,
      resolutionAge: json['resolutionAge'] as String?,
    );

Map<String, dynamic> _$$AllergyImplToJson(_$AllergyImpl instance) =>
    <String, dynamic>{
      'dateRecorded': instance.dateRecorded,
      'allergyType': instance.allergyType,
      'allergicTo': instance.allergicTo,
      'reaction': instance.reaction,
      'onset': instance.onset,
      'resolutionAge': instance.resolutionAge,
    };
