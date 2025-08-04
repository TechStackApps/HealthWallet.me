import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'care_team.freezed.dart';

@freezed
class CareTeam with _$CareTeam implements IFhirResource {
  const CareTeam._();

  factory CareTeam({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _CareTeam;

  @override
  FhirType get fhirType => FhirType.CareTeam;
}