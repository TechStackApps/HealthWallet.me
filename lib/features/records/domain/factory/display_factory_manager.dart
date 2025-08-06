import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/factory/entity_display_factories.dart';

/// Simplified factory manager for display model creation only
/// Uses entity-based factories following the same pattern as data layer factories
class DisplayFactoryManager {
  const DisplayFactoryManager._();
  static const DisplayFactoryManager instance = DisplayFactoryManager._();

  /// Build complete display model from any FHIR entity using entity factories
  FhirResourceDisplayModel buildDisplayModel(IFhirResource resource) {
    final factory = _getEntityFactory(resource);
    return factory.buildFromEntity(resource);
  }

  /// Extract just the title from any FHIR entity (for backward compatibility)
  String extractTitle(IFhirResource resource) {
    final factory = _getEntityFactory(resource);
    return factory.extractPrimaryDisplay(resource);
  }

  /// Get the appropriate entity factory for the resource type
  BaseEntityDisplayFactory _getEntityFactory(IFhirResource resource) {
    switch (resource.fhirType) {
      case FhirType.Patient:
        return PatientEntityDisplayFactory();
      case FhirType.Observation:
        return ObservationEntityDisplayFactory();
      case FhirType.Encounter:
        return EncounterEntityDisplayFactory();
      case FhirType.Condition:
        return ConditionEntityDisplayFactory();
      case FhirType.AllergyIntolerance:
        return AllergyIntoleranceEntityDisplayFactory();
      case FhirType.Medication:
        return MedicationEntityDisplayFactory();
      case FhirType.MedicationRequest:
        return MedicationRequestEntityDisplayFactory();
      case FhirType.Procedure:
        return ProcedureEntityDisplayFactory();
      case FhirType.DiagnosticReport:
        return DiagnosticReportEntityDisplayFactory();
      case FhirType.DocumentReference:
        return DocumentReferenceEntityDisplayFactory();
      case FhirType.Immunization:
        return ImmunizationEntityDisplayFactory();
      case FhirType.CareTeam:
        return CareTeamEntityDisplayFactory();
      case FhirType.Goal:
        return GoalEntityDisplayFactory();
      case FhirType.Location:
        return LocationEntityDisplayFactory();
      case FhirType.Organization:
        return OrganizationEntityDisplayFactory();
      case FhirType.Practitioner:
        return PractitionerEntityDisplayFactory();
      case FhirType.PractitionerRole:
        return PractitionerRoleEntityDisplayFactory();
      case FhirType.RelatedPerson:
        return RelatedPersonEntityDisplayFactory();
      case FhirType.ServiceRequest:
        return ServiceRequestEntityDisplayFactory();
      case FhirType.Specimen:
        return SpecimenEntityDisplayFactory();
      case FhirType.Binary:
        return BinaryEntityDisplayFactory();
      case FhirType.Media:
        return MediaEntityDisplayFactory();
      case FhirType.AdverseEvent:
        return AdverseEventEntityDisplayFactory();
      case FhirType.Claim:
        return ClaimEntityDisplayFactory();
      case FhirType.ExplanationOfBenefit:
        return ExplanationOfBenefitEntityDisplayFactory();
      case FhirType.Coverage:
        return CoverageEntityDisplayFactory();
      default:
        return DefaultEntityDisplayFactory();
    }
  }
}

/// Default factory for unhandled resource types
class DefaultEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Unknown';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    return entity.title.isNotEmpty ? entity.title : 'Unknown Resource';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    return entity.date?.toString();
  }

  @override
  String? extractStatus(IFhirResource entity) {
    return null;
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null;
  }

  @override
  String? extractDate(IFhirResource entity) {
    // Return null if no date to show SizedBox in UI
    return entity.date?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final additionalInfo = <String>[];

    // Add resource type
    additionalInfo.add('Type: ${entity.fhirType.display}');

    // Add date if available
    if (entity.date != null) {
      additionalInfo.add('Date: ${entity.date.toString()}');
    }

    // Add source if available
    if (entity.sourceId.isNotEmpty) {
      additionalInfo.add('Source: ${entity.sourceId}');
    }

    return additionalInfo;
  }
}
