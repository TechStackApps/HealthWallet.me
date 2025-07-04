import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/records/domain/use_case/get_records_entries_use_case.dart';
import 'package:injectable/injectable.dart';

part 'records_event.dart';
part 'records_state.dart';
part 'records_bloc.freezed.dart';

@injectable
class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final GetRecordsEntriesUseCase _getRecordsEntriesUseCase;
  List<FhirResource> _allEntries = [];

  RecordsBloc(this._getRecordsEntriesUseCase)
      : super(const RecordsState.initial(availableFilters: [])) {
    on<RecordsEvent>((event, emit) async {
      await event.when(
        fetchRecords: (resourceType) async {
          emit(
            RecordsState.loading(
              filters: state.filters,
              availableFilters: state.availableFilters,
            ),
          );
          try {
            _allEntries =
                await _getRecordsEntriesUseCase(resourceType: resourceType);
            final availableFilters =
                _allEntries.map((e) => e.resourceType).toSet().toList();
            final filteredEntries = _filterEntries(_allEntries, state.filters);
            emit(
              RecordsState.loaded(
                filteredEntries,
                state.filters,
                availableFilters,
              ),
            );
          } catch (e) {
            emit(
              RecordsState.error(
                'Failed to load records.',
                filters: state.filters,
                availableFilters: state.availableFilters,
              ),
            );
          }
        },
        addFilter: (filter) {
          final newFilters = List<String>.from(state.filters)..add(filter);
          final filteredEntries = _filterEntries(_allEntries, newFilters);
          emit(
            RecordsState.loaded(
              filteredEntries,
              newFilters,
              state.availableFilters,
            ),
          );
        },
        removeFilter: (filter) {
          final newFilters = List<String>.from(state.filters)..remove(filter);
          final filteredEntries = _filterEntries(_allEntries, newFilters);
          emit(
            RecordsState.loaded(
              filteredEntries,
              newFilters,
              state.availableFilters,
            ),
          );
        },
        clearFilters: () {
          emit(
            RecordsState.loaded(_allEntries, const [], state.availableFilters),
          );
        },
      );
    });
  }

  List<FhirResource> _filterEntries(
    List<FhirResource> entries,
    List<String> filters,
  ) {
    if (filters.isEmpty) {
      return entries;
    }
    return entries.where((entry) {
      return filters.any((filter) => entry.resourceType == filter);
    }).toList();
  }
}
