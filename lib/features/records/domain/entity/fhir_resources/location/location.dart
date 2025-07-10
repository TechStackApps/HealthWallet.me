import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/address.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/telecom.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  factory Location({
    String? id,
    String? name,
    String? status,
    String? description,
    Address? address,
    List<Telecom>? telecom,
    List<CodeableConcept>? type,
    @JsonKey(name: 'physical_type') CodeableConcept? physicalType,
    String? mode,
    @JsonKey(name: 'managing_organization') Reference? managingOrganization,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
