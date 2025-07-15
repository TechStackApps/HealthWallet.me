import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/allergy_intolerance_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/condition_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/procedure_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/medication_request_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/observation_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/diagnostic_report_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/immunization_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/care_plan_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/goal_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/document_reference_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/media_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/patient_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/practitioner_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/organization_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/location_display_factory.dart';
import 'package:health_wallet/features/records/data/mapper/factories/encounter_display_factory.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

/// Manager for all display factories - eliminates switch statements
class DisplayFactoryManager {
  static final DisplayFactoryManager _instance =
      DisplayFactoryManager._internal();
  factory DisplayFactoryManager() => _instance;
  DisplayFactoryManager._internal();

  // Factory registry
  final Map<String, BaseDisplayFactory> _factories = {
    'AllergyIntolerance': AllergyIntoleranceDisplayFactory(),
    'Condition': ConditionDisplayFactory(),
    'Procedure': ProcedureDisplayFactory(),
    'MedicationRequest': MedicationRequestDisplayFactory(),
    'Observation': ObservationDisplayFactory(),
    'DiagnosticReport': DiagnosticReportDisplayFactory(),
    'Immunization': ImmunizationDisplayFactory(),
    'CarePlan': CarePlanDisplayFactory(),
    'Goal': GoalDisplayFactory(),
    'DocumentReference': DocumentReferenceDisplayFactory(),
    'Media': MediaDisplayFactory(),
    'Patient': PatientDisplayFactory(),
    'Practitioner': PractitionerDisplayFactory(),
    'Organization': OrganizationDisplayFactory(),
    'Location': LocationDisplayFactory(),
    'Encounter': EncounterDisplayFactory(),
  };

  /// Build display model from raw resource
  FhirResourceDisplayModel buildDisplayModel(Map<String, dynamic> rawResource) {
    final resourceType = rawResource['resourceType'] as String?;

    if (resourceType == null) {
      return _buildFallbackDisplayModel(rawResource);
    }

    final factory = _factories[resourceType];
    if (factory != null) {
      return factory.buildFromRaw(rawResource);
    }

    // Fallback for unknown resource types
    return _buildFallbackDisplayModel(rawResource);
  }

  /// Build fallback display model for unknown resource types
  FhirResourceDisplayModel _buildFallbackDisplayModel(
      Map<String, dynamic> rawResource) {
    final resourceType = rawResource['resourceType'] as String? ?? 'Unknown';
    final id = rawResource['id'] as String? ?? '';

    return FhirResourceDisplayModel(
      id: id,
      resourceType: resourceType,
      primaryDisplay: rawResource['name']?.toString() ??
          rawResource['title']?.toString() ??
          rawResource['text']?.toString() ??
          'Unknown $resourceType',
      secondaryDisplay: rawResource['status']?.toString(),
      status: rawResource['status']?.toString(),
      category: null,
      date: _extractFallbackDate(rawResource),
      additionalInfo: [],
      rawResource: rawResource,
    );
  }

  /// Extract date for fallback cases
  String? _extractFallbackDate(Map<String, dynamic> rawResource) {
    final dateFields = [
      'effectiveDateTime',
      'onsetDateTime',
      'recordedDate',
      'authoredOn',
      'performedDateTime',
      'issued',
      'date',
      'created',
    ];

    for (final field in dateFields) {
      final date = rawResource[field] as String?;
      if (date != null && date.isNotEmpty) {
        return date;
      }
    }

    // Try period.start
    final period = rawResource['period'] as Map<String, dynamic>?;
    return period?['start'] as String?;
  }

  /// Get all supported resource types
  List<String> get supportedResourceTypes => _factories.keys.toList();

  /// Check if a resource type is supported
  bool isSupported(String resourceType) => _factories.containsKey(resourceType);

  /// Register a new factory (for testing or extensions)
  void registerFactory(String resourceType, BaseDisplayFactory factory) {
    _factories[resourceType] = factory;
  }
}
