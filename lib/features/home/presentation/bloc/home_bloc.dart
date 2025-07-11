import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/data/mock_data.dart';
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

  HomeBloc(this._fhirRepository, this._getSourcesUseCase)
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
        },
        vitalsReordered: (oldIndex, newIndex) async {
          final vitals = List.of(state.vitalSigns);
          final vital = vitals.removeAt(oldIndex);
          vitals.insert(newIndex, vital);
          emit(state.copyWith(vitalSigns: vitals));
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

      emit(
        state.copyWith(
          status: const HomeStatus.success(),
          vitalSigns: MockData.vitalSigns,
          overviewCards: overviewCards,
          recentRecords: allEnabledResources.take(3).toList(),
          sources: sources,
          patient: patientResource.isNotEmpty ? patientResource.first : null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure(e)));
    }
  }
}
