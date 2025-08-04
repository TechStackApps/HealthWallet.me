import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'location.freezed.dart';

@freezed
class Location with _$Location implements IFhirResource {
  const Location._();

  factory Location({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Location;

  @override
  FhirType get fhirType => FhirType.Location;
}
