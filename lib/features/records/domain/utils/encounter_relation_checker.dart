import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/core/utils/logger.dart';

/// Utility class to check if a FHIR resource is related to an encounter
class EncounterRelationChecker {
  /// Check if a Reference is valid (has a meaningful reference)
  static bool _isValidReference(fhir_r4.Reference? reference) {
    if (reference == null) return false;

    // For fhir_r4 Reference, check if the reference string is not null and not empty
    return reference.reference != null && reference.reference!.isNotEmpty;
  }

  /// Check if a resource is related to an encounter (has encounter reference)
  static bool isEncounterRelated(IFhirResource resource) {
    // Add debug logging to see what type we're dealing with
    logger.d(
        '🔍 Checking resource type: ${resource.runtimeType}, fhirType: ${resource.fhirType}');

    switch (resource.fhirType) {
      // Resources that CAN have encounter references (check the field)
      case FhirType.Observation:
        final observation = resource as Observation;
        final hasEncounter = _isValidReference(observation.encounter);
        logger.d(
            '🔍 Observation ${observation.id}: encounter = ${observation.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.Procedure:
        final procedure = resource as Procedure;
        final hasEncounter = _isValidReference(procedure.encounter);
        logger.d(
            '🔍 Procedure ${procedure.id}: encounter = ${procedure.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.Immunization:
        final immunization = resource as Immunization;
        final hasEncounter = _isValidReference(immunization.encounter);
        logger.d(
            '🔍 Immunization ${immunization.id}: encounter = ${immunization.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.DiagnosticReport:
        final report = resource as DiagnosticReport;
        final hasEncounter = _isValidReference(report.encounter);
        logger.d(
            '🔍 DiagnosticReport ${report.id}: encounter = ${report.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.ServiceRequest:
        final request = resource as ServiceRequest;
        final hasEncounter = _isValidReference(request.encounter);
        logger.d(
            '🔍 ServiceRequest ${request.id}: encounter = ${request.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.MedicationRequest:
        final request = resource as MedicationRequest;
        final hasEncounter = _isValidReference(request.encounter);
        logger.d(
            '🔍 MedicationRequest ${request.id}: encounter = ${request.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.Media:
        final media = resource as Media;
        final hasEncounter = _isValidReference(media.encounter);
        logger.d(
            '🔍 Media ${media.id}: encounter = ${media.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.AdverseEvent:
        final event = resource as AdverseEvent;
        final hasEncounter = _isValidReference(event.encounter);
        logger.d(
            '🔍 AdverseEvent ${event.id}: encounter = ${event.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      // Resources that CAN have encounter references (check the field)
      case FhirType.CareTeam:
        final careTeam = resource as CareTeam;
        final hasEncounter = _isValidReference(careTeam.encounter);
        logger.d(
            '🔍 CareTeam ${careTeam.id}: encounter = ${careTeam.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      case FhirType.Condition:
        final condition = resource as Condition;
        final hasEncounter = _isValidReference(condition.encounter);
        logger.d(
            '🔍 Condition ${condition.id}: encounter = ${condition.encounter}, hasEncounter = $hasEncounter');
        return hasEncounter;

      // Resources that are NEVER related to encounters (standalone)
      case Patient:
      case Practitioner:
      case Organization:
      case Location:
      case Medication:
      case Goal:
      case DocumentReference:
      case Specimen:
      case Binary:
      case PractitionerRole:
      case RelatedPerson:
      case AllergyIntolerance:
        return false;

      // Encounter itself is the main resource
      case Encounter:
        return false; // Encounters are the main timeline items

      default:
        // For any other resource types, check if they have encounter reference
        return _hasEncounterReference(resource);
    }
  }

  /// Check if a resource has an encounter reference (fallback method)
  static bool _hasEncounterReference(IFhirResource resource) {
    // For any unhandled resource types, assume they're not encounter-related
    // This is a conservative approach - we can add specific cases as needed
    return false;
  }

  /// Check if a resource should be displayed in the timeline
  static bool shouldDisplayInTimeline(IFhirResource resource) {
    final isRelated = isEncounterRelated(resource);
    final shouldDisplay = !isRelated;

    logger.d(
        '🔍 EncounterRelationChecker: ${resource.fhirType} (${resource.runtimeType}) - isRelated: $isRelated, shouldDisplay: $shouldDisplay');

    return shouldDisplay;
  }
}
