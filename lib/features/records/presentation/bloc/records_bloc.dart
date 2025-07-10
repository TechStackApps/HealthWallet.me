import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/use_case/get_resources_use_case.dart';
import 'package:injectable/injectable.dart';

part 'records_event.dart';
part 'records_state.dart';
part 'records_bloc.freezed.dart';

@injectable
class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final GetResourcesUseCase _getResourcesUseCase;

  RecordsBloc(this._getResourcesUseCase) : super(const RecordsState()) {
    on<_LoadRecords>(_onLoadRecords);
    on<_UpdateFilters>(_onUpdateFilters);
  }

  Future<void> _onLoadRecords(
    _LoadRecords event,
    Emitter<RecordsState> emit,
  ) async {
    logger.d('RecordsBloc: _onLoadRecords event received: $event');
    emit(state.copyWith(status: RecordsStatus.loading));
    try {
      final resources = await _getResourcesUseCase.call(
        sourceId: event.sourceId,
      );
      logger.d('RecordsBloc: ${resources.length} resources fetched');
      resources.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      final availableFilters =
          resources.map((e) => e.resourceType).toSet().toList();
      final filters = event.filter != null ? [event.filter!] : state.filters;
      emit(
        state.copyWith(
          status: RecordsStatus.success,
          entries: resources,
          availableFilters: availableFilters,
          filters: filters,
        ),
      );
      logger.d('RecordsBloc: state emitted with ${resources.length} entries');
    } catch (e) {
      logger.e('RecordsBloc: error fetching records', e);
      emit(state.copyWith(status: RecordsStatus.failure, error: e.toString()));
    }
  }

  void _onUpdateFilters(
    _UpdateFilters event,
    Emitter<RecordsState> emit,
  ) {
    emit(state.copyWith(filters: event.filters));
  }
}
