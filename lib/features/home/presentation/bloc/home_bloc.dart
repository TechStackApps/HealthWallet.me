import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/home/domain/factory/patient_vitals_factory.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecordsRepository _recordsRepository;
  final GetSourcesUseCase _getSourcesUseCase;
  final HomeLocalDataSource _homeLocalDataSource;
  // Keep for future extensibility in Home; currently vitals are built via VitalSignsFactory.
  final PatientVitalFactory _patientVitalFactory = PatientVitalFactory();

  HomeBloc(
    this._getSourcesUseCase,
    this._homeLocalDataSource,
    this._recordsRepository,
  ) : super(HomeState()) {
    on<HomeInitialised>(_onInitialised);
    on<HomeSourceChanged>(_onSourceChanged);
    on<HomeRecordsFiltersChanged>(_onRecordsFiltersChanged);
    on<HomeVitalsFiltersChanged>(_onVitalsFiltersChanged);
    on<HomeEditModeChanged>(_onEditModeChanged);
    on<HomeRecordsReordered>(_onRecordsReordered);
    on<HomeVitalsReordered>(_onVitalsReordered);
    on<HomePatientSelected>(_onPatientSelected);
  }

  Future<void> _onInitialised(
      HomeInitialised event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedPatientSourceId =
        prefs.getString('selected_patient_source_id');

    if (selectedPatientSourceId != null) {
      emit(state.copyWith(selectedSource: selectedPatientSourceId));
    }

    await _loadData(emit, initialPatientSourceId: selectedPatientSourceId);
  }

  Future<void> _onSourceChanged(
      HomeSourceChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedSource: event.source));
  }

  Future<void> _onRecordsFiltersChanged(
      HomeRecordsFiltersChanged event, Emitter<HomeState> emit) async {
    // Update state directly with typed enum map
    emit(state.copyWith(selectedRecordTypes: event.filters));
    // Persist records visibility by display title so it survives hot reload/app reinstall
    final toSave = <String, bool>{
      for (final entry in event.filters.entries) entry.key.display: entry.value,
    };
    await _homeLocalDataSource.saveRecordsVisibility(toSave);
    // Refresh data to reflect new records visibility (counts, recent records)
    await _loadDataInternal(
      emit,
      patientSourceId:
          state.selectedSource != 'All' ? state.selectedSource : null,
    );
  }

  Future<void> _onVitalsFiltersChanged(
      HomeVitalsFiltersChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedVitals: event.filters));
    // Persist vitals visibility by vital title
    final toSave = <String, bool>{
      for (final entry in event.filters.entries) entry.key.title: entry.value,
    };
    await _homeLocalDataSource.saveVitalsVisibility(toSave);
    // Recompute vitals immediately using the updated visibility
    await _loadDataInternal(
      emit,
      patientSourceId:
          state.selectedSource != 'All' ? state.selectedSource : null,
    );
  }

  Future<void> _onEditModeChanged(
      HomeEditModeChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(editMode: event.editMode));
  }

  Future<void> _onRecordsReordered(
      HomeRecordsReordered event, Emitter<HomeState> emit) async {
    final cards = List.of(state.overviewCards);
    final card = cards.removeAt(event.oldIndex);
    cards.insert(event.newIndex, card);
    emit(state.copyWith(overviewCards: cards));
    final cardTitles = cards.map((card) => card.category.display).toList();
    await _homeLocalDataSource.saveRecordsOrder(cardTitles);
  }

  Future<void> _onVitalsReordered(
      HomeVitalsReordered event, Emitter<HomeState> emit) async {
    final vitals = List.of(state.patientVitals);
    final vital = vitals.removeAt(event.oldIndex);
    vitals.insert(event.newIndex, vital);
    emit(state.copyWith(patientVitals: vitals));
    final vitalTitles = vitals.map((vital) => vital.title).toList();
    await _homeLocalDataSource.saveVitalsOrder(vitalTitles);
  }

  Future<void> _onPatientSelected(
      HomePatientSelected event, Emitter<HomeState> emit) async {
    final updatedState = state.copyWith(
      selectedPatientName: event.patientName,
      selectedSource: event.patientSourceId ?? 'All',
    );
    emit(updatedState);
    await _loadDataInternal(emit, patientSourceId: event.patientSourceId);
  }

  Future<void> _loadData(Emitter<HomeState> emit,
      {String? initialPatientSourceId}) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      await _loadDataInternal(emit, patientSourceId: initialPatientSourceId)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException {
      emit(state.copyWith(
        status: const HomeStatus.failure('Timed out loading data (30s).'),
        errorMessage: 'Timed out loading data (30s).',
      ));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStatus.failure(e), errorMessage: e.toString()));
    }
  }

  Future<void> _loadDataInternal(Emitter<HomeState> emit,
      {String? patientSourceId}) async {
    String? updatedSelectedSource = state.selectedSource;
    if (patientSourceId != null) {
      updatedSelectedSource = patientSourceId;
    }

    List<Source> sources = [];
    if (patientSourceId != null) {
      final allSources = await _getSourcesUseCase();
      final patientSource = allSources.firstWhere(
        (s) => s.id == patientSourceId,
        orElse: () => Source(id: patientSourceId, name: patientSourceId),
      );
      sources = [patientSource];
    } else {
      sources = await _getSourcesUseCase();
    }

    String? sourceId;
    if (patientSourceId != null) {
      sourceId = patientSourceId;
    } else if (state.selectedSource != 'All') {
      sourceId = state.selectedSource;
    }

    final List<OverviewCard> overviewCards = [];
    final List<IFhirResource> allEnabledResources = [];

    // Merge saved records visibility with defaults
    final savedRecordsVisibility =
        await _homeLocalDataSource.getRecordsVisibility();
    final updatedSelectedRecordTypes =
        Map<HomeRecordsCategory, bool>.from(state.selectedRecordTypes);
    if (savedRecordsVisibility != null) {
      updatedSelectedRecordTypes.updateAll((category, value) {
        return savedRecordsVisibility[category.display] ?? value;
      });
    }

    for (HomeRecordsCategory category in updatedSelectedRecordTypes.keys) {
      if (updatedSelectedRecordTypes[category]!) {
        final resources = await _recordsRepository.getResources(
          resourceTypes: category.resourceTypes,
          sourceId: sourceId,
        );

        allEnabledResources.addAll(resources);
        overviewCards.add(
          OverviewCard(
            category: category,
            count: resources.length.toString(),
          ),
        );
      } else {
        overviewCards.add(
          OverviewCard(
            category: category,
            count: '0',
          ),
        );
      }
    }

    allEnabledResources.sort((a, b) {
      if (a.date == null && b.date == null) return 0;
      if (a.date == null) return 1;
      if (b.date == null) return -1;
      return b.date!.compareTo(a.date!);
    });

    final patientResources = await _recordsRepository.getResources(
      resourceTypes: [FhirType.Patient],
      sourceId: sourceId,
    );

    // Fetch real FHIR observation data for vitals
    final vitalObservations = await _recordsRepository.getResources(
      resourceTypes: [FhirType.Observation],
      sourceId: sourceId,
    );

    // Convert observations to vitals
    var vitals = _patientVitalFactory.buildFromResources(vitalObservations);
    // Apply visibility filter; if user hasn't set preferences, use defaults from state
    final visibility = await _homeLocalDataSource.getVitalsVisibility();
    final selectedMap = Map<String, bool>.from(visibility ??
        {for (final e in state.selectedVitals.entries) e.key.title: e.value});
    // Ensure all known titles exist in the map; default based on current state defaults
    for (final v in vitals) {
      selectedMap.putIfAbsent(
        v.title,
        () =>
            state.selectedVitals[PatientVitalTypeX.fromTitle(v.title) ??
                PatientVitalType.heartRate] ??
            false,
      );
    }
    List<PatientVital> filteredVitals = vitals
        .where((v) => selectedMap[v.title] ?? false)
        .toList(growable: false);

    // No mock fallback; if empty, nothing will be displayed by design
    final reorderedVitals = await _applyVitalSignsOrder(filteredVitals);

    final reorderedOverviewCards =
        await _applyOverviewCardsOrder(overviewCards);
    final finalState = state.copyWith(
      status: const HomeStatus.success(),
      patientVitals: reorderedVitals,
      overviewCards: reorderedOverviewCards,
      recentRecords: allEnabledResources.take(3).toList(),
      sources: sources,
      patient: patientResources.isNotEmpty
          ? patientResources.first as Patient
          : null,
      selectedSource: updatedSelectedSource,
      selectedVitals: Map<PatientVitalType, bool>.fromEntries(
        selectedMap.entries.map(
          (e) => MapEntry(
            PatientVitalTypeX.fromTitle(e.key) ?? PatientVitalType.heartRate,
            e.value,
          ),
        ),
      ),
      selectedRecordTypes: updatedSelectedRecordTypes,
    );

    emit(finalState);
  }

  Future<List<PatientVital>> _applyVitalSignsOrder(
      List<PatientVital> vitals) async {
    final savedOrder = await _homeLocalDataSource.getVitalsOrder();
    const pinnedTop = <String>[
      'Heart Rate',
      'Blood Pressure',
      'Temperature',
      'Blood Oxygen',
    ];

    if (savedOrder == null) {
      final mapNoSaved = {for (final v in vitals) v.title: v};
      final ordered = <PatientVital>[
        for (final t in pinnedTop)
          if (mapNoSaved.containsKey(t)) mapNoSaved.remove(t)!,
        ...mapNoSaved.values,
      ];
      return ordered;
    }

    final vitalsMap = <String, PatientVital>{};
    for (final vital in vitals) {
      vitalsMap[vital.title] = vital;
    }
    final reorderedVitals = <PatientVital>[];

    for (final title in pinnedTop) {
      final v = vitalsMap.remove(title);
      if (v != null) reorderedVitals.add(v);
    }

    for (final title in savedOrder) {
      if (pinnedTop.contains(title)) continue;
      final v = vitalsMap.remove(title);
      if (v != null) reorderedVitals.add(v);
    }
    reorderedVitals.addAll(vitalsMap.values);
    return reorderedVitals;
  }

  Future<List<OverviewCard>> _applyOverviewCardsOrder(
      List<OverviewCard> cards) async {
    final savedOrder = await _homeLocalDataSource.getRecordsOrder();
    if (savedOrder == null) {
      return cards;
    }
    final cardsMap = <String, OverviewCard>{};
    for (final card in cards) {
      cardsMap[card.category.display] = card;
    }
    final reorderedCards = <OverviewCard>[];
    for (final title in savedOrder) {
      if (cardsMap.containsKey(title)) {
        reorderedCards.add(cardsMap[title]!);
        cardsMap.remove(title);
      }
    }
    reorderedCards.addAll(cardsMap.values);
    return reorderedCards;
  }
}
