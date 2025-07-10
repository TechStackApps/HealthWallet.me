import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'medication_request.freezed.dart';
part 'medication_request.g.dart';

@freezed
class MedicationRequest with _$MedicationRequest {
  factory MedicationRequest({
    required String id,
    required String status,
    required String intent,
    CodeableConcept? medicationCodeableConcept,
    @ReferenceConverter() Reference? requester,
  }) = _MedicationRequest;

  factory MedicationRequest.fromJson(Map<String, dynamic> json) =>
      _$MedicationRequestFromJson(json);
}
