import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'medication_statement.freezed.dart';

@freezed
class MedicationStatement with _$MedicationStatement implements IFhirResource {
  const MedicationStatement._();

  factory MedicationStatement({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
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
}
