import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'practitioner.freezed.dart';

@freezed
class Practitioner with _$Practitioner implements IFhirResource {
  const Practitioner._();

  factory Practitioner({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Practitioner;

  @override
  FhirType get fhirType => FhirType.Practitioner;
}
