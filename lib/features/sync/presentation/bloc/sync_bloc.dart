import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/services/discovery_service.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final FhirApiService _fhirApiService;
  final DiscoveryService _discoveryService;
  final SyncRepository _syncRepository;
  final SharedPreferences _prefs;

  static const String _persistKey = 'sync_persisted_state_v1';

  SyncBloc(this._fhirApiService, this._discoveryService, this._syncRepository,
      this._prefs)
      : super(const SyncState()) {
    on<SyncDiscoverServices>(_onDiscoverServices);
    on<SyncClearDiscoveredServices>(_onClearDiscoveredServices);
    on<SyncConnectToService>(_onConnectToService);
    on<SyncDisconnectFromService>(_onDisconnectFromService);
    on<SyncTestConnection>(_onTestConnection);
    on<SyncData>(_onSyncData);
    on<SyncClearError>(_onClearError);
    on<SyncCheckTokenStatus>(_onCheckTokenStatus);
    on<SyncCheckConnectionValidity>(_onCheckConnectionValidity);
    on<SyncRestoreState>(_onRestoreState);

    add(const SyncRestoreState());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onDiscoverServices(
      SyncDiscoverServices event, Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        isDiscovering: true,
        error: null,
        discoveredServices: [],
      ));

      await _discoveryService.startDiscovery();

      final services = await _discoveryService.discoverByDirectIP();

      emit(state.copyWith(
        isLoading: false,
        isDiscovering: false,
        discoveredServices: services,
        lastDiscoveryTime: DateTime.now(),
      ));

      await _persistState();

      await _discoveryService.stopDiscovery();

      if (services.isEmpty) {
        emit(state.copyWith(
          error:
              'No Fasten server found. Make sure your Fasten server is running and reachable on the same network, then tap SCAN again.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isDiscovering: false,
        error: 'Failed to discover services: $e',
      ));
    }
  }

  Future<void> _onClearDiscoveredServices(
      SyncClearDiscoveredServices event, Emitter<SyncState> emit) async {
    emit(state.copyWith(
      discoveredServices: [],
      lastDiscoveryTime: null,
    ));
    await _persistState();
  }

  Future<void> _onConnectToService(
    SyncConnectToService event,
    Emitter<SyncState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
        syncStatus: SyncStatus.connecting,
      ));

      final isConnected =
          await _fhirApiService.testConnectionToService(event.service);

      if (isConnected) {
        await _fhirApiService.connectToService(event.service);

        try {
          final result = await _fhirApiService.getMobileSyncData(event.service);
          final data = result['data'] as Map<String, dynamic>;
          await _syncRepository.syncDataWithJson(jsonEncode(data));
        } catch (_) {}
        final updatedRecent = _upsertRecentConnection(service: event.service);
        emit(state.copyWith(
          isLoading: false,
          connectedService: event.service,
          syncStatus: SyncStatus.connected,
          recentConnections: updatedRecent,
        ));
        await _persistState();
      } else {
        throw Exception('Connection test failed');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to connect: $e',
        syncStatus: SyncStatus.error,
      ));
    }
  }

  Future<void> _onDisconnectFromService(
      SyncDisconnectFromService event, Emitter<SyncState> emit) async {
    try {
      if (state.connectedService != null) {
        await _fhirApiService.disconnectFromService(state.connectedService!);
      }

      emit(state.copyWith(
        connectedService: null,
        syncStatus: SyncStatus.disconnected,
      ));
      await _persistState();
    } catch (e) {
      emit(state.copyWith(
        connectedService: null,
        syncStatus: SyncStatus.disconnected,
      ));
    }
  }

  Future<void> _onTestConnection(
    SyncTestConnection event,
    Emitter<SyncState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final isConnected =
          await _fhirApiService.testConnectionToService(event.service);

      if (isConnected) {
        emit(state.copyWith(
          isLoading: false,
          error: null,
        ));
        await _persistState();
      } else {
        throw Exception('Connection test failed');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Connection test failed: $e',
      ));
    }
  }

  Future<void> _onSyncData(SyncData event, Emitter<SyncState> emit) async {
    try {
      if (state.connectedService == null) {
        throw Exception('No service connected');
      }

      emit(state.copyWith(
        isLoading: true,
        error: null,
        syncStatus: SyncStatus.syncing,
      ));

      await _syncRepository.syncData();

      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.connected,
        lastSyncTime: DateTime.now(),
      ));
      await _persistState();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.error,
        error: 'Data sync failed: $e',
      ));
    }
  }

  void _onClearError(SyncClearError event, Emitter<SyncState> emit) {
    emit(state.copyWith(error: null));
  }

  Future<void> _onCheckTokenStatus(
      SyncCheckTokenStatus event, Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _syncRepository.checkConnectionValidity();

      emit(state.copyWith(
        isLoading: false,
        error: null,
      ));
      await _persistState();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to check token status: $e',
      ));
    }
  }

  Future<void> _onCheckConnectionValidity(
      SyncCheckConnectionValidity event, Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      await _syncRepository.checkConnectionValidity();

      emit(state.copyWith(
        isLoading: false,
        error: null,
      ));
      await _persistState();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to check connection validity: $e',
      ));
    }
  }

  Future<void> _onRestoreState(
      SyncRestoreState event, Emitter<SyncState> emit) async {
    await _restorePersistedState(emit);
  }

  List<SSDPServiceInfo> _upsertRecentConnection({
    required SSDPServiceInfo service,
    int maxItems = 5,
  }) {
    final List<SSDPServiceInfo> list = List.of(_loadRecentFromPrefs());
    list.removeWhere((s) =>
        (s.serverAddress == service.serverAddress &&
            s.serverPort == service.serverPort) ||
        s.id == service.id);
    list.insert(0, service);
    if (list.length > maxItems) list.removeRange(maxItems, list.length);
    return list;
  }

  List<SSDPServiceInfo> _loadRecentFromPrefs() {
    try {
      final raw = _prefs.getString(_persistKey);
      if (raw == null) return [];
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final list =
          (map['recentConnections'] as List?)?.cast<Map<String, dynamic>>() ??
              [];
      return list.map((e) => SSDPServiceInfo.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _persistState({List<SSDPServiceInfo>? recentConnections}) async {
    try {
      final data = <String, dynamic>{
        'syncStatus': state.syncStatus.name,
        'connectedService': state.connectedService?.toJson(),
        'lastDiscoveryTime': state.lastDiscoveryTime?.toIso8601String(),
        'lastSyncTime': state.lastSyncTime?.toIso8601String(),
        'discoveredServices':
            state.discoveredServices.map((e) => e.toJson()).toList(),
        'recentConnections': (recentConnections ?? state.recentConnections)
            .map((e) => e.toJson())
            .toList(),
      };
      await _prefs.setString(_persistKey, jsonEncode(data));
    } catch (_) {}
  }

  Future<void> _restorePersistedState(Emitter<SyncState> emit) async {
    try {
      final raw = _prefs.getString(_persistKey);
      if (raw == null) return;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final persistedStatus = switch (map['syncStatus'] as String?) {
        'connecting' => SyncStatus.connecting,
        'connected' => SyncStatus.connected,
        'syncing' => SyncStatus.syncing,
        'error' => SyncStatus.error,
        _ => SyncStatus.disconnected,
      };
      final connectedServiceMap =
          map['connectedService'] as Map<String, dynamic>?;
      final discovered =
          (map['discoveredServices'] as List?)?.cast<Map<String, dynamic>>() ??
              [];
      final recent =
          (map['recentConnections'] as List?)?.cast<Map<String, dynamic>>() ??
              [];

      emit(state.copyWith(
        isLoading: false,
        isDiscovering: false,
        syncStatus: persistedStatus,
        connectedService: connectedServiceMap != null
            ? SSDPServiceInfo.fromJson(connectedServiceMap)
            : null,
        lastDiscoveryTime: (map['lastDiscoveryTime'] as String?) != null
            ? DateTime.tryParse(map['lastDiscoveryTime'] as String)
            : null,
        lastSyncTime: (map['lastSyncTime'] as String?) != null
            ? DateTime.tryParse(map['lastSyncTime'] as String)
            : null,
        discoveredServices:
            discovered.map((e) => SSDPServiceInfo.fromJson(e)).toList(),
        recentConnections:
            recent.map((e) => SSDPServiceInfo.fromJson(e)).toList(),
      ));
    } catch (_) {}
  }
}
