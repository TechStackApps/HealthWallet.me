import 'package:fhir_r4/fhir_r4.dart' as fhir;
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart'
    as entity;
import 'package:injectable/injectable.dart';

/// Service for deduplicating patients across multiple sources using FHIR identifiers
///
/// FHIR Matching Strategy:
/// - Patients are considered the same if they share ANY matching identifier
/// - Identifiers are matched by system + value combination
/// - This follows FHIR best practices for patient matching across organizations
@injectable
class PatientDeduplicationService {
  /// Groups patients by their FHIR identifiers
  /// Returns a map where key is a representative patient ID and value is list of all source IDs
  Map<String, PatientGroup> deduplicatePatients(
      List<entity.Patient> allPatients) {
    // Group patients by their matching identifiers
    final Map<String, List<entity.Patient>> identifierGroups = {};
    final Map<String, String> patientToGroupKey = {};

    for (final patient in allPatients) {
      final identifierKey = _getPatientIdentifierKey(patient);

      if (identifierKey != null) {
        // Group by identifier
        identifierGroups.putIfAbsent(identifierKey, () => []).add(patient);
        patientToGroupKey[patient.id] = identifierKey;
      } else {
        // No identifiers - treat as unique patient
        final uniqueKey = 'unique_${patient.id}';
        identifierGroups[uniqueKey] = [patient];
        patientToGroupKey[patient.id] = uniqueKey;
      }
    }

    // Convert groups to PatientGroup objects
    final Map<String, PatientGroup> result = {};
    for (final entry in identifierGroups.entries) {
      final patients = entry.value;
      if (patients.isEmpty) continue;

      // Use the first patient as the representative
      final representative = patients.first;
      final sourceIds = patients
          .map((p) => p.sourceId)
          .where((id) => id.isNotEmpty)
          .toSet()
          .toList();

      result[representative.id] = PatientGroup(
        representativePatient: representative,
        sourceIds: sourceIds,
        allPatientInstances: patients,
      );
    }

    return result;
  }

  /// Gets unique patients (one per group) for display in preferences
  List<entity.Patient> getUniquePatients(List<entity.Patient> allPatients) {
    final groups = deduplicatePatients(allPatients);
    return groups.values.map((g) => g.representativePatient).toList();
  }

  /// Gets all source IDs that have a specific patient (by identifier matching)
  List<String> getSourcesForPatient(
      String patientId, List<entity.Patient> allPatients) {
    final groups = deduplicatePatients(allPatients);
    final group = groups[patientId];
    if (group != null) {
      return group.sourceIds;
    }

    // Try to find patient in other groups
    for (final g in groups.values) {
      if (g.allPatientInstances.any((p) => p.id == patientId)) {
        return g.sourceIds;
      }
    }

    return [];
  }

  /// Checks if a patient exists in multiple sources
  bool hasMultipleSources(String patientId, List<entity.Patient> allPatients) {
    final sources = getSourcesForPatient(patientId, allPatients);
    return sources.length > 1;
  }

  /// Gets a unique identifier key for a patient based on FHIR identifiers
  /// Returns null if no identifiers are present
  String? _getPatientIdentifierKey(entity.Patient patient) {
    if (patient.identifier == null || patient.identifier!.isEmpty) {
      return null;
    }

    // Create a unique key from all identifiers
    // Format: system1:value1|system2:value2
    final identifierKeys = patient.identifier!
        .where((id) =>
            id.system?.valueString != null && id.value?.valueString != null)
        .map((id) =>
            '${_normalizeSystem(id.system!.valueString!)}:${_normalizeValue(id.value!.valueString!)}')
        .toList()
      ..sort(); // Sort to ensure consistent ordering

    return identifierKeys.isEmpty ? null : identifierKeys.join('|');
  }

  /// Normalizes identifier system for comparison
  String _normalizeSystem(String system) {
    return system.trim().toLowerCase();
  }

  /// Normalizes identifier value for comparison
  String _normalizeValue(String value) {
    // Remove common formatting (dashes, spaces) for more flexible matching
    return value.trim().toLowerCase().replaceAll(RegExp(r'[-\s]'), '');
  }

  /// Scores a patient based on data completeness (higher is better)
  int _scorePatientCompleteness(entity.Patient patient) {
    int score = 0;

    if (patient.name != null && patient.name!.isNotEmpty) score += 10;
    if (patient.birthDate != null) score += 5;
    if (patient.gender != null) score += 3;
    if (patient.address != null && patient.address!.isNotEmpty) score += 3;
    if (patient.telecom != null && patient.telecom!.isNotEmpty) score += 2;
    if (patient.identifier != null && patient.identifier!.isNotEmpty) {
      score += patient.identifier!.length as int;
    }

    return score;
  }
}

/// Represents a group of patients that are considered the same across sources
class PatientGroup {
  /// The patient instance chosen to represent this group
  final entity.Patient representativePatient;

  /// All source IDs that have this patient
  final List<String> sourceIds;

  /// All patient instances across sources (for reference)
  final List<entity.Patient> allPatientInstances;

  const PatientGroup({
    required this.representativePatient,
    required this.sourceIds,
    required this.allPatientInstances,
  });

  /// Convenience getter for the representative patient's ID
  String get patientId => representativePatient.id;

  /// Checks if this patient exists in a specific source
  bool existsInSource(String sourceId) => sourceIds.contains(sourceId);

  /// Gets the patient instance for a specific source, if it exists
  entity.Patient? getPatientForSource(String sourceId) {
    try {
      return allPatientInstances.firstWhere((p) => p.sourceId == sourceId);
    } catch (e) {
      return null;
    }
  }
}
