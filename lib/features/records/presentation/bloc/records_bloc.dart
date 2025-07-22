import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/timeline_resource_model.dart';
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
    on<RecordsFilterChanged>(_onFilterChanged);
    on<RecordsSourceChanged>(_onSourceChanged);
    on<RecordsFilterToggled>(_onFilterToggled);
    on<RecordsLoadFilters>(_onLoadFilters);
    on<RecordDetailLoaded>(_onRecordDetailLoaded);
  }

  Future<void> _onInitialised(
      RecordsInitialised event, Emitter<RecordsState> emit) async {
    emit(state.copyWith(status: const RecordsStatus.loading()));
    try {
      _recordsRepository.reset();

      final allResources = await _recordsRepository.getTimelineResources(
        resourceTypes: state.activeFilters.toList(),
        sourceId: state.sourceId,
      );

      final resourcesWithData = allResources.where((resource) {
        if (resource.resourceType == 'Encounter') {
          return true;
        }
        return resource.isStandalone;
      }).toList();

      final availableFilters =
          await _recordsRepository.getAvailableResourceTypes();

      final filtersWithData = availableFilters.where((filter) {
        return allResources.any((resource) =>
            resource.resourceType == filter &&
            (resource.isStandalone || resource.resourceType == 'Encounter'));
      }).toList();

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: resourcesWithData,
          availableFilters: filtersWithData,
          hasMorePages: _recordsRepository.hasMorePages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    }
  }

  Future<void> _onLoadMore(
      RecordsLoadMore event, Emitter<RecordsState> emit) async {
    if (!state.hasMorePages) return;
    try {
      final resources = await _recordsRepository.getTimelineResources(
        resourceTypes: state.activeFilters.toList(),
        loadMore: true,
        sourceId: state.sourceId,
      );

      final filteredResources = resources.where((resource) {
        if (resource.resourceType == 'Encounter') {
          return true;
        }
        return resource.isStandalone;
      }).toList();

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: List.from(state.resources)..addAll(filteredResources),
          hasMorePages: _recordsRepository.hasMorePages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    }
  }

  void _onFilterChanged(
      RecordsFilterChanged event, Emitter<RecordsState> emit) {
    emit(state.copyWith(activeFilters: event.newFilters));
    add(const RecordsInitialised());
  }

  void _onSourceChanged(
      RecordsSourceChanged event, Emitter<RecordsState> emit) {
    emit(state.copyWith(sourceId: event.sourceId));
    add(const RecordsInitialised());
  }

  void _onFilterToggled(
      RecordsFilterToggled event, Emitter<RecordsState> emit) {
    final newActiveFilters = Set<String>.from(state.activeFilters);
    if (newActiveFilters.contains(event.filter)) {
      newActiveFilters.remove(event.filter);
    } else {
      newActiveFilters.add(event.filter);
    }

    emit(state.copyWith(activeFilters: newActiveFilters));
    add(const RecordsInitialised());
  }

  Future<void> _onLoadFilters(
      RecordsLoadFilters event, Emitter<RecordsState> emit) async {
    try {
      final availableFilters =
          await _recordsRepository.getAvailableResourceTypes();
      emit(state.copyWith(availableFilters: availableFilters));
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    }
  }

  Future<void> _onRecordDetailLoaded(
      RecordDetailLoaded event, Emitter<RecordsState> emit) async {
    emit(
        state.copyWith(recordDetailStatus: const RecordDetailStatus.loading()));
    try {
      final resources = await _recordsRepository
          .getRelatedResourcesForEncounter(event.recordId);
      emit(
        state.copyWith(
          recordDetailStatus: const RecordDetailStatus.success(),
          relatedResources: resources,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        recordDetailStatus: RecordDetailStatus.failure(e),
      ));
    }
  }
}
