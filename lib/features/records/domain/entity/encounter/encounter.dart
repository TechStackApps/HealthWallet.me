import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'encounter.freezed.dart';

@freezed
class Encounter with _$Encounter implements IFhirResource {
  const Encounter._();

  factory Encounter({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Encounter;

  @override
  FhirType get fhirType => FhirType.Encounter;
}
