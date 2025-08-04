import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'specimen.freezed.dart';

@freezed
class Specimen with _$Specimen implements IFhirResource {
  const Specimen._();

  factory Specimen({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Specimen;

  @override
  FhirType get fhirType => FhirType.Specimen;
}
