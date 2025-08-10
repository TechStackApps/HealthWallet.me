import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
abstract class Reference with _$Reference {
  const factory Reference.resolved(
      @JsonKey(toJson: _resourceToJson, fromJson: _resourceFromJson)
      FhirResourceDto resource) = ResolvedReference;
  const factory Reference.unresolved(String reference) = UnresolvedReference;

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);
}

Map<String, dynamic> _resourceToJson(FhirResourceDto resource) =>
    resource.toJson();
FhirResourceDto _resourceFromJson(Map<String, dynamic> json) =>
    FhirResourceDto.fromJson(json);

class ReferenceConverter
    implements JsonConverter<Reference, Map<String, dynamic>> {
  const ReferenceConverter();

  @override
  Reference fromJson(Map<String, dynamic> json) {
    if (json.containsKey('resourceType')) {
      return Reference.resolved(FhirResourceDto.fromJson(json));
    } else {
      return Reference.unresolved(json['reference'] as String);
    }
  }

  @override
  Map<String, dynamic> toJson(Reference object) {
    return object.when(
      resolved: (resource) => resource.toJson(),
      unresolved: (reference) => {'reference': reference},
    );
  }
}
