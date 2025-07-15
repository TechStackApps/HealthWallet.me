import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/timeline_resource_model.dart';
import 'package:injectable/injectable.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';
part 'timeline_bloc.freezed.dart';

@injectable
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final RecordsRepository _timelineService;

  TimelineBloc(
    this._timelineService, {
    Set<String> initialFilters = const {},
    String? sourceId,
  }) : super(TimelineState(filters: initialFilters, sourceId: sourceId)) {
    on<_Load>(_onLoad);
    on<_LoadMore>(_onLoadMore);
    on<_FilterChanged>(_onFilterChanged);
    on<_SourceChanged>(_onSourceChanged);
  }

  Future<void> _onLoad(_Load event, Emitter<TimelineState> emit) async {
    print('DEBUG: TimelineBloc loading with sourceId: ${state.sourceId}');
    emit(state.copyWith(status: TimelineStatus.loading));
    try {
      _timelineService.reset();
      final filters = state.filters.isNotEmpty
          ? state.filters.toList()
          : [
              'Encounter',
              'AllergyIntolerance',
              'Condition',
              'Procedure',
              'MedicationRequest',
              'Observation',
              'DiagnosticReport',
              'Immunization',
              'CarePlan',
              'Goal',
              'DocumentReference',
              'Media',
              'Patient',
              'Practitioner',
              'Organization',
              'Location',
            ];
      final resources = await _timelineService.getTimelineResources(
        resourceTypes: filters,
        sourceId: state.sourceId,
      );
      emit(
        state.copyWith(
          status: TimelineStatus.success,
          resources: resources,
          hasMorePages: _timelineService.hasMorePages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TimelineStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<TimelineState> emit) async {
    if (!state.hasMorePages) return;
    try {
      final resources = await _timelineService.getTimelineResources(
        resourceTypes: state.filters.toList(),
        loadMore: true,
        sourceId: state.sourceId,
      );
      emit(
        state.copyWith(
          status: TimelineStatus.success,
          resources: List.from(state.resources)..addAll(resources),
          hasMorePages: _timelineService.hasMorePages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TimelineStatus.failure, error: e.toString()));
    }
  }

  void _onFilterChanged(_FilterChanged event, Emitter<TimelineState> emit) {
    emit(state.copyWith(filters: event.newFilters));
    add(const TimelineEvent.load());
  }

  void _onSourceChanged(_SourceChanged event, Emitter<TimelineState> emit) {
    print('DEBUG: TimelineBloc received sourceChanged: ${event.sourceId}');
    emit(state.copyWith(sourceId: event.sourceId));
    add(const TimelineEvent.load());
  }
}
