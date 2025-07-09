import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sync_bloc.freezed.dart';
part 'sync_event.dart';
part 'sync_state.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final FhirRepository _fhirRepository;
  final SharedPreferences _prefs;

  SyncBloc(this._fhirRepository, this._prefs) : super(const SyncState()) {
    on<SyncEvent>((event, emit) async {
      await event.when(
        syncData: () => _onSyncData(emit),
        syncDataWithJson: (jsonData) => _onSyncDataWithJson(jsonData, emit),
        historyLoaded: () => _onHistoryLoaded(emit),
      );
    });
  }

  Future<void> _onSyncData(Emitter<SyncState> emit) async {
    emit(state.copyWith(status: const SyncStatus.loading()));
    try {
      await _fhirRepository.syncData();
      await _addSyncTimeToHistory();
      emit(state.copyWith(
          status: const SyncStatus.success(), history: _getSyncHistory()));
    } catch (e) {
      emit(state.copyWith(status: SyncStatus.failure(e.toString())));
    }
  }

  Future<void> _onSyncDataWithJson(
      String jsonData, Emitter<SyncState> emit) async {
    emit(state.copyWith(status: const SyncStatus.loading()));
    try {
      await _fhirRepository.syncDataWithJson(jsonData);
      await _addSyncTimeToHistory();
      emit(state.copyWith(
          status: const SyncStatus.success(), history: _getSyncHistory()));
    } catch (e) {
      emit(state.copyWith(status: SyncStatus.failure(e.toString())));
    }
  }

  Future<void> _onHistoryLoaded(Emitter<SyncState> emit) async {
    emit(state.copyWith(history: _getSyncHistory()));
  }

  List<DateTime> _getSyncHistory() {
    final history = _prefs.getStringList('sync_history') ?? [];
    return history.map((e) => DateTime.parse(e)).toList();
  }

  Future<void> _addSyncTimeToHistory() async {
    final history = _getSyncHistory();
    history.insert(0, DateTime.now());
    await _prefs.setStringList(
        'sync_history', history.map((e) => e.toIso8601String()).toList());
  }
}
