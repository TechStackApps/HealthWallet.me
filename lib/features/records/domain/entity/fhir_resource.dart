import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'fhir_resource.freezed.dart';
part 'fhir_resource.g.dart';

@freezed
@HiveType(typeId: 0)
class FhirResource with _$FhirResource {
  const factory FhirResource({
    @HiveField(0) required String id,
    @HiveField(1) required String resourceType,
    @HiveField(2) required Map<String, dynamic> resource,
  }) = _FhirResource;

  factory FhirResource.fromJson(Map<String, dynamic> json) =>
      _$FhirResourceFromJson(json);
}
