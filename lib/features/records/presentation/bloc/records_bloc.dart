import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:injectable/injectable.dart';

part 'records_event.dart';
part 'records_state.dart';
part 'records_bloc.freezed.dart';

@injectable
class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final RecordsRepository _recordsRepository;

  RecordsBloc(this._recordsRepository) : super(const RecordsState()) {
    on<RecordsInitialised>(_onInitialised);
    on<RecordsLoadMore>(_onLoadMore);
    on<RecordsSourceChanged>(_onSourceChanged);
    on<RecordsFiltersApplied>(_onFiltersApplied);
    on<RecordsFilterRemoved>(_onFilterRemoved);
    on<RecordDetailLoaded>(_onRecordDetailLoaded);
  }

  Future _loadResources(
    Emitter<RecordsState> emit, {
    int limit = 20,
    offset = 0,
  }) async {
    emit(state.copyWith(status: const RecordsStatus.loading()));
    try {
      final resources = await _recordsRepository.getResources(
        resourceTypes: state.activeFilters,
        sourceId: state.sourceId,
        limit: limit,
        offset: offset,
      );

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: List.from(state.resources)..addAll(resources),
          hasMorePages: resources.length == limit,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    }
  }

  Future<void> _onInitialised(
    RecordsInitialised event,
    Emitter<RecordsState> emit,
  ) async {
    if (state.activeFilters.isEmpty) {
      emit(state.copyWith(activeFilters: [FhirType.Encounter]));
    }

    await _loadResources(emit);
  }

  Future<void> _onLoadMore(
    RecordsLoadMore event,
    Emitter<RecordsState> emit,
  ) async {
    if (!state.hasMorePages) return;

    await _loadResources(emit, offset: state.resources.length);
  }

  void _onSourceChanged(
    RecordsSourceChanged event,
    Emitter<RecordsState> emit,
  ) {
    emit(state.copyWith(sourceId: event.sourceId));
    add(const RecordsInitialised());
  }

  void _onFiltersApplied(
    RecordsFiltersApplied event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      activeFilters: event.filters,
      resources: [],
    ));

    await _loadResources(emit);
  }

  void _onFilterRemoved(
    RecordsFilterRemoved event,
    Emitter<RecordsState> emit,
  ) async {
    emit(state.copyWith(
      activeFilters: [...state.activeFilters]..remove(event.filter),
      resources: [],
    ));

    await _loadResources(emit);
  }

  Future<void> _onRecordDetailLoaded(
    RecordDetailLoaded event,
    Emitter<RecordsState> emit,
  ) async {
    emit(
        state.copyWith(recordDetailStatus: const RecordDetailStatus.loading()));
    try {
      final relatedResources = event.resource.fhirType == FhirType.Encounter
          ? await _recordsRepository.getRelatedResourcesForEncounter(
              encounterId: event.resource.resourceId)
          : await _recordsRepository.getRelatedResources(
              resource: event.resource);

      log(relatedResources.toString());

      emit(
        state.copyWith(
          recordDetailStatus: const RecordDetailStatus.success(),
          relatedResources: relatedResources,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        recordDetailStatus: RecordDetailStatus.failure(e),
      ));
    }
  }
}
