import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'medication_administration.freezed.dart';

@freezed
class MedicationAdministration
    with _$MedicationAdministration
    implements IFhirResource {
  const MedicationAdministration._();

  const factory MedicationAdministration({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    @Default('') String encounterId,
    @Default('') String subjectId,
    Narrative? text,
    List<Identifier>? identifier,
    List<FhirUri>? instantiates,
    List<Reference>? partOf,
    MedicationAdministrationStatusCodes? status,
    List<CodeableConcept>? statusReason,
    CodeableConcept? category,
    MedicationXMedicationAdministration? medicationX,
    Reference? subject,
    Reference? context,
    List<Reference>? supportingInformation,
    EffectiveXMedicationAdministration? effectiveX,
    List<MedicationAdministrationPerformer>? performer,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    Reference? request,
    List<Reference>? device,
    List<Annotation>? note,
    MedicationAdministrationDosage? dosage,
    List<Reference>? eventHistory,
  }) = _MedicationAdministration;

  @override
  FhirType get fhirType => FhirType.MedicationAdministration;

  factory MedicationAdministration.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedicationAdministration =
        fhir_r4.MedicationAdministration.fromJson(resourceJson);

    return MedicationAdministration(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      encounterId: data.encounterId ?? '',
      subjectId: data.subjectId ?? '',
      text: fhirMedicationAdministration.text,
      identifier: fhirMedicationAdministration.identifier,
      instantiates: fhirMedicationAdministration.instantiates,
      partOf: fhirMedicationAdministration.partOf,
      status: fhirMedicationAdministration.status,
      statusReason: fhirMedicationAdministration.statusReason,
      category: fhirMedicationAdministration.category,
      medicationX: fhirMedicationAdministration.medicationX,
      subject: fhirMedicationAdministration.subject,
      context: fhirMedicationAdministration.context,
      supportingInformation: fhirMedicationAdministration.supportingInformation,
      effectiveX: fhirMedicationAdministration.effectiveX,
      performer: fhirMedicationAdministration.performer,
      reasonCode: fhirMedicationAdministration.reasonCode,
      reasonReference: fhirMedicationAdministration.reasonReference,
      request: fhirMedicationAdministration.request,
      device: fhirMedicationAdministration.device,
      note: fhirMedicationAdministration.note,
      dosage: fhirMedicationAdministration.dosage,
      eventHistory: fhirMedicationAdministration.eventHistory,
    );
  }

  @override
  FhirResourceDto toDto() => FhirResourceDto(
        id: id,
        sourceId: sourceId,
        resourceType: 'MedicationAdministration',
        resourceId: resourceId,
        title: title,
        date: date,
        resourceRaw: rawResource,
        encounterId: encounterId,
        subjectId: subjectId,
      );

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText = FhirFieldExtractor.extractCodeableConceptText(category);
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

    final medicationDisplay = FhirFieldExtractor.extractCodeableConceptText(
        medicationX?.isAs<CodeableConcept>());
    if (medicationDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.medication,
        info: medicationDisplay,
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
      subject?.reference?.valueString,
      context?.reference?.valueString,
      request?.reference?.valueString,
      ...?partOf?.map((reference) => reference.reference?.valueString),
      ...?supportingInformation
          ?.map((reference) => reference.reference?.valueString),
      ...?reasonReference?.map((reference) => reference.reference?.valueString),
      ...?device?.map((reference) => reference.reference?.valueString),
      ...?eventHistory?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
