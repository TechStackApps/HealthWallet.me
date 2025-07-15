import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

part 'records_filter_event.dart';
part 'records_filter_state.dart';
part 'records_filter_bloc.freezed.dart';

@singleton
class RecordsFilterBloc extends Bloc<RecordsFilterEvent, RecordsFilterState> {
  final RecordsRepository _recordsService;

  RecordsFilterBloc(this._recordsService) : super(const RecordsFilterState()) {
    on<_Load>(_onLoad);
    on<_ToggleFilter>(_onToggleFilter);
  }

  Future<void> _onLoad(_Load event, Emitter<RecordsFilterState> emit) async {
    final availableFilters = await _recordsService.getAvailableResourceTypes();
    emit(state.copyWith(availableFilters: availableFilters));
  }

  void _onToggleFilter(_ToggleFilter event, Emitter<RecordsFilterState> emit) {
    final newFilters = Set<String>.from(state.activeFilters);
    if (newFilters.contains(event.filter)) {
      newFilters.remove(event.filter);
    } else {
      newFilters.add(event.filter);
    }
    emit(state.copyWith(activeFilters: newFilters));
  }
}
