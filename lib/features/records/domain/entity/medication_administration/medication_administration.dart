import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_administration.freezed.dart';

@freezed
class MedicationAdministration with _$MedicationAdministration implements IFhirResource {
  const MedicationAdministration._();

  factory MedicationAdministration({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _MedicationAdministration;

  @override
  FhirType get fhirType => FhirType.MedicationAdministration;
}
