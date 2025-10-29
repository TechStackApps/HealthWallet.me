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

part 'medication_dispense.freezed.dart';

@freezed
class MedicationDispense with _$MedicationDispense implements IFhirResource {
  const MedicationDispense._();

  const factory MedicationDispense({
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
    List<Reference>? partOf,
    StatusReasonXMedicationDispense? statusReason,
    CodeableConcept? category,
    MedicationXMedicationDispense? medicationX,
    Reference? subject,
    Reference? context,
    List<Reference>? supportingInformation,
    List<MedicationDispensePerformer>? performer,
    Reference? location,
    List<Reference>? authorizingPrescription,
    CodeableConcept? type,
    Quantity? quantity,
    Quantity? daysSupply,
    FhirDateTime? whenPrepared,
    FhirDateTime? whenHandedOver,
    Reference? destination,
    List<Reference>? receiver,
    List<Annotation>? note,
    List<Dosage>? dosageInstruction,
    MedicationDispenseSubstitution? substitution,
    List<Reference>? detectedIssue,
    List<Reference>? eventHistory,
  }) = _MedicationDispense;

  @override
  FhirType get fhirType => FhirType.MedicationDispense;

  factory MedicationDispense.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedicationDispense =
        fhir_r4.MedicationDispense.fromJson(resourceJson);

    return MedicationDispense(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      encounterId: data.encounterId ?? '',
      subjectId: data.subjectId ?? '',
      text: fhirMedicationDispense.text,
      identifier: fhirMedicationDispense.identifier,
      partOf: fhirMedicationDispense.partOf,
      statusReason: fhirMedicationDispense.statusReasonX,
      category: fhirMedicationDispense.category,
      medicationX: fhirMedicationDispense.medicationX,
      subject: fhirMedicationDispense.subject,
      context: fhirMedicationDispense.context,
      supportingInformation: fhirMedicationDispense.supportingInformation,
      performer: fhirMedicationDispense.performer,
      location: fhirMedicationDispense.location,
      authorizingPrescription: fhirMedicationDispense.authorizingPrescription,
      type: fhirMedicationDispense.type,
      quantity: fhirMedicationDispense.quantity,
      daysSupply: fhirMedicationDispense.daysSupply,
      whenPrepared: fhirMedicationDispense.whenPrepared,
      whenHandedOver: fhirMedicationDispense.whenHandedOver,
      destination: fhirMedicationDispense.destination,
      receiver: fhirMedicationDispense.receiver,
      note: fhirMedicationDispense.note,
      dosageInstruction: fhirMedicationDispense.dosageInstruction,
      substitution: fhirMedicationDispense.substitution,
      detectedIssue: fhirMedicationDispense.detectedIssue,
      eventHistory: fhirMedicationDispense.eventHistory,
    );
  }

  @override
  FhirResourceDto toLocalDto() => FhirResourceDto(
        id: id,
        sourceId: sourceId,
        resourceType: 'MedicationDispense',
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

    final displayText = FhirFieldExtractor.extractCodeableConceptText(type);
    if (displayText != null) return displayText;

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final categoryDisplay =
        FhirFieldExtractor.extractCodeableConceptText(category);
    if (categoryDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: categoryDisplay,
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
      location?.reference?.valueString,
      destination?.reference?.valueString,
      ...?partOf?.map((reference) => reference.reference?.valueString),
      ...?supportingInformation
          ?.map((reference) => reference.reference?.valueString),
      ...?authorizingPrescription
          ?.map((reference) => reference.reference?.valueString),
      ...?receiver?.map((reference) => reference.reference?.valueString),
      ...?detectedIssue?.map((reference) => reference.reference?.valueString),
      ...?eventHistory?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => '';
}
