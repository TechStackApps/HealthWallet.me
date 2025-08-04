import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'practitioner_role.freezed.dart';

@freezed
class PractitionerRole with _$PractitionerRole implements IFhirResource {
  const PractitionerRole._();

  factory PractitionerRole({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _PractitionerRole;

  @override
  FhirType get fhirType => FhirType.PractitionerRole;
}
