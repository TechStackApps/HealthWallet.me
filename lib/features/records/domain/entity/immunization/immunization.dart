import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'immunization.freezed.dart';

@freezed
class Immunization with _$Immunization implements IFhirResource {
  const Immunization._();

  factory Immunization({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Immunization;

  @override
  FhirType get fhirType => FhirType.Immunization;
}
