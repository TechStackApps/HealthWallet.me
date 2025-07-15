import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/data/mock_data.dart';
import 'package:health_wallet/core/services/home_preferences_service.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/recent_record.dart';
import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FhirRepository _fhirRepository;
  final GetSourcesUseCase _getSourcesUseCase;
  final HomePreferencesService _homePreferencesService;

  HomeBloc(this._fhirRepository, this._getSourcesUseCase,
      this._homePreferencesService)
      : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        initialised: () => _onInitialised(event, emit),
        sourceChanged: (source) => _onSourceChanged(source, emit),
        filtersChanged: (filters) => _onFiltersChanged(filters, emit),
        editModeChanged: (editMode) async {
          emit(state.copyWith(editMode: editMode));
        },
        recordsReordered: (oldIndex, newIndex) async {
          final cards = List.of(state.overviewCards);
          final card = cards.removeAt(oldIndex);
          cards.insert(newIndex, card);
          emit(state.copyWith(overviewCards: cards));

          // Save the new order to persistent storage
          final cardTitles = cards.map((card) => card.title).toList();
          await _homePreferencesService.saveRecordsOrder(cardTitles);
        },
        vitalsReordered: (oldIndex, newIndex) async {
          final vitals = List.of(state.vitalSigns);
          final vital = vitals.removeAt(oldIndex);
          vitals.insert(newIndex, vital);
          emit(state.copyWith(vitalSigns: vitals));

          // Save the new order to persistent storage
          final vitalTitles = vitals.map((vital) => vital.title).toList();
          await _homePreferencesService.saveVitalsOrder(vitalTitles);
        },
      );
    });
  }

  Future<void> _onSourceChanged(String source, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedSource: source));
    await _loadData(emit);
  }

  Future<void> _onInitialised(HomeEvent event, Emitter<HomeState> emit) async {
    await _loadData(emit);
  }

  Future<void> _onFiltersChanged(
      Map<String, bool> filters, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedResources: filters));
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<HomeState> emit) async {
    emit(state.copyWith(status: const HomeStatus.loading()));
    try {
      final sources = await _getSourcesUseCase();
      if (sources.where((s) => s.id == 'All').isEmpty) {
        sources.insert(0, const Source(id: 'All', name: 'All'));
      }

      final sourceId =
          state.selectedSource == 'All' ? null : state.selectedSource;

      final List<OverviewCard> overviewCards = [];
      final List<FhirResource> allEnabledResources = [];

      for (var resourceName in state.selectedResources.keys) {
        final resourceType = ClinicalDataTags.resourceTypeMap[resourceName];
        if (resourceType != null) {
          if (state.selectedResources[resourceName]!) {
            final resources = await _fhirRepository.getResources(
              resourceType: resourceType,
              sourceId: sourceId,
            );
            allEnabledResources.addAll(resources);
            overviewCards.add(
              OverviewCard(
                title: resourceName,
                count: resources.length.toString(),
              ),
            );
          } else {
            overviewCards.add(
              OverviewCard(
                title: resourceName,
                count: '0',
              ),
            );
          }
        }
      }

      allEnabledResources.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      final patientResource = await _fhirRepository.getResources(
        resourceType: 'Patient',
        sourceId: sourceId,
      );

      // Get vitals and apply saved order
      final vitals = List.of(MockData.vitalSigns);
      final reorderedVitals = _applyVitalSignsOrder(vitals);

      // Apply saved order to overview cards
      final reorderedOverviewCards = _applyOverviewCardsOrder(overviewCards);

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
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }

  /// Helper method to apply saved order to vital signs
  List<VitalSign> _applyVitalSignsOrder(List<VitalSign> vitals) {
    final savedOrder = _homePreferencesService.getVitalsOrder();
    if (savedOrder == null) {
      return vitals; // Return original order if no saved order
    }

    // Create a map for quick lookup
    final vitalsMap = <String, VitalSign>{};
    for (final vital in vitals) {
      vitalsMap[vital.title] = vital;
    }

    // Reorder based on saved order
    final reorderedVitals = <VitalSign>[];
    for (final title in savedOrder) {
      if (vitalsMap.containsKey(title)) {
        reorderedVitals.add(vitalsMap[title]!);
        vitalsMap.remove(title); // Remove to avoid duplicates
      }
    }

    // Add any remaining vitals that weren't in the saved order
    reorderedVitals.addAll(vitalsMap.values);

    return reorderedVitals;
  }

  /// Helper method to apply saved order to overview cards
  List<OverviewCard> _applyOverviewCardsOrder(List<OverviewCard> cards) {
    final savedOrder = _homePreferencesService.getRecordsOrder();
    if (savedOrder == null) {
      return cards; // Return original order if no saved order
    }

    // Create a map for quick lookup
    final cardsMap = <String, OverviewCard>{};
    for (final card in cards) {
      cardsMap[card.title] = card;
    }

    // Reorder based on saved order
    final reorderedCards = <OverviewCard>[];
    for (final title in savedOrder) {
      if (cardsMap.containsKey(title)) {
        reorderedCards.add(cardsMap[title]!);
        cardsMap.remove(title); // Remove to avoid duplicates
      }
    }

    // Add any remaining cards that weren't in the saved order
    reorderedCards.addAll(cardsMap.values);

    return reorderedCards;
  }
}
