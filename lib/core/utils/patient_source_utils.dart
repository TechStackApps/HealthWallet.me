import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

/// Utility class for handling patient source filtering logic
class PatientSourceUtils {
  /// Reload home data with current patient's source filtering
  static void reloadHomeWithPatientFilter(BuildContext context, String source) {
    final patientSourceIds = getPatientSourceIds(context);
    context.read<HomeBloc>().add(
          HomeSourceChanged(source, patientSourceIds: patientSourceIds),
        );
  }

  /// Get the selected patient's source IDs from PatientBloc
  static List<String>? getPatientSourceIds(BuildContext context) {
    try {
      final patientState = context.read<PatientBloc>().state;
      final selectedPatientId = patientState.selectedPatientId;

      if (selectedPatientId != null && patientState.patientGroups.isNotEmpty) {
        final patientGroup = patientState.patientGroups[selectedPatientId];
        return patientGroup?.sourceIds;
      }
    } catch (e) {
      // PatientBloc not available
    }
    return null;
  }

  /// Extract patient source IDs from PatientState
  static List<String>? getPatientSourceIdsFromState(PatientState patientState) {
    final selectedPatientId = patientState.selectedPatientId;
    if (selectedPatientId != null && patientState.patientGroups.isNotEmpty) {
      final patientGroup = patientState.patientGroups[selectedPatientId];
      return patientGroup?.sourceIds;
    }
    return null;
  }

  /// Validate that a source exists for the patient, fallback to "All" if not
  static String validateSourceForPatient(
      String currentSource, List<String>? patientSourceIds) {
    final source = currentSource.isEmpty ? 'All' : currentSource;

    print('🔴 [PATIENT_SOURCE_UTILS] Validating source:');
    print('  - Input source: $currentSource');
    print('  - Normalized source: $source');
    print('  - Patient source IDs: $patientSourceIds');

    // If source is "All" or patient has no sources, keep it
    if (source == 'All' ||
        patientSourceIds == null ||
        patientSourceIds.isEmpty) {
      print(
          '🔴 [PATIENT_SOURCE_UTILS] Keeping source (All or no patient sources): $source');
      return source;
    }

    // If source exists for patient, keep it; otherwise fallback to "All"
    final isValid = patientSourceIds.contains(source);
    final result = isValid ? source : 'All';
    print(
        '🔴 [PATIENT_SOURCE_UTILS] Source validation result: $result (isValid: $isValid)');
    return result;
  }

  /// Handle patient selection change with source validation
  static void handlePatientChange(
      BuildContext context, PatientState patientState) {
    final homeState = context.read<HomeBloc>().state;
    final currentSource = homeState.selectedSource;

    // Get the new patient's source IDs
    final patientSourceIds = getPatientSourceIdsFromState(patientState);

    print('🔴 [PATIENT_SOURCE_UTILS] Patient change detected:');
    print('  - Current source: $currentSource');
    print('  - Selected patient: ${patientState.selectedPatientId}');
    print('  - Patient source IDs: $patientSourceIds');
    print('  - Patient groups: ${patientState.patientGroups.keys}');

    // Validate that the current source exists for the new patient
    final validSource =
        validateSourceForPatient(currentSource, patientSourceIds);

    print('🔴 [PATIENT_SOURCE_UTILS] Source validation:');
    print('  - Valid source: $validSource');

    // Reload home with validated source and new patient's sources
    context.read<HomeBloc>().add(
          HomeSourceChanged(validSource, patientSourceIds: patientSourceIds),
        );
  }
}
