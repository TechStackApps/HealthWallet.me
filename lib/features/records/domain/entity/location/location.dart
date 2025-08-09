import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'location.freezed.dart';

@freezed
class Location with _$Location implements IFhirResource {
  const Location._();

  const factory Location({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    LocationStatus? status,
    Coding? operationalStatus,
    FhirString? name,
    List<FhirString>? alias,
    FhirString? description,
    LocationMode? mode,
    List<CodeableConcept>? type,
    List<ContactPoint>? telecom,
    Address? address,
    CodeableConcept? physicalType,
    LocationPosition? position,
    Reference? managingOrganization,
    Reference? partOf,
    List<LocationHoursOfOperation>? hoursOfOperation,
    FhirString? availabilityExceptions,
    List<Reference>? endpoint,
  }) = _Location;

  @override
  FhirType get fhirType => FhirType.Location;

  factory Location.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirLocation = fhir_r4.Location.fromJson(resourceJson);

    return Location(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirLocation.text,
      date: data.date,
      identifier: fhirLocation.identifier,
      status: fhirLocation.status,
      operationalStatus: fhirLocation.operationalStatus,
      name: fhirLocation.name,
      alias: fhirLocation.alias,
      description: fhirLocation.description,
      mode: fhirLocation.mode,
      type: fhirLocation.type,
      telecom: fhirLocation.telecom,
      address: fhirLocation.address,
      physicalType: fhirLocation.physicalType,
      position: fhirLocation.position,
      managingOrganization: fhirLocation.managingOrganization,
      partOf: fhirLocation.partOf,
      hoursOfOperation: fhirLocation.hoursOfOperation,
      availabilityExceptions: fhirLocation.availabilityExceptions,
      endpoint: fhirLocation.endpoint,
    );
  }
}
