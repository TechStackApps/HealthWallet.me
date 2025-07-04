// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fhir_resource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FhirResourceAdapter extends TypeAdapter<FhirResource> {
  @override
  final int typeId = 0;

  @override
  FhirResource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FhirResource(
      id: fields[0] as String,
      resourceType: fields[1] as String,
      resource: (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, FhirResource obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.resourceType)
      ..writeByte(2)
      ..write(obj.resource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FhirResourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FhirResourceImpl _$$FhirResourceImplFromJson(Map<String, dynamic> json) =>
    _$FhirResourceImpl(
      id: json['id'] as String,
      resourceType: json['resourceType'] as String,
      resource: json['resource'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$FhirResourceImplToJson(_$FhirResourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resourceType': instance.resourceType,
      'resource': instance.resource,
    };
