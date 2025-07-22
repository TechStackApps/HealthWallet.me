import 'package:intl/intl.dart';

/// Generic display model for any FHIR resource type for UI presentation
class FhirDisplayModel {
  final String id;
  final String resourceType;
  final String primaryDisplay;
  final String? secondaryDisplay;
  final String? date;
  final String? status;
  final String? category;
  final List<String> additionalInfo;
  final Map<String, dynamic> rawResource;

  const FhirDisplayModel({
    required this.id,
    required this.resourceType,
    required this.primaryDisplay,
    this.secondaryDisplay,
    this.date,
    this.status,
    this.category,
    this.additionalInfo = const [],
    required this.rawResource,
  });

  /// Create from display data built by DisplayModelBuilder
  factory FhirDisplayModel.fromDisplayData(Map<String, dynamic> displayData) {
    return FhirDisplayModel(
      id: displayData['id'] as String,
      resourceType: displayData['resourceType'] as String,
      primaryDisplay: displayData['primaryDisplay'] as String,
      secondaryDisplay: displayData['secondaryDisplay'] as String?,
      date: displayData['date'] as String?,
      status: displayData['status'] as String?,
      category: displayData['category'] as String?,
      additionalInfo:
          (displayData['additionalInfo'] as List<dynamic>?)?.cast<String>() ??
              [],
      rawResource: displayData['rawResource'] as Map<String, dynamic>,
    );
  }

  /// Factory for creating from EncounterDisplayModel
  factory FhirDisplayModel.fromEncounter(dynamic encounter) {
    return FhirDisplayModel(
      id: encounter.id,
      resourceType: 'Encounter',
      primaryDisplay: encounter.encounterType,
      secondaryDisplay: encounter.patientDisplay,
      date: encounter.startDate,
      additionalInfo: [
        ...encounter.practitionerNames,
        encounter.organizationName,
        ...encounter.locationNames,
      ],
      rawResource: encounter.rawEncounter,
    );
  }

  /// Factory for creating from FhirResourceDisplayModel
  factory FhirDisplayModel.fromResource(dynamic resource) {
    return FhirDisplayModel(
      id: resource.id,
      resourceType: resource.resourceType,
      primaryDisplay: resource.primaryDisplay,
      secondaryDisplay: resource.secondaryDisplay,
      date: resource.date,
      status: resource.status,
      category: resource.category,
      additionalInfo: resource.additionalInfo,
      rawResource: resource.rawResource,
    );
  }

  /// Formatted date for display (e.g., "March 15, 2024")
  String? get formattedDate {
    if (date == null) return null;
    try {
      final parsedDate = DateTime.parse(date!);
      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (_) {
      return date;
    }
  }

  /// Display name for the resource (used as primary display in UI)
  String get display => resourceType;

  /// Whether this resource has a status
  bool get hasStatus => status != null && status!.isNotEmpty;

  /// Whether this resource has a category
  bool get hasCategory => category != null && category!.isNotEmpty;

  /// Whether this resource has additional information
  bool get hasAdditionalInfo => additionalInfo.isNotEmpty;

  /// Get a summary line for the resource
  String get summary {
    final parts = <String>[];
    if (hasCategory) parts.add(category!);
    if (hasStatus) parts.add(status!);
    if (date != null) parts.add(formattedDate ?? date!);
    return parts.join(' • ');
  }

  @override
  String toString() {
    return 'FhirDisplayModel(resourceType: $resourceType, '
        'primaryDisplay: $primaryDisplay, id: $id)';
  }
}
