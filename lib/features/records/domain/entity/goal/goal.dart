import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'goal.freezed.dart';

@freezed
class Goal with _$Goal implements IFhirResource {
  const Goal._();

  factory Goal({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Goal;

  @override
  FhirType get fhirType => FhirType.Goal;
}
