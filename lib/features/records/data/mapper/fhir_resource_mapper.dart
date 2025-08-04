import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:injectable/injectable.dart';

// TODO: map specific properties to resources using the fhir_r4 package
@injectable
class FhirResourceMapper {
  const FhirResourceMapper();

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
        return Medication(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "MedicationAdministration":
        return MedicationAdministration(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "MedicationDispense":
        return MedicationDispense(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "MedicationRequest":
        return MedicationRequest(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
        );
      case "MedicationStatement":
        return MedicationStatement(
          id: data.id,
          sourceId: data.sourceId ?? '',
          resourceId: data.resourceId ?? '',
          title: data.title ?? '',
          date: data.date ?? DateTime.now(),
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
