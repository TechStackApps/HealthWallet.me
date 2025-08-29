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

part 'immunization.freezed.dart';

@freezed
class Immunization with _$Immunization implements IFhirResource {
  const Immunization._();

  const factory Immunization({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    Narrative? text,
    List<Identifier>? identifier,
    ImmunizationStatusCodes? status,
    CodeableConcept? statusReason,
    CodeableConcept? vaccineCode,
    Reference? patient,
    Reference? encounter,
    OccurrenceXImmunization? occurrenceX,
    FhirDateTime? recorded,
    FhirBoolean? primarySource,
    CodeableConcept? reportOrigin,
    Reference? location,
    Reference? manufacturer,
    FhirString? lotNumber,
    FhirDate? expirationDate,
    CodeableConcept? site,
    CodeableConcept? route,
    Quantity? doseQuantity,
    List<ImmunizationPerformer>? performer,
    List<Annotation>? note,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    FhirBoolean? isSubpotent,
    List<CodeableConcept>? subpotentReason,
    List<ImmunizationEducation>? education,
    List<CodeableConcept>? programEligibility,
    CodeableConcept? fundingSource,
    List<ImmunizationReaction>? reaction,
    List<ImmunizationProtocolApplied>? protocolApplied,
  }) = _Immunization;

  @override
  FhirType get fhirType => FhirType.Immunization;

  factory Immunization.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirImmunization = fhir_r4.Immunization.fromJson(resourceJson);

    return Immunization(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      text: fhirImmunization.text,
      identifier: fhirImmunization.identifier,
      status: fhirImmunization.status,
      statusReason: fhirImmunization.statusReason,
      vaccineCode: fhirImmunization.vaccineCode,
      patient: fhirImmunization.patient,
      encounter: fhirImmunization.encounter,
      recorded: fhirImmunization.recorded,
      primarySource: fhirImmunization.primarySource,
      reportOrigin: fhirImmunization.reportOrigin,
      location: fhirImmunization.location,
      manufacturer: fhirImmunization.manufacturer,
      lotNumber: fhirImmunization.lotNumber,
      expirationDate: fhirImmunization.expirationDate,
      site: fhirImmunization.site,
      route: fhirImmunization.route,
      doseQuantity: fhirImmunization.doseQuantity,
      performer: fhirImmunization.performer,
      note: fhirImmunization.note,
      reasonCode: fhirImmunization.reasonCode,
      reasonReference: fhirImmunization.reasonReference,
      isSubpotent: fhirImmunization.isSubpotent,
      subpotentReason: fhirImmunization.subpotentReason,
      education: fhirImmunization.education,
      programEligibility: fhirImmunization.programEligibility,
      fundingSource: fhirImmunization.fundingSource,
      reaction: fhirImmunization.reaction,
      protocolApplied: fhirImmunization.protocolApplied,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(vaccineCode);
    if (displayText != null) return displayText;

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
      patient?.reference?.valueString,
      encounter?.reference?.valueString,
      location?.reference?.valueString,
      manufacturer?.reference?.valueString,
      ...?reasonReference?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
