import 'package:fhir_r4/fhir_r4.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:health_wallet/core/utils/custom_from_json.dart';

part 'fhir_resource_dto.freezed.dart';
part 'fhir_resource_dto.g.dart';

@freezed
class FhirResourceDto with _$FhirResourceDto {
  const FhirResourceDto._();

  const factory FhirResourceDto({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "source_id") String? sourceId,
    @JsonKey(name: "source_resource_type") String? resourceType,
    @JsonKey(name: "source_resource_id") String? resourceId,
    @JsonKey(name: "sort_title") String? title,
    @JsonKey(name: "sort_date", fromJson: dateTimeFromJson) DateTime? date,
    @JsonKey(name: "resource_raw") Map<String, dynamic>? resourceRaw,
    String? encounterId,
  }) = _FhirResourceDto;

  factory FhirResourceDto.fromJson(Map<String, dynamic> json) {
    return _$FhirResourceDtoFromJson(json);
  }

  FhirResourceDto populateEncounterIdFromRaw() {
    String? encounterId = extractReferenceId("encounter");

    if (encounterId == null) return this;

    return copyWith(encounterId: encounterId);
  }

  String? extractReferenceId(String key) {
    if (!(resourceRaw?.containsKey(key) ?? false)) return null;

    try {
      Reference reference = Reference.fromJson(resourceRaw![key]);
      String? refString = reference.reference?.valueString;
      if (refString == null) return null;

      return _extractIdFromReferenceString(refString);
    } catch (e) {
      return null;
    }
  }

  String? _extractIdFromReferenceString(String refString) {
    if (refString.startsWith('urn:uuid:')) {
      return refString.substring(9);
    }

    if (refString.contains('/')) {
      final parts = refString.split('/');
      if (parts.length == 2) {
        return parts[1];
      }
    }

    if (refString.startsWith('#')) {
      return refString.substring(1);
    }

    if (refString.startsWith('http')) {
      final uri = Uri.parse(refString);
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 2) {
        return pathSegments[pathSegments.length - 1];
      }
    }

    if (refString.contains('/') && !refString.startsWith('http')) {
      final parts = refString.split('/');
      if (parts.length >= 2) {
        return parts.last;
      }
    }

    return refString;
  }
}
