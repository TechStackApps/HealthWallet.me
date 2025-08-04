import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_dispense.freezed.dart';

@freezed
class MedicationDispense with _$MedicationDispense implements IFhirResource {
  const MedicationDispense._();

  factory MedicationDispense({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _MedicationDispense;

  @override
  FhirType get fhirType => FhirType.MedicationDispense;
}
