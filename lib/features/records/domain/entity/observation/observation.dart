import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'observation.freezed.dart';

@freezed
class Observation with _$Observation implements IFhirResource {
  const Observation._();

  factory Observation({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Observation;

  @override
  FhirType get fhirType => FhirType.Observation;
}
