import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'medication_dispense.freezed.dart';

@freezed
class MedicationDispense with _$MedicationDispense implements IFhirResource {
  const MedicationDispense._();

  factory MedicationDispense({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
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
}
