import 'dart:convert';
import 'package:fhir_r4/fhir_r4.dart' as fhir;
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:injectable/injectable.dart';

// TODO: map specific properties to resources using the fhir_r4 package
@injectable
class FhirResourceMapper {
  const FhirResourceMapper();

  fhir.Resource _parseFhirResource(FhirResourceLocalDto data) {
    try {
      final resourceJson = jsonDecode(data.resourceRaw);
      return fhir.Resource.fromJson(resourceJson);
    } catch (e) {
      print('Warning: Failed to parse FHIR resource ${data.resourceType}: $e');
      rethrow;
    }
  }

  IFhirResource mapResourceFromLocalData(FhirResourceLocalDto data) {
    switch (data.resourceType) {
      case "AdverseEvent":
        return AdverseEvent(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "AllergyIntolerance":
        return AllergyIntolerance(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Binary":
        return Binary(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "CareTeam":
        return CareTeam(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Condition":
        return Condition(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "DiagnosticReport":
        return DiagnosticReport(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "DocumentReference":
        return DocumentReference(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Encounter":
        return Encounter(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Goal":
        return Goal(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Immunization":
        return Immunization(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Location":
        return Location(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Media":
        return Media(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Medication":
        final fhirMedication = _parseFhirResource(data) as fhir.Medication;
        return Medication(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
          text: fhirMedication.text,
          identifier: fhirMedication.identifier,
          code: fhirMedication.code,
          status: fhirMedication.status,
          manufacturer: fhirMedication.manufacturer,
          form: fhirMedication.form,
          amount: fhirMedication.amount,
          ingredient: fhirMedication.ingredient,
          batch: fhirMedication.batch,
        );
      case "MedicationAdministration":
        final fhirMedicationAdministration =
            _parseFhirResource(data) as fhir.MedicationAdministration;
        return MedicationAdministration(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
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
          supportingInformation:
              fhirMedicationAdministration.supportingInformation,
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
      case "MedicationDispense":
        final fhirMedicationDispense =
            _parseFhirResource(data) as fhir.MedicationDispense;
        return MedicationDispense(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
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
          authorizingPrescription:
              fhirMedicationDispense.authorizingPrescription,
          type: fhirMedicationDispense.type,
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
      case "MedicationRequest":
        final fhirMedicationRequest =
            _parseFhirResource(data) as fhir.MedicationRequest;
        return MedicationRequest(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
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
      case "MedicationStatement":
        final fhirMedicationStatement =
            _parseFhirResource(data) as fhir.MedicationStatement;
        return MedicationStatement(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
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
      case "Observation":
        return Observation(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Organization":
        return Organization(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Patient":
        return Patient(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Practitioner":
        return Practitioner(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "PractitionerRole":
        return PractitionerRole(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Procedure":
        return Procedure(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "RelatedPerson":
        return RelatedPerson(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "ServiceRequest":
        return ServiceRequest(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "Specimen":
        return Specimen(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      default:
        return GeneralResource(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
    }
  }
}
