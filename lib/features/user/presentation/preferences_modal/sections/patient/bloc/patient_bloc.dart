import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/user/domain/services/patient_deduplication_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;

part 'patient_bloc.freezed.dart';
part 'patient_event.dart';
part 'patient_state.dart';

@injectable
class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final RecordsRepository _recordsRepository;
  final PatientDeduplicationService _deduplicationService;
  static const String _selectedPatientIdKey = 'selected_patient_id';

  PatientBloc(
    this._recordsRepository,
    this._deduplicationService,
  ) : super(const PatientState()) {
    on<PatientInitialised>(_onInitialised);
    on<PatientPatientsLoaded>(_onPatientsLoaded);
    on<PatientReorder>(_onPatientReorder);
    on<PatientDataUpdatedFromSync>(_onDataUpdatedFromSync);
    on<PatientEditStarted>(_onEditStarted);
    on<PatientEditCancelled>(_onEditCancelled);
    on<PatientEditSaved>(_onEditSaved);
    on<PatientSelectionChanged>(_onSelectionChanged);
  }

  Future<void> _saveSelectedPatient(String patientId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedPatientIdKey, patientId);
  }

  Future<String?> _loadSelectedPatient() async {
    final prefs = await SharedPreferences.getInstance();
    final patientId = prefs.getString(_selectedPatientIdKey);
    return patientId;
  }

  Future<void> _onInitialised(
    PatientInitialised event,
    Emitter<PatientState> emit,
  ) async {
    await _loadPatients(emit);
  }

  Future<void> _loadPatients(Emitter<PatientState> emit) async {
    emit(state.copyWith(status: const PatientStatus.loading()));

    try {
      // Fetch ALL patients from all sources
      final allPatientsResources = await _recordsRepository.getResources(
        resourceTypes: [FhirType.Patient],
        limit: 100, // Get all patients
      );

      final allPatients = allPatientsResources.whereType<Patient>().toList();

      // Deduplicate patients using FHIR identifiers
      final uniquePatients =
          _deduplicationService.getUniquePatients(allPatients);

      // Create patient groups for source mapping
      final patientGroups =
          _deduplicationService.deduplicatePatients(allPatients);

      // Find sources that have no Patient resources and assign them to default wallet holder
      final patientGroups_enhanced =
          await _enhancePatientGroupsWithOrphanSources(
        patientGroups,
        allPatients,
      );

      final savedPatientId = await _loadSelectedPatient();

      Set<String> expandedIds;
      String? selectedPatientId;

      if (savedPatientId != null &&
          uniquePatients.any((p) => p.id == savedPatientId)) {
        final savedPatient =
            uniquePatients.firstWhere((p) => p.id == savedPatientId);
        expandedIds = {savedPatient.id};
        selectedPatientId = savedPatient.id;

        if (uniquePatients.first.id != savedPatient.id) {
          uniquePatients.remove(savedPatient);
          uniquePatients.insert(0, savedPatient);
        }
      } else {
        expandedIds =
            uniquePatients.isNotEmpty ? {uniquePatients.first.id} : <String>{};
        if (uniquePatients.isNotEmpty) {
          selectedPatientId = uniquePatients.first.id;
        }
      }

      emit(state.copyWith(
        status: const PatientStatus.success(),
        patients: uniquePatients,
        allPatientsAcrossSources:
            allPatients, // Store all patients for source lookup
        patientGroups: patientGroups_enhanced,
        expandedPatientIds: expandedIds,
        selectedPatientId: selectedPatientId,
      ));

      // Save selected patient
      if (selectedPatientId != null) {
        await _saveSelectedPatient(selectedPatientId);
      }
    } catch (e) {
      logger.e('Error in _loadPatients: $e');
      emit(state.copyWith(status: PatientStatus.failure(e)));
    }
  }

  Future<void> _onPatientsLoaded(
    PatientPatientsLoaded event,
    Emitter<PatientState> emit,
  ) async {
    await _loadPatients(emit);
  }

  Future<void> _onPatientReorder(
    PatientReorder event,
    Emitter<PatientState> emit,
  ) async {
    final currentExpandedIds = Set<String>.from(state.expandedPatientIds);
    final currentPatients = List<Patient>.from(state.patients);

    if (currentExpandedIds.contains(event.patientId)) {
      return;
    }

    final selectedPatient = currentPatients.firstWhere(
      (patient) => patient.id == event.patientId,
      orElse: () => currentPatients.first,
    );

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.collapsing,
      animatingPatientId: event.patientId,
    ));

    if (currentExpandedIds.isNotEmpty) {
      final collapsingPatientId = currentExpandedIds.first;

      emit(state.copyWith(
        collapsingPatientId: collapsingPatientId,
      ));

      await Future.delayed(const Duration(milliseconds: 560));

      currentExpandedIds.clear();
      emit(state.copyWith(
        expandedPatientIds: currentExpandedIds,
        collapsingPatientId: '',
      ));

      await Future.delayed(const Duration(milliseconds: 840));
    }

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.swapping,
      swappingFromPatientId: currentPatients[0].id,
      swappingToPatientId: event.patientId,
    ));

    await Future.delayed(const Duration(milliseconds: 140));

    currentPatients.remove(selectedPatient);
    currentPatients.insert(0, selectedPatient);

    await _saveSelectedPatient(selectedPatient.id);

    emit(state.copyWith(
      patients: currentPatients,
      selectedPatientId: selectedPatient.id,
      swappingFromPatientId: '',
      swappingToPatientId: '',
    ));

    await Future.delayed(const Duration(milliseconds: 560));

    currentExpandedIds.add(event.patientId);
    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.expanding,
      expandedPatientIds: currentExpandedIds,
      expandingPatientId: event.patientId,
    ));

    await Future.delayed(const Duration(milliseconds: 840));

    emit(state.copyWith(
      expandingPatientId: '',
    ));

    await Future.delayed(const Duration(milliseconds: 140));

    emit(state.copyWith(
      animationPhase: PatientAnimationPhase.none,
      animatingPatientId: '',
      collapsingPatientId: '',
      expandingPatientId: '',
      swappingFromPatientId: '',
      swappingToPatientId: '',
    ));
  }

  /// Finds sources that have resources but no Patient, and assigns them to the default wallet holder
  Future<Map<String, PatientGroup>> _enhancePatientGroupsWithOrphanSources(
    Map<String, PatientGroup> patientGroups,
    List<Patient> allPatients,
  ) async {
    try {
      // Get all unique source IDs from all FHIR resources (not just patients)
      final allResources = await _recordsRepository.getResources(
        resourceTypes: [], // Empty means all types
        limit: 10000, // Get a large number to find all sources
      );

      // Find all unique source IDs that have resources
      final allSourceIds = allResources
          .map((r) => r.sourceId)
          .where((id) => id.isNotEmpty)
          .toSet();

      // Find source IDs that have Patient resources
      final sourcesWithPatients = allPatients
          .map((p) => p.sourceId)
          .where((id) => id.isNotEmpty)
          .toSet();

      // Orphan sources = sources with resources but no Patient resources
      final orphanSourceIds = allSourceIds.difference(sourcesWithPatients);

      if (orphanSourceIds.isEmpty) {
        return patientGroups; // No orphan sources, return as is
      }

      // Find the default wallet holder patient
      Patient? defaultWalletHolder;
      try {
        defaultWalletHolder = allPatients.firstWhere(
          (p) => p.id == 'default_wallet_holder',
        );
      } catch (e) {
        return patientGroups; // No default patient, return as is
      }

      // Clone the patient groups map
      final enhancedGroups = Map<String, PatientGroup>.from(patientGroups);

      // Add or update the default wallet holder's group to include orphan sources
      final existingGroup = enhancedGroups[defaultWalletHolder.id];
      if (existingGroup != null) {
        // Add orphan sources to existing group
        final updatedSourceIds =
            {...existingGroup.sourceIds, ...orphanSourceIds}.toList();
        enhancedGroups[defaultWalletHolder.id] = PatientGroup(
          representativePatient: existingGroup.representativePatient,
          sourceIds: updatedSourceIds,
          allPatientInstances: existingGroup.allPatientInstances,
        );
      } else {
        // Create new group with orphan sources
        enhancedGroups[defaultWalletHolder.id] = PatientGroup(
          representativePatient: defaultWalletHolder,
          sourceIds: [defaultWalletHolder.sourceId, ...orphanSourceIds],
          allPatientInstances: [defaultWalletHolder],
        );
      }

      return enhancedGroups;
    } catch (e) {
      logger.e('Error in _enhancePatientGroupsWithOrphanSources: $e');
      return patientGroups; // Return original on error
    }
  }

  Future<void> _onDataUpdatedFromSync(
    PatientDataUpdatedFromSync event,
    Emitter<PatientState> emit,
  ) async {
    // Don't reload patients here as it can override the current selection
    // Only load patients on initialisation
  }

  Future<void> _onEditStarted(
    PatientEditStarted event,
    Emitter<PatientState> emit,
  ) async {
    final patient = state.patients.firstWhere(
      (p) => p.id == event.patientId,
      orElse: () => state.patients.first,
    );

    emit(state.copyWith(
      isEditingPatient: true,
      editingPatient: patient,
    ));
  }

  Future<void> _onEditCancelled(
    PatientEditCancelled event,
    Emitter<PatientState> emit,
  ) async {
    emit(state.copyWith(
      isEditingPatient: false,
      editingPatient: null,
    ));
  }

  Future<void> _onEditSaved(
    PatientEditSaved event,
    Emitter<PatientState> emit,
  ) async {
    emit(state.copyWith(status: const PatientStatus.loading()));

    try {
      // Find the patient to update
      final patientIndex = state.patients.indexWhere(
        (p) => p.id == event.patientId,
      );

      if (patientIndex != -1) {
        final currentPatient = state.patients[patientIndex];

        final updatedPatient = currentPatient.copyWith(
          id: currentPatient.id,
          sourceId: currentPatient.sourceId,
          identifier: currentPatient.identifier,
          gender: _mapDisplayGenderToFhir(event.gender),
          birthDate: fhir_r4.FhirDate.fromDateTime(event.birthDate),
        );

        // Update the patient in the repository
        await _recordsRepository.updatePatient(updatedPatient);

        final updatedPatients = List<Patient>.from(state.patients);
        updatedPatients[patientIndex] = updatedPatient;

        emit(state.copyWith(
          status: const PatientStatus.success(),
          patients: updatedPatients,
          isEditingPatient: false,
          editingPatient: null,
        ));
      } else {
        // If state is empty, reload patients first
        if (state.patients.isEmpty) {
          await _loadPatients(emit);
        }

        // Try to find the patient again after potential reload
        final refreshedPatientIndex = state.patients.indexWhere(
          (p) => p.id == event.patientId,
        );

        if (refreshedPatientIndex != -1) {
          final currentPatient = state.patients[refreshedPatientIndex];

          final updatedPatient = currentPatient.copyWith(
            // ID is not editable - keep the original
            id: currentPatient.id,
            identifier: currentPatient.identifier,
            gender: _mapDisplayGenderToFhir(event.gender),
            birthDate: fhir_r4.FhirDate.fromDateTime(event.birthDate),
          );

          final updatedPatients = List<Patient>.from(state.patients);
          updatedPatients[refreshedPatientIndex] = updatedPatient;

          await _recordsRepository.updatePatient(updatedPatient);

          emit(state.copyWith(
            status: const PatientStatus.success(),
            patients: updatedPatients,
            isEditingPatient: false,
            editingPatient: null,
          ));

          // NO NEED to reload patients - just use the updated local data
        } else {
          emit(state.copyWith(
            status: PatientStatus.failure(
                Exception('Patient not found even after refresh')),
            isEditingPatient: false,
            editingPatient: null,
          ));
        }
      }
    } catch (e) {
      logger.e('Error in _onEditSaved: $e');
      emit(state.copyWith(
        status: PatientStatus.failure(e),
        isEditingPatient: false,
        editingPatient: null,
      ));
    }
  }

  fhir_r4.AdministrativeGender? _mapDisplayGenderToFhir(String displayGender) {
    switch (displayGender.toLowerCase()) {
      case 'male':
        return fhir_r4.AdministrativeGender.male;
      case 'female':
        return fhir_r4.AdministrativeGender.female;
      case 'prefer not to say':
      default:
        return null;
    }
  }

  Future<void> _onSelectionChanged(
    PatientSelectionChanged event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await _saveSelectedPatient(event.patientId);

      // Update the state with the new selection
      emit(state.copyWith(
        selectedPatientId: event.patientId,
        expandedPatientIds: {event.patientId},
      ));
    } catch (e) {
      logger.e('Error in _onSelectionChanged: $e');
      emit(state.copyWith(
        status: PatientStatus.failure(e),
      ));
    }
  }
}
