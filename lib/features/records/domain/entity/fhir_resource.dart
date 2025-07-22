import 'package:json_annotation/json_annotation.dart';

part 'fhir_resource.g.dart';

@JsonSerializable(explicitToJson: true)
class FhirResource {
  final String? id;
  @JsonKey(name: 'source_resource_type')
  final String resourceType;
  @JsonKey(name: 'resource_raw')
  final Map<String, dynamic> resourceJson;
  @JsonKey(name: 'source_id')
  final String? sourceId;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  FhirResource({
    this.id,
    required this.resourceType,
    required this.resourceJson,
    this.sourceId,
    required this.updatedAt,
  });

  factory FhirResource.fromJson(Map<String, dynamic> json) {
    return FhirResource(
      id: json['id'] as String?,
      resourceType: json['source_resource_type'] as String? ?? 'Unknown',
      resourceJson: json['resource_raw'] as Map<String, dynamic>? ?? {},
      sourceId: json['source_id'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => _$FhirResourceToJson(this);
}
