import 'package:flutter/material.dart';

/// Configuration class for resource card appearance
class ResourceCardConfig {
  final IconData icon;
  final Color color;
  final String displayName;
  final List<String> primaryFields;
  final List<String> secondaryFields;

  const ResourceCardConfig({
    required this.icon,
    required this.color,
    required this.displayName,
    this.primaryFields = const [],
    this.secondaryFields = const [],
  });
}

/// Configuration registry for all resource types
class ResourceCardConfigs {
  static final Map<String, ResourceCardConfig> _configs = {
    // Medical Resources
    'AllergyIntolerance': const ResourceCardConfig(
      icon: Icons.warning,
      color: Colors.red,
      displayName: 'Allergy/Intolerance',
      primaryFields: ['substance', 'code', 'title'],
      secondaryFields: ['status', 'category', 'severity'],
    ),
    'Condition': const ResourceCardConfig(
      icon: Icons.medical_services,
      color: Colors.orange,
      displayName: 'Condition',
      primaryFields: ['code', 'title'],
      secondaryFields: ['status', 'severity', 'clinicalStatus'],
    ),
    'Procedure': const ResourceCardConfig(
      icon: Icons.healing,
      color: Colors.green,
      displayName: 'Procedure',
      primaryFields: ['code', 'title'],
      secondaryFields: ['status', 'performedDateTime'],
    ),
    'MedicationRequest': const ResourceCardConfig(
      icon: Icons.medication,
      color: Colors.purple,
      displayName: 'Medication Request',
      primaryFields: ['medication', 'code'],
      secondaryFields: ['status', 'dosage', 'intent'],
    ),
    'Medication': const ResourceCardConfig(
      icon: Icons.local_pharmacy,
      color: Colors.deepPurple,
      displayName: 'Medication',
      primaryFields: ['code', 'title'],
      secondaryFields: ['status', 'form'],
    ),
    'Observation': const ResourceCardConfig(
      icon: Icons.analytics,
      color: Colors.teal,
      displayName: 'Observation',
      primaryFields: ['code', 'title'],
      secondaryFields: ['status', 'value', 'category'],
    ),
    'DiagnosticReport': const ResourceCardConfig(
      icon: Icons.assessment,
      color: Colors.indigo,
      displayName: 'Diagnostic Report',
      primaryFields: ['code', 'title'],
      secondaryFields: ['status', 'category', 'conclusion'],
    ),
    'Immunization': const ResourceCardConfig(
      icon: Icons.vaccines,
      color: Colors.pink,
      displayName: 'Immunization',
      primaryFields: ['vaccineCode', 'code'],
      secondaryFields: ['status', 'occurrenceDateTime'],
    ),
    'CarePlan': const ResourceCardConfig(
      icon: Icons.medical_information,
      color: Colors.brown,
      displayName: 'Care Plan',
      primaryFields: ['title', 'code'],
      secondaryFields: ['status', 'intent', 'category'],
    ),
    'Goal': const ResourceCardConfig(
      icon: Icons.flag,
      color: Colors.amber,
      displayName: 'Goal',
      primaryFields: ['description', 'code'],
      secondaryFields: ['status', 'lifecycleStatus'],
    ),
    'DocumentReference': const ResourceCardConfig(
      icon: Icons.description,
      color: Colors.cyan,
      displayName: 'Document',
      primaryFields: ['title', 'type'],
      secondaryFields: ['status', 'category'],
    ),
    'Media': const ResourceCardConfig(
      icon: Icons.photo_library,
      color: Colors.deepOrange,
      displayName: 'Media',
      primaryFields: ['type', 'title'],
      secondaryFields: ['status', 'deviceName'],
    ),
    'Appointment': const ResourceCardConfig(
      icon: Icons.event,
      color: Colors.blueAccent,
      displayName: 'Appointment',
      primaryFields: ['description', 'type'],
      secondaryFields: ['status', 'start'],
    ),
    'Device': const ResourceCardConfig(
      icon: Icons.device_hub,
      color: Colors.grey,
      displayName: 'Device',
      primaryFields: ['type', 'model'],
      secondaryFields: ['status', 'manufacturer'],
    ),
    'Claim': const ResourceCardConfig(
      icon: Icons.receipt,
      color: Colors.lightGreen,
      displayName: 'Claim',
      primaryFields: ['type', 'title'],
      secondaryFields: ['status', 'use'],
    ),
    'ExplanationOfBenefit': const ResourceCardConfig(
      icon: Icons.account_balance,
      color: Colors.lightBlue,
      displayName: 'Explanation of Benefit',
      primaryFields: ['type', 'title'],
      secondaryFields: ['status', 'use'],
    ),

    // Structural Resources
    'Patient': const ResourceCardConfig(
      icon: Icons.person,
      color: Colors.lightGreen,
      displayName: 'Patient',
      primaryFields: ['name', 'fullName'],
      secondaryFields: ['gender', 'birthDate'],
    ),
    'Practitioner': const ResourceCardConfig(
      icon: Icons.medical_services,
      color: Colors.lightBlue,
      displayName: 'Practitioner',
      primaryFields: ['name', 'fullName'],
      secondaryFields: ['gender', 'qualification'],
    ),
    'Organization': const ResourceCardConfig(
      icon: Icons.business,
      color: Colors.deepPurple,
      displayName: 'Organization',
      primaryFields: ['name', 'title'],
      secondaryFields: ['type', 'address'],
    ),
    'Location': const ResourceCardConfig(
      icon: Icons.location_on,
      color: Colors.lime,
      displayName: 'Location',
      primaryFields: ['name', 'title'],
      secondaryFields: ['status', 'address'],
    ),
    'RelatedPerson': const ResourceCardConfig(
      icon: Icons.people,
      color: Colors.teal,
      displayName: 'Related Person',
      primaryFields: ['name', 'fullName'],
      secondaryFields: ['relationship', 'gender'],
    ),

    // Encounter (special case - handled separately)
    'Encounter': const ResourceCardConfig(
      icon: Icons.local_hospital,
      color: Colors.blue,
      displayName: 'Encounter',
      primaryFields: ['type', 'class'],
      secondaryFields: ['status', 'period'],
    ),

    // Binary and others
    'Binary': const ResourceCardConfig(
      icon: Icons.attachment,
      color: Colors.grey,
      displayName: 'Binary',
      primaryFields: ['contentType', 'title'],
      secondaryFields: ['size', 'creation'],
    ),
  };

