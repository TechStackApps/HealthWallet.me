import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';

part 'observation.freezed.dart';
part 'observation.g.dart';

@freezed
class Observation with _$Observation {
  factory Observation({
    required String id,
    required String status,
    required CodeableConcept code,
    ValueQuantity? valueQuantity,
    DateTime? effectiveDateTime,
  }) = _Observation;

  factory Observation.fromJson(Map<String, dynamic> json) =>
      _$ObservationFromJson(json);
}

@freezed
class ValueQuantity with _$ValueQuantity {
  factory ValueQuantity({
    double? value,
    String? unit,
  }) = _ValueQuantity;

  factory ValueQuantity.fromJson(Map<String, dynamic> json) =>
      _$ValueQuantityFromJson(json);
}
