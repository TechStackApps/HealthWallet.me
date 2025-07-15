import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/allergy_intolerance/allergy_intolerance.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/binary/binary.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/condition/condition.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/diagnostic_report/diagnostic_report.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/goal/goal.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/document_reference/document_reference.dart';
import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/immunization/immunization.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/location/location.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/media/media.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/medication/medication.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/medication_request/medication_request.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/observation/observation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/organization/organization.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/patient/patient.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/practitioner/practitioner.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resources/procedure/procedure.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/allergy_intolerance_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/binary_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/condition_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/diagnostic_report_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/goal_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/document_reference_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/encounter_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/immunization_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/location_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/media_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/medication_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/medication_request_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/observation_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/organization_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/patient_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/practitioner_card.dart';
import 'package:health_wallet/features/records/presentation/widgets/fhir_cards/procedure_card.dart';

class FhirResourceViewer extends StatelessWidget {
  final FhirResource resource;

  const FhirResourceViewer({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    switch (resource.resourceType) {
      case 'Patient':
        return PatientCard(patient: Patient.fromJson(resource.resourceJson));
      case 'Observation':
        return ObservationCard(
            observation: Observation.fromJson(resource.resourceJson));
      case 'MedicationRequest':
        return MedicationRequestCard(
            medicationRequest:
                MedicationRequest.fromJson(resource.resourceJson));
      case 'Condition':
        return ConditionCard(
          condition: Condition.fromJson(resource.resourceJson),
        );
      case 'Goal':
        return GoalCard(
          goal: Goal.fromJson(resource.resourceJson),
        );
      case 'Immunization':
        return ImmunizationCard(
            immunization: Immunization.fromJson(resource.resourceJson));
      case 'Procedure':
        return ProcedureCard(
            procedure: Procedure.fromJson(resource.resourceJson));
      case 'Encounter':
        return EncounterCard(
          displayModel: _createEncounterDisplayModel(resource),
        );
      case 'AllergyIntolerance':
        return AllergyIntoleranceCard(
            allergy: AllergyIntolerance.fromJson(resource.resourceJson));
      case 'DiagnosticReport':
        return DiagnosticReportCard(
            report: DiagnosticReport.fromJson(resource.resourceJson));
      case 'DocumentReference':
        return DocumentReferenceCard(
            document: DocumentReference.fromJson(resource.resourceJson));
      case 'Medication':
        return MedicationCard(
            medication: Medication.fromJson(resource.resourceJson));
      case 'Binary':
        return BinaryCard(binary: Binary.fromJson(resource.resourceJson));
      case 'Location':
        return LocationCard(location: Location.fromJson(resource.resourceJson));
      case 'Media':
        return MediaCard(media: Media.fromJson(resource.resourceJson));
      case 'Organization':
        return OrganizationCard(
            organization: Organization.fromJson(resource.resourceJson));
      case 'Practitioner':
        return PractitionerCard(
            practitioner: Practitioner.fromJson(resource.resourceJson));
      default:
        return _DefaultViewer(resource: resource.resourceJson);
    }
  }

  EncounterDisplayModel _createEncounterDisplayModel(FhirResource resource) {
    // Create a minimal display model for legacy FhirResource
    // In new architecture, use RecordsService.getEncountersForDisplay() instead
    return EncounterDisplayModel(
      id: resource.id ?? '',
      patientDisplay:
          'Patient', // Placeholder - relationships not resolved in legacy mode
      encounterType: resource.resourceJson['class']?['display'] ?? 'Encounter',
      practitionerNames: const [], // Empty - relationships not resolved
      organizationName: '', // Empty - relationships not resolved
      locationNames: const [], // Empty - relationships not resolved
      rawEncounter: resource.resourceJson,
    );
  }
}

class _DefaultViewer extends StatelessWidget {
  final Map<String, dynamic> resource;

  const _DefaultViewer({required this.resource});

  @override
  Widget build(BuildContext context) {
    const jsonEncoder = JsonEncoder.withIndent('  ');
    final prettyJson = jsonEncoder.convert(resource);
    return Text(prettyJson);
  }
}
