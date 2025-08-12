import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

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

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final locationName = name?.toString();
    if (locationName != null && locationName.isNotEmpty) return locationName;

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final statusDisplay = status?.valueString;
    if (statusDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: "Status: $statusDisplay",
      ));
    }

    final organizationDisplay = managingOrganization?.display?.valueString;
    if (organizationDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.hospital,
        info: organizationDisplay,
      ));
    }

    if (date != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.calendar,
        info: DateFormat.yMMMMd().format(date!),
      ));
    }

    return infoLines;
  }

  @override
  List<String?> get resourceReferences {
    return {
      managingOrganization?.reference?.valueString,
      partOf?.reference?.valueString,
      ...?endpoint?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }
}
