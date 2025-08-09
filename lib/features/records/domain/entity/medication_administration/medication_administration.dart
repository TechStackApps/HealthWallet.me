import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

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
}
