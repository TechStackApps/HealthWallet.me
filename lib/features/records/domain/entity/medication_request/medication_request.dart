import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'medication_request.freezed.dart';

@freezed
class MedicationRequest with _$MedicationRequest implements IFhirResource {
  const MedicationRequest._();

  factory MedicationRequest({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    MedicationrequestStatus? status,
    CodeableConcept? statusReason,
    MedicationRequestIntent? intent,
    List<CodeableConcept>? category,
    RequestPriority? priority,
    FhirBoolean? doNotPerform,
    ReportedXMedicationRequest? reportedX,
    MedicationXMedicationRequest? medicationX,
    Reference? subject,
    Reference? encounter,
    List<Reference>? supportingInformation,
    FhirDateTime? authoredOn,
    Reference? requester,
    Reference? performer,
    CodeableConcept? performerType,
    Reference? recorder,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<FhirCanonical>? instantiatesCanonical,
    List<FhirUri>? instantiatesUri,
    List<Reference>? basedOn,
    Identifier? groupIdentifier,
    CodeableConcept? courseOfTherapyType,
    List<Reference>? insurance,
    List<Annotation>? note,
    List<Dosage>? dosageInstruction,
    MedicationRequestDispenseRequest? dispenseRequest,
    MedicationRequestSubstitution? substitution,
    Reference? priorPrescription,
    List<Reference>? detectedIssue,
    List<Reference>? eventHistory,
  }) = _MedicationRequest;

  @override
  FhirType get fhirType => FhirType.MedicationRequest;

  factory MedicationRequest.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedicationRequest =
        fhir_r4.MedicationRequest.fromJson(resourceJson);

    return MedicationRequest(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirMedicationRequest.text,
      identifier: fhirMedicationRequest.identifier,
      status: fhirMedicationRequest.status,
      statusReason: fhirMedicationRequest.statusReason,
      intent: fhirMedicationRequest.intent,
      category: fhirMedicationRequest.category,
      priority: fhirMedicationRequest.priority,
      doNotPerform: fhirMedicationRequest.doNotPerform,
      reportedX: fhirMedicationRequest.reportedX,
      medicationX: fhirMedicationRequest.medicationX,
      subject: fhirMedicationRequest.subject,
      encounter: fhirMedicationRequest.encounter,
      supportingInformation: fhirMedicationRequest.supportingInformation,
      authoredOn: fhirMedicationRequest.authoredOn,
      requester: fhirMedicationRequest.requester,
      performer: fhirMedicationRequest.performer,
      performerType: fhirMedicationRequest.performerType,
      recorder: fhirMedicationRequest.recorder,
      reasonCode: fhirMedicationRequest.reasonCode,
      reasonReference: fhirMedicationRequest.reasonReference,
      instantiatesCanonical: fhirMedicationRequest.instantiatesCanonical,
      instantiatesUri: fhirMedicationRequest.instantiatesUri,
      basedOn: fhirMedicationRequest.basedOn,
      groupIdentifier: fhirMedicationRequest.groupIdentifier,
      courseOfTherapyType: fhirMedicationRequest.courseOfTherapyType,
      insurance: fhirMedicationRequest.insurance,
      note: fhirMedicationRequest.note,
      dosageInstruction: fhirMedicationRequest.dosageInstruction,
      dispenseRequest: fhirMedicationRequest.dispenseRequest,
      substitution: fhirMedicationRequest.substitution,
      priorPrescription: fhirMedicationRequest.priorPrescription,
      detectedIssue: fhirMedicationRequest.detectedIssue,
      eventHistory: fhirMedicationRequest.eventHistory,
    );
  }
}
