import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'related_person.freezed.dart';

@freezed
class RelatedPerson with _$RelatedPerson implements IFhirResource {
  const RelatedPerson._();

  factory RelatedPerson({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _RelatedPerson;

  @override
  FhirType get fhirType => FhirType.RelatedPerson;
}
