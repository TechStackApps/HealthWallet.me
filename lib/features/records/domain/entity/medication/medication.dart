import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication.freezed.dart';

@freezed
class Medication with _$Medication implements IFhirResource {
  const Medication._();

  factory Medication({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Medication;

  @override
  FhirType get fhirType => FhirType.Medication;
}
