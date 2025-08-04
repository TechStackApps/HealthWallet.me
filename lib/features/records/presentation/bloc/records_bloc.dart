import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
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

      Set<FhirType> activeFilters;
      if (state.activeFilters.isEmpty) {
        activeFilters = {FhirType.Encounter};
      } else {
        activeFilters = state.activeFilters;
      }

      final allResources = await _recordsRepository.getResources(
        resourceTypes: activeFilters.toList(),
        sourceId: state.sourceId,
      );

      emit(
        state.copyWith(
          status: const RecordsStatus.success(),
          resources: allResources,
          availableFilters: FhirType.values,
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
      //TODO: implement pagination

      // Set<FhirType> activeFilters;
      // if (state.activeFilters.isEmpty) {
      //   activeFilters = {FhirType.Encounter};
      // } else {
      //   activeFilters = state.activeFilters;
      // }

      // final resources = await _recordsRepository.getResources(
      //   resourceTypes: activeFilters.toList(),
      //   sourceId: state.sourceId,
      // );

      // emit(
      //   state.copyWith(
      //     status: const RecordsStatus.success(),
      //     resources: List.from(state.resources)..addAll(resources),
      //     hasMorePages: _recordsRepository.hasMorePages,
      //   ),
      // );
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
      emit(
        state.copyWith(
          recordDetailStatus: const RecordDetailStatus.success(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        recordDetailStatus: RecordDetailStatus.failure(e),
      ));
    }
  }
}
