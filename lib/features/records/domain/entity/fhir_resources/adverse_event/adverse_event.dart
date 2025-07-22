import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'adverse_event.freezed.dart';
part 'adverse_event.g.dart';

@freezed
class AdverseEvent with _$AdverseEvent {
  factory AdverseEvent({
    String? id,
    CodeableConcept? code,
    Reference? subject,
    String? description,
    @JsonKey(name: 'event_type') String? eventType,
    @JsonKey(name: 'has_event_type') bool? hasEventType,
    String? date,
    CodeableConcept? seriousness,
    @JsonKey(name: 'has_seriousness') bool? hasSeriousness,
    String? actuality,
    CodeableConcept? event,
    @JsonKey(name: 'has_event') bool? hasEvent,
  }) = _AdverseEvent;

  factory AdverseEvent.fromJson(Map<String, dynamic> json) =>
      _$AdverseEventFromJson(json);
}
