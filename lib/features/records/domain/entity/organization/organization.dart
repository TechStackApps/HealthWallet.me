import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'organization.freezed.dart';

@freezed
class Organization with _$Organization implements IFhirResource {
  const Organization._();

  factory Organization({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Organization;

  @override
  FhirType get fhirType => FhirType.Organization;
}
