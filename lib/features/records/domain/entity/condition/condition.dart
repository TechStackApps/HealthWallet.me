import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'condition.freezed.dart';

@freezed
class Condition with _$Condition implements IFhirResource {
  const Condition._();

  factory Condition({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Condition;

  @override
  FhirType get fhirType => FhirType.Condition;
}
