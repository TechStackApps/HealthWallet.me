import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';

part 'device.freezed.dart';
part 'device.g.dart';

@freezed
class Device with _$Device {
  factory Device({
    String? id,
    CodeableConcept? code,
    String? model,
    String? status,
    @JsonKey(name: 'has_expiry') bool? hasExpiry,
    @JsonKey(name: 'get_expiry') String? getExpiry,
    @JsonKey(name: 'get_type_coding') List<Coding>? getTypeCoding,
    @JsonKey(name: 'has_type_coding') bool? hasTypeCoding,
    @JsonKey(name: 'get_udi') String? getUdi,
    @JsonKey(name: 'udi_carrier_aidc') String? udiCarrierAidc,
    @JsonKey(name: 'udi_carrier_hrf') String? udiCarrierHrf,
    String? safety,
    @JsonKey(name: 'has_safety') bool? hasSafety,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
