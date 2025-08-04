import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_request.freezed.dart';

@freezed
class MedicationRequest with _$MedicationRequest implements IFhirResource {
  const MedicationRequest._();

  factory MedicationRequest({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _MedicationRequest;

  @override
  FhirType get fhirType => FhirType.MedicationRequest;
}