  /// Get configuration for a resource type
  static ResourceCardConfig getConfig(String resourceType) {
    return _configs[resourceType] ?? _getDefaultConfig(resourceType);
  }

  /// Get default configuration for unknown resource types
  static ResourceCardConfig _getDefaultConfig(String resourceType) {
    return ResourceCardConfig(
      icon: Icons.help_outline,
      color: Colors.grey,
      displayName: resourceType,
      primaryFields: const ['title', 'name', 'code'],
      secondaryFields: const ['status', 'type'],
    );
  }

  /// Get all available resource types
  static List<String> getAllResourceTypes() {
    return _configs.keys.toList();
  }

  /// Get medical resource types only
  static List<String> getMedicalResourceTypes() {
    return [
      'AllergyIntolerance',
      'Condition',
      'Procedure',
      'MedicationRequest',
      'Medication',
      'Observation',
      'DiagnosticReport',
      'Immunization',
      'CarePlan',
      'Goal',
      'DocumentReference',
      'Media',
      'Appointment',
      'Device',
      'Claim',
      'ExplanationOfBenefit',
    ];
  }

  /// Get structural resource types only
  static List<String> getStructuralResourceTypes() {
    return [
      'Patient',
      'Practitioner',
      'Organization',
      'Location',
      'RelatedPerson',
    ];
  }

  /// Check if a resource type is medical
  static bool isMedicalResourceType(String resourceType) {
    return getMedicalResourceTypes().contains(resourceType);
  }

  /// Check if a resource type is structural
  static bool isStructuralResourceType(String resourceType) {
    return getStructuralResourceTypes().contains(resourceType);
  }
}
