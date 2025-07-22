// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'immunization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImmunizationImpl _$$ImmunizationImplFromJson(Map<String, dynamic> json) =>
    _$ImmunizationImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      providedDate: json['provided_date'] as String?,
      manufacturerText: json['manufacturer_text'] as String?,
      hasLotNumber: json['has_lot_number'] as bool?,
      lotNumber: json['lot_number'] as String?,
      lotNumberExpirationDate: json['lot_number_expiration_date'] as String?,
      hasDoseQuantity: json['has_dose_quantity'] as bool?,
      doseQuantity: json['dose_quantity'] == null
          ? null
          : Coding.fromJson(json['dose_quantity'] as Map<String, dynamic>),
      requester: json['requester'] as String?,
      reported: json['reported'] as String?,
      performer: json['performer'] as String?,
      route: (json['route'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasRoute: json['has_route'] as bool?,
      site: (json['site'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasSite: json['has_site'] as bool?,
      patient: json['patient'] == null
          ? null
          : Reference.fromJson(json['patient'] as Map<String, dynamic>),
      note: (json['note'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$ImmunizationImplToJson(_$ImmunizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'provided_date': instance.providedDate,
      'manufacturer_text': instance.manufacturerText,
      'has_lot_number': instance.hasLotNumber,
      'lot_number': instance.lotNumber,
      'lot_number_expiration_date': instance.lotNumberExpirationDate,
      'has_dose_quantity': instance.hasDoseQuantity,
      'dose_quantity': instance.doseQuantity,
      'requester': instance.requester,
      'reported': instance.reported,
      'performer': instance.performer,
      'route': instance.route,
      'has_route': instance.hasRoute,
      'site': instance.site,
      'has_site': instance.hasSite,
      'patient': instance.patient,
      'note': instance.note,
      'location': instance.location,
    };
