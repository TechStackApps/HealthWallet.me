// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllergyDtoImpl _$$AllergyDtoImplFromJson(Map<String, dynamic> json) =>
    _$AllergyDtoImpl(
      dateRecorded: json['dateRecorded'] as String,
      allergyType: json['allergyType'] as String,
      allergicTo: json['allergicTo'] as String,
      reaction: json['reaction'] as String?,
      onset: json['onset'] as String,
      resolutionAge: json['resolutionAge'] as String?,
    );

Map<String, dynamic> _$$AllergyDtoImplToJson(_$AllergyDtoImpl instance) =>
    <String, dynamic>{
      'dateRecorded': instance.dateRecorded,
      'allergyType': instance.allergyType,
      'allergicTo': instance.allergicTo,
      'reaction': instance.reaction,
      'onset': instance.onset,
      'resolutionAge': instance.resolutionAge,
    };
