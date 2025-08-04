import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'allergy_intolerance.freezed.dart';

@freezed
class AllergyIntolerance with _$AllergyIntolerance implements IFhirResource {
  const AllergyIntolerance._();

  factory AllergyIntolerance({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _AllergyIntolerance;

  @override
  FhirType get fhirType => FhirType.AllergyIntolerance;
}
