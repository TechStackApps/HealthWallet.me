import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'adverse_event.freezed.dart';

@freezed
class AdverseEvent with _$AdverseEvent implements IFhirResource {
  const AdverseEvent._();
  
  factory AdverseEvent({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _AdverseEvent;

  @override
  FhirType get fhirType => FhirType.AdverseEvent;
}
