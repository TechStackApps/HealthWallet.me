import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:health_wallet/features/sync/domain/entities/sync_qr_data.dart';

import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncRepository _syncRepository;
  final RecordsRepository _recordsRepository;

  SyncBloc(
    this._syncRepository,
    this._recordsRepository,
  ) : super(const SyncState()) {
    on<SyncInitialised>(_onSyncInitialised);
    on<SyncDataInitiated>(_onSyncDataInitiated);

    // QR Code Sync events
    on<SyncScanQRCode>(_onScanQRCode);
    on<SyncScanNewPressed>(_onSyncScanNewPressed);
    on<SyncCancelQRScanning>(_onCancelQRScanning);
    on<SyncLoadDemoData>(_onLoadDemoData);
    on<SyncDataCompleted>(_onDataCompleted);
    on<OnboardingOverlayTriggered>(_onOnboardingOverlayTriggered);
    on<SyncResetOnboarding>(_onResetOnboarding);
  }

  _onSyncInitialised(
    SyncInitialised event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    ));
    try {
      SyncQrData? qrData = await _syncRepository.getCurrentSyncQrData();
      String? lastSyncTime = await _syncRepository.getLastSyncTimestamp();

      emit(state.copyWith(
        syncQrData: qrData,
        lastSyncTime: lastSyncTime,
        syncStatus: qrData != null ? SyncStatus.synced : SyncStatus.syncing,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _onSyncDataInitiated(
    SyncDataInitiated event,
    Emitter<SyncState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isQRScanning: false,
    ));
    try {
      final qrDataJson = jsonDecode(event.qrData) as Map<String, dynamic>;
      final syncQrData = SyncQrData.fromJson(qrDataJson);

      await _recordsRepository.clearDemoData();

      _syncRepository.setBearerToken(syncQrData.token);
      _syncRepository.setBaseUrl(syncQrData.serverBaseUrls.first);

      await _syncRepository.syncResources(endpoint: syncQrData.syncEndpoint);

      await _syncRepository.saveSyncQrData(syncQrData);

      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.synced,
        syncQrData: syncQrData,
        lastSyncTime: DateTime.now().toIso8601String(),
        hasSyncData: true,
        errorMessage: null,
        successMessage: "Data was succesfully synced!",
      ));

      add(const SyncDataCompleted(
        sourceId: 'sync',
        isSuccess: true,
      ));
    } catch (e) {
      log(e.toString());
      // Determine if it's a connection issue or other error
      String errorMessage;
      if (e.toString().contains('HandshakeException') ||
          e.toString().contains('Connection refused') ||
          e.toString().contains('timeout')) {
        errorMessage =
            'Connection failed. Please check your network and try again.';
      } else if (e.toString().contains('404')) {
        errorMessage =
            'Sync endpoint not found. Please check server configuration.';
      } else if (e.toString().contains('401') || e.toString().contains('403')) {
        errorMessage = 'Authentication failed. Please check your token.';
      } else if (e.toString().contains('FormatException')) {
        errorMessage = 'Invalid sync data format';
      } else {
        errorMessage = 'Data sync failed: $e';
      }

      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        successMessage: null,
      ));
    }
  }

  // QR Code Sync Event Handlers
  Future<void> _onScanQRCode(
      SyncScanQRCode event, Emitter<SyncState> emit) async {
    emit(state.copyWith(
      isQRScanning: true,
    ));
  }

  Future<void> _onSyncScanNewPressed(
      SyncScanNewPressed event, Emitter<SyncState> emit) async {
    emit(state.copyWith(
      syncStatus: SyncStatus.syncing,
      successMessage: null,
      errorMessage: null,
    ));
  }

  Future<void> _onCancelQRScanning(
      SyncCancelQRScanning event, Emitter<SyncState> emit) async {
    emit(state.copyWith(isQRScanning: false));
  }

  Future<void> _onLoadDemoData(
      SyncLoadDemoData event, Emitter<SyncState> emit) async {
    logger.d('🧪 Loading demo data...');
    emit(state.copyWith(
      isLoadingDemoData: true,
      demoDataError: null,
    ));

    try {
      await _recordsRepository.loadDemoData();
      final hasDemoData = await _recordsRepository.hasDemoData();

      emit(state.copyWith(
        isLoadingDemoData: false,
        hasDemoData: hasDemoData,
        demoDataError: null,
      ));

      add(const SyncDataCompleted(
        sourceId: 'demo_data',
        isSuccess: true,
      ));
    } catch (e) {
      logger.e('❌ Failed to load demo data: $e');
      emit(state.copyWith(
        isLoadingDemoData: false,
        demoDataError: e.toString(),
      ));

      // Emit data completed event with error
      add(SyncDataCompleted(
        sourceId: 'demo_data',
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDataCompleted(
      SyncDataCompleted event, Emitter<SyncState> emit) async {
    logger.d(
        '📊 Data operation completed: ${event.sourceId} - Success: ${event.isSuccess}');

    if (event.isSuccess) {
      if (event.sourceId == 'demo_data') {
        final hasDemoData = await _recordsRepository.hasDemoData();
        emit(state.copyWith(
          hasDemoData: hasDemoData,
          shouldShowOnboarding: false,
        ));
      } else if (event.sourceId == 'sync') {
        logger.d('🔄 Sync data completed - updating state...');
        emit(state.copyWith(
          hasSyncData: true,
          shouldShowOnboarding: false,
        ));
      }
    }
  }

  Future<void> _onOnboardingOverlayTriggered(
      OnboardingOverlayTriggered event, Emitter<SyncState> emit) async {
    logger.d('🎯 Onboarding overlay triggered');
    emit(state.copyWith(shouldShowOnboarding: true));
  }

  Future<void> _onResetOnboarding(
      SyncResetOnboarding event, Emitter<SyncState> emit) async {
    logger.d('🔄 Resetting onboarding state');
    emit(state.copyWith(shouldShowOnboarding: false));
  }

  void resetOnboardingState() {
    add(const SyncResetOnboarding());
  }
}
