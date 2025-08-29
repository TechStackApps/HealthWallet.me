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

part 'medication_statement.freezed.dart';

@freezed
class MedicationStatement with _$MedicationStatement implements IFhirResource {
  const MedicationStatement._();

  const factory MedicationStatement({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    MedicationStatementStatusCodes? status,
    List<CodeableConcept>? statusReason,
    CodeableConcept? category,
    MedicationXMedicationStatement? medicationX,
    Reference? subject,
    Reference? context,
    EffectiveXMedicationStatement? effectiveX,
    FhirDateTime? dateAsserted,
    Reference? informationSource,
    List<Reference>? derivedFrom,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<Annotation>? note,
    List<Dosage>? dosage,
  }) = _MedicationStatement;

  @override
  FhirType get fhirType => FhirType.MedicationStatement;

  factory MedicationStatement.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedicationStatement =
        fhir_r4.MedicationStatement.fromJson(resourceJson);

    return MedicationStatement(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      text: fhirMedicationStatement.text,
      identifier: fhirMedicationStatement.identifier,
      basedOn: fhirMedicationStatement.basedOn,
      partOf: fhirMedicationStatement.partOf,
      status: fhirMedicationStatement.status,
      statusReason: fhirMedicationStatement.statusReason,
      category: fhirMedicationStatement.category,
      medicationX: fhirMedicationStatement.medicationX,
      subject: fhirMedicationStatement.subject,
      context: fhirMedicationStatement.context,
      effectiveX: fhirMedicationStatement.effectiveX,
      dateAsserted: fhirMedicationStatement.dateAsserted,
      informationSource: fhirMedicationStatement.informationSource,
      derivedFrom: fhirMedicationStatement.derivedFrom,
      reasonCode: fhirMedicationStatement.reasonCode,
      reasonReference: fhirMedicationStatement.reasonReference,
      note: fhirMedicationStatement.note,
      dosage: fhirMedicationStatement.dosage,
    );
  }

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

    final statusDisplay = status?.display?.valueString;
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
      informationSource?.reference?.valueString,
      ...?basedOn?.map((reference) => reference.reference?.valueString),
      ...?partOf?.map((reference) => reference.reference?.valueString),
      ...?derivedFrom?.map((reference) => reference.reference?.valueString),
      ...?reasonReference?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
