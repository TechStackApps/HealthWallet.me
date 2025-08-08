import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/data/mock_data.dart';
import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/recent_record.dart';
import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/domain/factory/entity_factories/patient_entity_display_factory.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SyncRepository _syncRepository;
  final RecordsRepository _recordsRepository;
  final GetSourcesUseCase _getSourcesUseCase;
  final HomeLocalDataSource _homeLocalDataSource;
  final PatientEntityDisplayFactory _patientFactory;

  HomeBloc(
    this._syncRepository,
    this._getSourcesUseCase,
    this._homeLocalDataSource,
    this._recordsRepository,
  )   : _patientFactory = PatientEntityDisplayFactory(),
        super(const HomeState()) {
    on<HomeInitialised>(_onInitialised);
    on<HomeSourceChanged>(_onSourceChanged);
    on<HomeFiltersChanged>(_onFiltersChanged);
    on<HomeEditModeChanged>(_onEditModeChanged);
    on<HomeRecordsReordered>(_onRecordsReordered);
    on<HomeVitalsReordered>(_onVitalsReordered);
    on<HomePatientSelected>(_onPatientSelected);
  }

  Future<void> _onInitialised(
      HomeInitialised event, Emitter<HomeState> emit) async {
    // Load the selected patient sourceId from SharedPreferences on initialization
    final prefs = await SharedPreferences.getInstance();
    final selectedPatientSourceId =
        prefs.getString('selected_patient_source_id');

    await _loadData(emit, initialPatientSourceId: selectedPatientSourceId);
  }

  Future<void> _onSourceChanged(
      HomeSourceChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedSource: event.source));
    await _loadData(emit);
  }

  Future<void> _onFiltersChanged(
      HomeFiltersChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedRecordTypes: event.filters));
    await _loadData(emit);
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
    final vitals = List.of(state.vitalSigns);
    final vital = vitals.removeAt(event.oldIndex);
    vitals.insert(event.newIndex, vital);
    emit(state.copyWith(vitalSigns: vitals));
    final vitalTitles = vitals.map((vital) => vital.title).toList();
    await _homeLocalDataSource.saveVitalsOrder(vitalTitles);
  }

  Future<void> _onPatientSelected(
      HomePatientSelected event, Emitter<HomeState> emit) async {
    // Update the state with the new patient selection
    final updatedState = state.copyWith(
      selectedPatientName: event.patientName,
    );
    emit(updatedState);

    // Reload data with the new patient sourceId filter
    await _loadDataInternal(emit, patientSourceId: event.patientSourceId);
  }

  Future<void> _loadData(Emitter<HomeState> emit,
      {String? initialPatientSourceId}) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      await Future.any([
        _loadDataInternal(emit, patientSourceId: initialPatientSourceId),
        Future.delayed(const Duration(seconds: 10), () {
          throw Exception('Data load timed out');
        }),
      ]);
    } catch (e, st) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }

  Future<void> _loadDataInternal(Emitter<HomeState> emit,
      {String? patientSourceId}) async {
    final sources = await _getSourcesUseCase(patientId: patientSourceId);
    if (sources.where((s) => s.id == 'All').isEmpty) {
      sources.insert(0, const Source(id: 'All', name: 'All'));
    }

    String? sourceId;
    if (patientSourceId != null) {
      sourceId = patientSourceId;
    } else if (state.selectedSource != 'All') {
      sourceId = state.selectedSource;
    }

    final List<OverviewCard> overviewCards = [];
    final List<IFhirResource> allEnabledResources = [];

    for (HomeRecordsCategory category in state.selectedRecordTypes.keys) {
      if (state.selectedRecordTypes[category]!) {
        final resources = await _recordsRepository.getAllResources(
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
    final patientResource = await _syncRepository.getResources(
      resourceType: 'Patient',
      sourceId: sourceId,
    );
    final vitals = List.of(MockData.vitalSigns);
    final reorderedVitals = await _applyVitalSignsOrder(vitals);
    final reorderedOverviewCards =
        await _applyOverviewCardsOrder(overviewCards);
    emit(
      state.copyWith(
        status: const HomeStatus.success(),
        vitalSigns: reorderedVitals,
        overviewCards: reorderedOverviewCards,
        recentRecords: allEnabledResources.take(3).toList(),
        sources: sources,
        patient: patientResource.isNotEmpty ? patientResource.first : null,
      ),
    );
  }

  Future<List<VitalSign>> _applyVitalSignsOrder(List<VitalSign> vitals) async {
    final savedOrder = await _homeLocalDataSource.getVitalsOrder();
    if (savedOrder == null) {
      return vitals;
    }
    final vitalsMap = <String, VitalSign>{};
    for (final vital in vitals) {
      vitalsMap[vital.title] = vital;
    }
    final reorderedVitals = <VitalSign>[];
    for (final title in savedOrder) {
      if (vitalsMap.containsKey(title)) {
        reorderedVitals.add(vitalsMap[title]!);
        vitalsMap.remove(title);
      }
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
