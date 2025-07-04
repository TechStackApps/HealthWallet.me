import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/services/sync_service.dart';
import 'package:injectable/injectable.dart';

part 'sync_status_event.dart';
part 'sync_status_state.dart';
part 'sync_status_bloc.freezed.dart';

@injectable
class SyncStatusBloc extends Bloc<SyncStatusEvent, SyncStatusState> {
  final SyncService _syncService;

  SyncStatusBloc(this._syncService) : super(const SyncStatusState.initial()) {
    on<_CheckSyncStatus>(_onCheckSyncStatus);
  }

  Future<void> _onCheckSyncStatus(
    _CheckSyncStatus event,
    Emitter<SyncStatusState> emit,
  ) async {
    emit(const SyncStatusState.loading());
    try {
      final lastServerUpdate = await _syncService.getLastServerUpdateTime();
      final lastSync = _syncService.getLastSyncTimestamp();

      if (lastServerUpdate != null && lastSync != null) {
        final isSynced = lastSync.isAfter(lastServerUpdate);
        emit(SyncStatusState.success(isSynced: isSynced));
      } else {
        emit(const SyncStatusState.success(isSynced: false));
      }
    } catch (e) {
      emit(const SyncStatusState.error());
    }
  }
}
