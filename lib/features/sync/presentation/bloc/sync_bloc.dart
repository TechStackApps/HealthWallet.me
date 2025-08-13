import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/services/simple_discovery_service.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/core/utils/logger.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final FhirApiService _fhirApiService;
  final SimpleDiscoveryService _discoveryService;
  final SyncRepository _syncRepository;

  SyncBloc(this._fhirApiService, this._discoveryService, this._syncRepository)
      : super(const SyncState()) {
    logger.d('🏗️ [BLOC] SyncBloc constructor called');

    on<SyncEvent>((event, emit) async {
      logger.d('🏗️ [BLOC] Event received: ${event.runtimeType}');

      try {
        await event.when(
          // Service discovery and connection
          discoverServices: () async => await _onDiscoverServices(emit),
          clearDiscoveredServices: () async =>
              await _onClearDiscoveredServices(emit),
          connectToService: (service) async =>
              await _onConnectToService(emit, service),
          disconnectFromService: () async =>
              await _onDisconnectFromService(emit),
          testConnection: (service) async =>
              await _onTestConnection(emit, service),

          // Data operations
          syncData: () async => await _onSyncData(emit),

          // UI state management
          clearError: () async => _onClearError(emit),

          // Token and connection management
          checkTokenStatus: () async => await _onCheckTokenStatus(emit),
          checkConnectionValidity: () async =>
              await _onCheckConnectionValidity(emit),
        );
      } catch (e) {
        logger.e('🏗️ [BLOC] Error in event handler: $e');
      }

      logger.d('🏗️ [BLOC] Event handler completed for: ${event.runtimeType}');
    });
  }

  @override
  Future<void> close() {
    logger.d('🏗️ [BLOC] SyncBloc close() called');
    return super.close();
  }

  // Event handlers
  Future<void> _onDiscoverServices(Emitter<SyncState> emit) async {
    try {
      // Always start fresh discovery
      emit(state.copyWith(
        isLoading: true,
        isDiscovering: true,
        error: null,
        discoveredServices: [], // Clear previous discoveries
      ));

      // Ensure discovery is running before scanning
      await _discoveryService.startDiscovery();

      // Use the discovery service to discover real services
      final services = await _discoveryService.discoverByDirectIP();

      emit(state.copyWith(
        isLoading: false,
        isDiscovering: false,
        discoveredServices: services,
        lastDiscoveryTime: DateTime.now(),
      ));

      // Stop discovery after scan completes
      await _discoveryService.stopDiscovery();

      logger.d('✅ Discovered ${services.length} services');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isDiscovering: false,
        error: 'Failed to discover services: $e',
      ));
      logger.e('❌ Service discovery failed: $e');
    }
  }

  Future<void> _onClearDiscoveredServices(Emitter<SyncState> emit) async {
    emit(state.copyWith(
      discoveredServices: [],
      lastDiscoveryTime: null,
    ));
    logger.d('🧹 Cleared discovered services');
  }

  Future<void> _onConnectToService(
    Emitter<SyncState> emit,
    SSDPServiceInfo service,
  ) async {
    try {
      logger.d(
          '🔌 [DEBUG] Starting _onConnectToService for: ${service.friendlyName}');
      logger.d('🔌 [DEBUG] Current state: ${state.syncStatus}');
      logger.d('🔌 [DEBUG] BLoC closed status: $isClosed');

      emit(state.copyWith(
        isLoading: true,
        error: null,
        syncStatus: SyncStatus.connecting,
      ));
      logger.d('🔌 [DEBUG] Emitted connecting state');

      logger.d('🔌 [DEBUG] About to call _fhirApiService.connectToService');
      final isConnected =
          await _fhirApiService.testConnectionToService(service);
      logger.d('🔌 [DEBUG] testConnection result: $isConnected');

      if (isConnected) {
        // Connect the FhirApiService to this service by updating its base URL
        await _fhirApiService.connectToService(service);

        // Attempt to fetch mobile sync data and persist token
        try {
          final result = await _fhirApiService.getMobileSyncData(service);
          final data = result['data'] as Map<String, dynamic>;
          // Expect data to include token, server and endpoints as per your curl output
          // Persist via SyncRepository -> SyncTokenService path
          // Reuse existing method that supports raw JSON input
          await _syncRepository.syncDataWithJson(jsonEncode(data));
        } catch (_) {
          // Non-fatal if bootstrap fails; user can scan QR or retry
        }
        logger.d('🔌 [DEBUG] Connection successful, emitting connected state');
        emit(state.copyWith(
          isLoading: false,
          connectedService: service,
          syncStatus: SyncStatus.connected,
        ));
        logger.d('🔌 [DEBUG] Connected state emitted successfully');
        logger.d('✅ Connected to service: ${service.friendlyName}');
      } else {
        throw Exception('Connection test failed');
      }
      logger.d('🔌 [DEBUG] _onConnectToService method completed');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to connect: $e',
        syncStatus: SyncStatus.error,
      ));
      logger.e('❌ Failed to connect to service: $e');
    }
  }

  Future<void> _onDisconnectFromService(Emitter<SyncState> emit) async {
    try {
      if (state.connectedService != null) {
        await _fhirApiService.disconnectFromService(state.connectedService!);
      }

      emit(state.copyWith(
        connectedService: null,
        syncStatus: SyncStatus.disconnected,
      ));

      logger.d('🔌 Disconnected from service');
    } catch (e) {
      logger.e('❌ Error during disconnect: $e');
      // Still update state even if disconnect fails
      emit(state.copyWith(
        connectedService: null,
        syncStatus: SyncStatus.disconnected,
      ));
    }
  }

  Future<void> _onTestConnection(
    Emitter<SyncState> emit,
    SSDPServiceInfo service,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final isConnected =
          await _fhirApiService.testConnectionToService(service);

      if (isConnected) {
        emit(state.copyWith(
          isLoading: false,
          error: null,
        ));
        logger.d('✅ Connection test successful');
      } else {
        throw Exception('Connection test failed');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Connection test failed: $e',
      ));
      logger.e('❌ Connection test failed: $e');
    }
  }

  Future<void> _onSyncData(Emitter<SyncState> emit) async {
    try {
      if (state.connectedService == null) {
        throw Exception('No service connected');
      }

      emit(state.copyWith(
        isLoading: true,
        error: null,
        syncStatus: SyncStatus.syncing,
      ));

      // Use the sync repository for data sync
      await _syncRepository.syncData();

      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.connected,
        lastSyncTime: DateTime.now(),
      ));

      logger.d('✅ Data sync completed successfully');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.error,
        error: 'Data sync failed: $e',
      ));
      logger.e('❌ Data sync failed: $e');
    }
  }

  void _onClearError(Emitter<SyncState> emit) {
    emit(state.copyWith(error: null));
  }

  Future<void> _onCheckTokenStatus(Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final status = await _syncRepository.checkConnectionValidity();

      emit(state.copyWith(
        isLoading: false,
        error: null,
      ));

      logger.d('✅ Token status checked: $status');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to check token status: $e',
      ));
      logger.e('❌ Token status check failed: $e');
    }
  }

  Future<void> _onCheckConnectionValidity(Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final status = await _syncRepository.checkConnectionValidity();

      emit(state.copyWith(
        isLoading: false,
        error: null,
      ));

      logger.d('✅ Connection validity checked: $status');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to check connection validity: $e',
      ));
      logger.e('❌ Connection validity check failed: $e');
    }
  }
}
