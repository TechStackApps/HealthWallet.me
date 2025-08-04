import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_statement.freezed.dart';

@freezed
class MedicationStatement with _$MedicationStatement implements IFhirResource {
  const MedicationStatement._();

  factory MedicationStatement({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _MedicationStatement;

  @override
  FhirType get fhirType => FhirType.MedicationStatement;
}
