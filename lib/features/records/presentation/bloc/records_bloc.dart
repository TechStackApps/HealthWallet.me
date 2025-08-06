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
    on<RecordsFilterChanged>(_onFilterChanged);
    on<RecordsSourceChanged>(_onSourceChanged);
    on<RecordsFilterToggled>(_onFilterToggled);
    on<RecordsLoadFilters>(_onLoadFilters);
    on<RecordDetailLoaded>(_onRecordDetailLoaded);
    on<ReferenceResolved>(_onReferenceResolved);
  }

  Future<void> _onInitialised(
      RecordsInitialised event, Emitter<RecordsState> emit) async {
    emit(state.copyWith(status: const RecordsStatus.loading()));
    try {
      _recordsRepository.reset();

      Set<FhirType> activeFilters;
      if (state.activeFilters.isEmpty) {
        // Load all resource types when no filters are active
        activeFilters = FhirType.values.toSet();
      } else {
        activeFilters = state.activeFilters;
      }

      const limit = 20; // Page size
      logger.d('🔍 Loading resources with filters: $activeFilters');

      // Use getAllResources when filtering (from home page) to show all resources
      // Use getResources when no filters (timeline view) to show only standalone resources
      final allResources = state.activeFilters.isEmpty
          ? await _recordsRepository.getResources(
              resourceTypes: activeFilters.toList(),
              sourceId: state.sourceId,
              limit: limit,
              offset: 0,
            )
          : await _recordsRepository.getAllResources(
              resourceTypes: activeFilters.toList(),
              sourceId: state.sourceId,
              limit: limit,
              offset: 0,
            );

      logger.d('📦 Loaded ${allResources.length} resources');
      logger.d(
          '📋 Resource types: ${allResources.map((r) => r.fhirType).toList()}');

      // If we got fewer resources than the limit, we've reached the end
      final hasMore = allResources.length == limit;

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: allResources,
          availableFilters: FhirType.values,
          hasMorePages: hasMore,
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
      Set<FhirType> activeFilters;
      if (state.activeFilters.isEmpty) {
        // Load all resource types when no filters are active
        activeFilters = FhirType.values.toSet();
      } else {
        activeFilters = state.activeFilters;
      }

      // Calculate the offset based on current resources count
      final offset = state.resources.length;
      const limit = 20; // Page size

      // Use getAllResources when filtering (from home page) to show all resources
      // Use getResources when no filters (timeline view) to show only standalone resources
      final resources = state.activeFilters.isEmpty
          ? await _recordsRepository.getResources(
              resourceTypes: activeFilters.toList(),
              sourceId: state.sourceId,
              limit: limit,
              offset: offset,
            )
          : await _recordsRepository.getAllResources(
              resourceTypes: activeFilters.toList(),
              sourceId: state.sourceId,
              limit: limit,
              offset: offset,
            );

      // If we got fewer resources than the limit, we've reached the end
      final hasMore = resources.length == limit;

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: List.from(state.resources)..addAll(resources),
          hasMorePages: hasMore,
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
    emit(state.copyWith(activeFilters: Set<FhirType>.from(event.filter)));
    add(const RecordsInitialised());
  }

  Future<void> _onLoadFilters(
      RecordsLoadFilters event, Emitter<RecordsState> emit) async {
    try {
      emit(state.copyWith(availableFilters: FhirType.values));
    } catch (e) {
      emit(state.copyWith(status: RecordsStatus.failure(e)));
    }
  }

  Future<void> _onRecordDetailLoaded(
      RecordDetailLoaded event, Emitter<RecordsState> emit) async {
    emit(
        state.copyWith(recordDetailStatus: const RecordDetailStatus.loading()));
    try {
      // Load related resources for the encounter
      final relatedResources = await _recordsRepository
          .getRelatedResourcesForEncounter(event.recordId);

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

  Future<void> _onReferenceResolved(
      ReferenceResolved event, Emitter<RecordsState> emit) async {
    try {
      // Store the resolved reference in the state
      final resolvedReferences =
          Map<String, String>.from(state.resolvedReferences);
      resolvedReferences[event.reference] = event.displayName;

      emit(state.copyWith(resolvedReferences: resolvedReferences));
    } catch (e) {
      // Handle error silently for reference resolution
    }
  }
}
