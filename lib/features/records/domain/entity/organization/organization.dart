import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'organization.freezed.dart';

@freezed
class Organization with _$Organization implements IFhirResource {
  const Organization._();

  const factory Organization({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    List<CodeableConcept>? type,
    FhirString? name,
    List<FhirString>? alias,
    List<ContactPoint>? telecom,
    List<Address>? address,
    Reference? partOf,
    List<OrganizationContact>? contact,
    List<Reference>? endpoint,
  }) = _Organization;

  @override
  FhirType get fhirType => FhirType.Organization;

  factory Organization.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirOrganization = fhir_r4.Organization.fromJson(resourceJson);

    return Organization(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirOrganization.text,
      identifier: fhirOrganization.identifier,
      active: fhirOrganization.active,
      type: fhirOrganization.type,
      name: fhirOrganization.name,
      alias: fhirOrganization.alias,
      telecom: fhirOrganization.telecom,
      address: fhirOrganization.address,
      partOf: fhirOrganization.partOf,
      contact: fhirOrganization.contact,
      endpoint: fhirOrganization.endpoint,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final organizationName = name?.toString();
    if (organizationName != null && organizationName.isNotEmpty) {
      return organizationName;
    }

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final addressDisplay =
        FhirFieldExtractor.formatAddress(address?.firstOrNull);
    if (addressDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.identification,
        info: addressDisplay,
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
      partOf?.reference?.valueString,
      ...?endpoint?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }
}
