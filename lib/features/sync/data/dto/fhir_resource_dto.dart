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
    String? subjectId,
    // New fields for handling deletions
    @JsonKey(name: "deleted_at", fromJson: dateTimeFromJson) DateTime? deletedAt,
    @JsonKey(name: "change_type") String? changeType, // "created", "updated", or "deleted"
  }) = _FhirResourceDto;

  factory FhirResourceDto.fromJson(Map<String, dynamic> json) =>
      _$FhirResourceDtoFromJson(json);

  FhirResourceDto populateEncounterIdFromRaw() {
    String? encounterId = extractReferenceId("encounter");

    if (encounterId == null) return this;

    return copyWith(encounterId: encounterId);
  }

  FhirResourceDto populateSubjectIdFromRaw() {
    String? subjectId = extractReferenceId("subject");

    if (subjectId == null) return this;

    return copyWith(subjectId: subjectId);
  }

  String? extractReferenceId(String key) {
    if (!(resourceRaw?.containsKey(key) ?? false)) return null;

    Reference reference = Reference.fromJson(resourceRaw![key]);
    String? refString = reference.reference?.valueString;
    if (refString == null) return null;

    List<String> splitString = refString.split(":");
    if (splitString.length < 3) return null;

    return splitString[2];
  }

  /// Check if this resource represents a deletion
  bool get isDeleted => deletedAt != null || changeType == 'deleted';

  /// Check if this resource was created (new)
  bool get isCreated => changeType == 'created';

  /// Check if this resource was updated (modified)
  bool get isUpdated => changeType == 'updated';

  /// Get a user-friendly description of the change
  String get changeDescription {
    if (isDeleted) return 'Deleted';
    if (isCreated) return 'Created';
    if (isUpdated) return 'Updated';
    return 'Unknown';
  }
}
