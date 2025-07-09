import 'package:freezed_annotation/freezed_annotation.dart';

part 'fhir_resource.freezed.dart';
part 'fhir_resource.g.dart';

@freezed
class FhirResource with _$FhirResource {
  factory FhirResource({
    String? id,
    @JsonKey(name: 'source_resource_type') required String resourceType,
    @JsonKey(name: 'resource_raw') required Map<String, dynamic> resourceJson,
    @JsonKey(name: 'source_id') String? sourceId,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _FhirResource;

  factory FhirResource.fromJson(Map<String, dynamic> json) =>
      _$FhirResourceFromJson(json);
}
