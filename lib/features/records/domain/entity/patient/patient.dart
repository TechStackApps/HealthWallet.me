import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'patient.freezed.dart';

@freezed
class Patient with _$Patient implements IFhirResource {
  const Patient._();

  factory Patient({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Patient;

  @override
  FhirType get fhirType => FhirType.Patient;
}
