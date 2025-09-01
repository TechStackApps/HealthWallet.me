// home_bloc.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/domain/factory/patient_vitals_factory.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecordsRepository _recordsRepository;
  final GetSourcesUseCase _getSourcesUseCase;
  final HomeLocalDataSource _homeLocalDataSource;
  final PatientVitalFactory _patientVitalFactory = PatientVitalFactory();

  static const int _minVisibleVitalsCount = 4;
  static const String _demoSourceId = 'demo_data';

  HomeBloc(
    this._getSourcesUseCase,
    this._homeLocalDataSource,
    this._recordsRepository,
  ) : super(const HomeState()) {
    on<HomeInitialised>(_onInitialised);
    on<HomeSourceChanged>(_onSourceChanged);
    on<HomeRecordsFiltersChanged>(_onRecordsFiltersChanged);
    on<HomeVitalsFiltersChanged>(_onVitalsFiltersChanged);
    on<HomeEditModeChanged>(
        (e, emit) => emit(state.copyWith(editMode: e.editMode)));
    on<HomeRecordsReordered>(_onRecordsReordered);
    on<HomeVitalsReordered>(_onVitalsReordered);
    on<HomeVitalsExpansionToggled>((e, emit) =>
        emit(state.copyWith(vitalsExpanded: !state.vitalsExpanded)));
    on<HomeRefreshPreservingOrder>(_onRefreshPreservingOrder);
  }

  bool hasData({
    required List<PatientVital> patientVitals,
    required List<OverviewCard> overviewCards,
    required List<IFhirResource> recentRecords,
  }) {
    final hasVitals = patientVitals.isNotEmpty;
    final hasOverview = overviewCards.isNotEmpty;
    final hasRecent = recentRecords.isNotEmpty;

    final result = hasVitals || hasOverview || hasRecent;
    return result;
  }

  Future<void> _onInitialised(
      HomeInitialised e, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final savedSource = prefs.getString('selected_patient_source_id');
    if (savedSource != null) {
      emit(state.copyWith(selectedSource: savedSource));
    }

    if (_hasExistingVitalsData() && !_shouldForceRefresh()) {
      emit(state.copyWith());
    } else {
      await _reloadHomeData(emit, force: true, overrideSourceId: savedSource);
    }
  }

  bool _hasExistingVitalsData() {
    return state.allAvailableVitals.isNotEmpty &&
        state.patientVitals.isNotEmpty &&
        state.status != const HomeStatus.loading();
  }

  bool _shouldForceRefresh() {
    final hasOnlyPlaceholders = state.patientVitals.isNotEmpty &&
        state.patientVitals.every((v) => v.value == 'N/A');
    final hasOnlyZeroCounts = state.overviewCards.isNotEmpty &&
        state.overviewCards.every((c) => c.count == '0');
    return hasOnlyPlaceholders || hasOnlyZeroCounts;
  }

  Future<void> _onRefreshPreservingOrder(
      HomeRefreshPreservingOrder e, Emitter<HomeState> emit) async {
    if (state.allAvailableVitals.isEmpty) {
      await _reloadHomeData(emit,
          force: false, overrideSourceId: state.selectedSource);
    } else {
      emit(state.copyWith());
    }
  }

  Future<void> _onSourceChanged(
      HomeSourceChanged e, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedSource: e.source));
    await _reloadHomeData(emit, force: true, overrideSourceId: e.source);
  }

  Future<void> _onVitalsFiltersChanged(
      HomeVitalsFiltersChanged e, Emitter<HomeState> emit) async {
    final toSave = <String, bool>{
      for (final entry in e.filters.entries) entry.key.title: entry.value
    };
    await _homeLocalDataSource.saveVitalsVisibility(toSave);
    final filtered =
        _filterVitalsByVisibility(state.allAvailableVitals, e.filters);
    emit(state.copyWith(selectedVitals: e.filters, patientVitals: filtered));
  }

  Future<void> _onVitalsReordered(
      HomeVitalsReordered e, Emitter<HomeState> emit) async {
    try {
      final master = List.of(state.allAvailableVitals);
      if (!_validateReorderIndices(e.oldIndex, e.newIndex, master.length))
        return;

      final moved = master.removeAt(e.oldIndex);
      master.insert(e.newIndex, moved);
      await _handleAutoVisibility(moved, e.newIndex, emit);
      await _homeLocalDataSource
          .saveVitalsOrder(master.map((v) => v.title).toList());
      final filtered = _filterVitalsByVisibility(master, state.selectedVitals);
      emit(state.copyWith(allAvailableVitals: master, patientVitals: filtered));
    } catch (err) {
      logger.e('Vitals reorder error: $err');
    }
  }

  Future<void> _onRecordsFiltersChanged(
      HomeRecordsFiltersChanged e, Emitter<HomeState> emit) async {
    final toSave = <String, bool>{
      for (final entry in e.filters.entries) entry.key.display: entry.value
    };
    await _homeLocalDataSource.saveRecordsVisibility(toSave);
    emit(state.copyWith(selectedRecordTypes: e.filters));
    await _reloadHomeData(emit,
        force: false,
        overrideSourceId:
            state.selectedSource != 'All' ? state.selectedSource : null);
  }

  Future<void> _onRecordsReordered(
      HomeRecordsReordered e, Emitter<HomeState> emit) async {
    try {
      final cards = List.of(state.overviewCards);
      if (!_validateReorderIndices(e.oldIndex, e.newIndex, cards.length))
        return;

      final item = cards.removeAt(e.oldIndex);
      cards.insert(e.newIndex, item);
      await _homeLocalDataSource
          .saveRecordsOrder(cards.map((c) => c.category.display).toList());
      emit(state.copyWith(overviewCards: cards));
    } catch (err) {
      logger.e('Records reorder error: $err');
    }
  }

  List<PatientVital> _filterVitalsByVisibility(
    List<PatientVital> allVitals,
    Map<PatientVitalType, bool> visibilityMap,
  ) {
    return allVitals
        .where((v) => visibilityMap.entries
            .where((entry) => entry.value)
            .any((entry) => entry.key.title == v.title))
        .toList(growable: false);
  }

  bool _validateReorderIndices(int oldIndex, int newIndex, int length) {
    final ok = oldIndex >= 0 &&
        oldIndex < length &&
        newIndex >= 0 &&
        newIndex <= length;
    if (!ok) {
      logger.e('Invalid reorder indices: $oldIndex -> $newIndex of $length');
    }
    return ok;
  }

  Future<void> _handleAutoVisibility(
      PatientVital vital, int newIndex, Emitter<HomeState> emit) async {
    final currentVisibleCount =
        state.selectedVitals.entries.where((e) => e.value).length;
    final effectiveVisibleArea =
        math.max(currentVisibleCount, _minVisibleVitalsCount);

    if (newIndex < effectiveVisibleArea) {
      final vitalType = PatientVitalTypeX.fromTitle(vital.title);
      if (vitalType != null && !(state.selectedVitals[vitalType] ?? false)) {
        final updated = Map<PatientVitalType, bool>.from(state.selectedVitals);
        updated[vitalType] = true;
        await _homeLocalDataSource.saveVitalsVisibility({
          for (final e in updated.entries) e.key.title: e.value,
        });
        emit(state.copyWith(selectedVitals: updated));
      }
    }
  }

  Future<List<Source>> _fetchSources(String? patientSourceId) async {
    if (patientSourceId != null) {
      final allSources = await _getSourcesUseCase();
      final patientSource = allSources.firstWhere(
        (s) => s.id == patientSourceId,
        orElse: () => Source(id: patientSourceId, name: patientSourceId),
      );
      return [patientSource];
    } else {
      return await _getSourcesUseCase();
    }
  }

  Future<
      ({
        List<OverviewCard> overviewCards,
        List<IFhirResource> allEnabledResources,
        Map<HomeRecordsCategory, bool> selectedRecordTypes
      })> _fetchOverviewCardsAndResources(String? sourceId) async {
    final overviewCards = <OverviewCard>[];
    final allEnabledResources = <IFhirResource>[];
    final savedRecordsVisibility =
        await _homeLocalDataSource.getRecordsVisibility();
    final updatedSelectedRecordTypes =
        Map<HomeRecordsCategory, bool>.from(state.selectedRecordTypes);
    if (savedRecordsVisibility != null) {
      updatedSelectedRecordTypes.updateAll((category, value) =>
          savedRecordsVisibility[category.display] ?? value);
    }

    for (final category in updatedSelectedRecordTypes.keys) {
      if (updatedSelectedRecordTypes[category]!) {
        final resources = await _fetchResourcesFromAllSources(
            category.resourceTypes, sourceId);
        overviewCards.add(OverviewCard(
            category: category, count: resources.length.toString()));
        allEnabledResources.addAll(resources);
      } else {
        overviewCards.add(OverviewCard(category: category, count: '0'));
      }
    }

    return (
      overviewCards: overviewCards,
      allEnabledResources: allEnabledResources,
      selectedRecordTypes: updatedSelectedRecordTypes,
    );
  }

  Future<List<IFhirResource>> _fetchResourcesFromAllSources(
    List<FhirType> resourceTypes,
    String? sourceId,
  ) async {
    if (sourceId == _demoSourceId) {
      final resources = await _recordsRepository.getResources(
          resourceTypes: resourceTypes, sourceId: _demoSourceId);
      return resources;
    }
    final resources = await _recordsRepository.getResources(
        resourceTypes: resourceTypes, sourceId: sourceId);
    return resources;
  }

  Future<List<IFhirResource>> _fetchPatientResources(String? sourceId) async {
    final resources =
        await _fetchResourcesFromAllSources([FhirType.Patient], sourceId);
    return resources;
  }

  Future<List<PatientVital>> _fetchAndProcessVitals(String? sourceId) async {
    final obs =
        await _fetchResourcesFromAllSources([FhirType.Observation], sourceId);
    return _patientVitalFactory.buildFromResources(obs);
  }

  Future<
      ({
        List<PatientVital> allAvailableVitals,
        List<PatientVital> patientVitals,
        Map<PatientVitalType, bool> selectedVitals
      })> _processVitalsData(String? sourceId) async {
    final vitals = await _fetchAndProcessVitals(sourceId);
    final saved = await _homeLocalDataSource.getVitalsVisibility();
    final selectedMap = Map<String, bool>.from(saved ??
        {for (final e in state.selectedVitals.entries) e.key.title: e.value});

    final hasData = vitals.any((v) => v.observationId != null);

    for (final vital in vitals) {
      selectedMap.putIfAbsent(
        vital.title,
        () => hasData && vital.observationId != null
            ? true
            : (state.selectedVitals[PatientVitalTypeX.fromTitle(vital.title) ??
                    PatientVitalType.heartRate] ??
                false),
      );
    }

    List<PatientVital> allAvailableVitals;
    if (state.allAvailableVitals.isNotEmpty) {
      allAvailableVitals =
          _mergeVitalsWithCurrentOrder(state.allAvailableVitals, vitals);
    } else {
      allAvailableVitals = await _applyVitalSignsOrder(vitals);
    }

    final filtered = allAvailableVitals
        .where((v) => selectedMap[v.title] ?? false)
        .toList(growable: false);

    final selectedVitals = Map<PatientVitalType, bool>.fromEntries(
      selectedMap.entries.map(
        (e) => MapEntry(
            PatientVitalTypeX.fromTitle(e.key) ?? PatientVitalType.heartRate,
            e.value),
      ),
    );

    return (
      allAvailableVitals: allAvailableVitals,
      patientVitals: filtered,
      selectedVitals: selectedVitals
    );
  }

  List<PatientVital> _mergeVitalsWithCurrentOrder(
    List<PatientVital> currentOrder,
    List<PatientVital> freshVitals,
  ) {
    final merged = <PatientVital>[];
    final currentMap = {for (final v in currentOrder) v.title: v};
    final freshMap = {for (final v in freshVitals) v.title: v};

    for (final v in currentOrder) {
      merged.add(freshMap[v.title] ?? v);
    }
    for (final v in freshVitals) {
      if (!currentMap.containsKey(v.title)) merged.add(v);
    }
    return merged;
  }

  Future<List<PatientVital>> _applyVitalSignsOrder(
      List<PatientVital> vitals) async {
    if (vitals.isEmpty) return vitals;

    final savedOrder = await _homeLocalDataSource.getVitalsOrder();
    if (savedOrder != null && savedOrder.isNotEmpty) {
      final map = {for (final v in vitals) v.title: v};
      final ordered = <PatientVital>[
        ...savedOrder.map((t) => map.remove(t)).whereType<PatientVital>(),
        ...map.values,
      ];
      return ordered;
    }

    // Default order for vitals
    const pinnedTop = <String>[
      'Heart Rate',
      'Blood Pressure',
      'Temperature',
      'Blood Oxygen'
    ];
    final mapNoSaved = {for (final v in vitals) v.title: v};
    final ordered = <PatientVital>[
      for (final t in pinnedTop)
        if (mapNoSaved.containsKey(t)) mapNoSaved.remove(t)!,
      ...mapNoSaved.values,
    ];
    return ordered;
  }

  Future<List<OverviewCard>> _applyOverviewCardsOrder(
      List<OverviewCard> cards) async {
    final savedOrder = await _homeLocalDataSource.getRecordsOrder();
    if (savedOrder == null || savedOrder.isEmpty) return cards;

    final map = {for (final c in cards) c.category.display: c};
    return [
      ...savedOrder.map((t) => map.remove(t)).whereType<OverviewCard>(),
      ...map.values,
    ];
  }

  Future<void> _reloadHomeData(
    Emitter<HomeState> emit, {
    bool force = false,
    String? overrideSourceId,
  }) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      final sourceId = _resolveSourceId(overrideSourceId);

      final sources = await _fetchSources(sourceId);
      final overview = await _fetchOverviewCardsAndResources(sourceId);
      final patientResources = await _fetchPatientResources(sourceId);
      final vitalsData = await _processVitalsData(sourceId);
      final reorderedCards =
          await _applyOverviewCardsOrder(overview.overviewCards);

      if (patientResources.isNotEmpty) {
        final hasData = this.hasData(
          patientVitals: vitalsData.patientVitals,
          overviewCards: reorderedCards,
          recentRecords: overview.allEnabledResources.take(3).toList(),
        );

        emit(state.copyWith(
          status: const HomeStatus.success(),
          sources: sources,
          selectedSource: sourceId ?? 'All',
          patient: patientResources.isNotEmpty
              ? patientResources.first as Patient
              : null,
          overviewCards: reorderedCards,
          recentRecords: overview.allEnabledResources.take(3).toList(),
          allAvailableVitals: vitalsData.allAvailableVitals,
          patientVitals: vitalsData.patientVitals,
          selectedVitals: vitalsData.selectedVitals,
          selectedRecordTypes: overview.selectedRecordTypes,
          hasDataLoaded: hasData,
        ));
      }
    } catch (err, stackTrace) {
      logger.e('reloadHomeData error: $err');
      logger.e('reloadHomeData stack trace: $stackTrace');
      emit(state.copyWith(
        status: HomeStatus.failure('Failed to load home data: $err'),
        errorMessage: err.toString(),
      ));
    }
  }

  String? _resolveSourceId(String? input) {
    if (input == null || input == 'All') return null;
    if (input == _demoSourceId) return _demoSourceId;
    return input;
  }
}
