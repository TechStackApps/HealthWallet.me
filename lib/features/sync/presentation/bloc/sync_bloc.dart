import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/data/services/jwt_service.dart';

import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/services/token_service.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final FhirApiService _fhirApiService;
  final SyncRepository _syncRepository;
  final SharedPreferences _prefs;
  final TokenService _tokenService;
  final RecordsRepository _recordsRepository;

  static const String _persistKey = 'sync_persisted_state_v1';

  // Prevent overlapping connection attempts
  bool _isConnecting = false;

  // Helper methods for token validation
  bool _isTokenValid(SyncToken token) {
    return token.isActive && JwtService.isValid(token.token);
  }

  String _getTokenExpirationDescription(SyncToken token) {
    return JwtService.getExpirationDescription(token.token);
  }

  /// Public method to get token expiration description for UI
  String getTokenExpirationDescription() {
    if (state.syncToken == null) return 'No token';
    return _getTokenExpirationDescription(state.syncToken!);
  }

  /// Public method to check if current token is valid
  bool isCurrentTokenValid() {
    if (state.syncToken == null) return false;
    return _isTokenValid(state.syncToken!);
  }

  SyncBloc(
    this._fhirApiService,
    this._syncRepository,
    this._prefs,
    this._tokenService,
    this._recordsRepository,
  ) : super(const SyncState()) {
    on<SyncData>(_onSyncData);
    on<SyncClearError>(_onClearError);
    on<SyncClearSuccess>(_onClearSuccess);
    on<SyncRestoreState>(_onRestoreState);

    // QR Code Sync events
    on<SyncScanQRCode>(_onScanQRCode);
    on<SyncProcessQRCode>(_onProcessQRCode);
    on<SyncConnectWithQR>(_onConnectWithQR);
    on<SyncDisconnectQR>(_onDisconnectQR);
    on<SyncClearToken>(_onClearToken);
    on<SyncResetStatus>(_onResetStatus);
    on<SyncCancelQRScanning>(_onCancelQRScanning);
    on<SyncLoadDemoData>(_onLoadDemoData);
    on<SyncDataCompleted>(_onDataCompleted);
    on<OnboardingOverlayTriggered>(_onOnboardingOverlayTriggered);
    on<SyncResetOnboarding>(_onResetOnboarding);

    add(const SyncRestoreState());
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onSyncData(SyncData event, Emitter<SyncState> emit) async {
    try {
      if (state.syncToken == null) {
        throw Exception('No sync token available');
      }

      if (!_isTokenValid(state.syncToken!)) {
        throw Exception('Sync token is invalid or expired');
      }

      logger.d('🚀 Starting data sync...');
      logger.d('🌐 Server: ${state.syncToken!.baseUrl}');
      logger.d('🔑 Token: ${state.syncToken!.token.substring(0, 20)}...');

      emit(state.copyWith(
        isLoading: true,
        error: null,
        syncStatus: SyncStatus.syncing,
      ));

      // Use background sync for better performance with large datasets
      logger.d('🚀 Starting background sync...');

      // Check if background sync is already running
      final isRunning = await _syncRepository.isBackgroundSyncRunning();
      if (isRunning) {
        logger.w('⚠️ Background sync already running');
        emit(state.copyWith(
          isLoading: false,
          syncStatus: SyncStatus.syncing,
          successMessage: 'Background sync is already in progress',
        ));
        return;
      }

      // Start background sync with the working base URL
      if (state.workingBaseUrl == null) {
        logger.w('⚠️ No working base URL found. User must connect first.');
        emit(state.copyWith(
          isLoading: false,
          syncStatus: SyncStatus.error,
          error:
              'Please connect to the server first by clicking the "Connect" button, then try syncing again.',
        ));
        return;
      }

      // Pre-check server health before attempting sync
      logger.d(
          '🏥 Checking server health before sync at: ${state.workingBaseUrl}');
      final isHealthy =
          await _tokenService.checkServerHealth(baseUrl: state.workingBaseUrl!);
      if (!isHealthy) {
        logger.e('❌ Server health check failed. Disconnecting.');
        emit(state.copyWith(
          isLoading: false,
          syncStatus: SyncStatus.disconnected,
          workingBaseUrl: null,
          error:
              'Fasten server is unavailable. Please ensure the server is running and try again.',
        ));
        await _persistState();
        return;
      }

      // Clear demo data when starting real sync
      try {
        logger.d('🧹 Clearing demo data before real sync...');
        await _recordsRepository.clearDemoData();
        logger.d('✅ Demo data cleared successfully');
      } catch (e) {
        logger.w('⚠️ Failed to clear demo data: $e');
        // Don't fail the sync if demo data clearing fails
      }

      // Fetch user information before starting the sync
      String? serverUsername;
      String? serverUserEmail;
      try {
        logger.d('👤 Fetching user information before sync...');
        _fhirApiService.updateBaseUrl(state.workingBaseUrl!);
        _fhirApiService.updateAuthorizationToken(state.syncToken!.token);
        final userDto = await _fhirApiService.fetchCurrentUser();
        if (userDto != null) {
          logger.d('✅ User info fetched: ${userDto['username']}');
          serverUsername = userDto['full_name'] ?? userDto['username'];
          serverUserEmail = userDto['email'];
        } else {
          logger.w('⚠️ Could not fetch user information from server');
        }
      } catch (e) {
        logger.w('⚠️ Failed to fetch user info before sync: $e');
        // Don't fail the sync if user info fetch fails
      }

      await _syncRepository.startBackgroundSync(
          workingBaseUrl: state.workingBaseUrl);

      // Background sync completed successfully (it's synchronous now)
      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.synced,
        lastSyncTime: DateTime.now(),
        serverUsername: serverUsername,
        serverUserEmail: serverUserEmail,
        successMessage: 'Background sync completed successfully!',
        hasSyncData: true,
      ));

      add(SyncDataCompleted(
        sourceId: 'sync',
        isSuccess: true,
      ));

      // Auto-reset status to connected after 5 seconds
      Timer(const Duration(seconds: 5), () {
        if (state.syncStatus == SyncStatus.synced) {
          add(const SyncResetStatus());
        }
      });

      await _persistState();
    } catch (e, stackTrace) {
      logger.e('❌ Data sync failed: $e');
      logger.e('🔍 Error type: ${e.runtimeType}');
      logger.e('📚 Stack trace: $stackTrace');

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
      } else {
        errorMessage = 'Data sync failed: $e';
      }

      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.error,
        error: errorMessage,
      ));
    }
  }

  void _onClearError(SyncClearError event, Emitter<SyncState> emit) {
    emit(state.copyWith(error: null, qrError: null));
  }

  void _onClearSuccess(SyncClearSuccess event, Emitter<SyncState> emit) {
    emit(state.copyWith(successMessage: null));
  }

  Future<void> _onRestoreState(
      SyncRestoreState event, Emitter<SyncState> emit) async {
    await _restorePersistedState(emit);
  }

  Future<void> _persistState() async {
    try {
      final data = <String, dynamic>{
        'syncStatus': state.syncStatus.name,
        'lastSyncTime': state.lastSyncTime?.toIso8601String(),
        'syncToken': state.syncToken?.toJson(),
        'workingBaseUrl': state.workingBaseUrl,
        'serverUsername': state.serverUsername,
        'serverUserEmail': state.serverUserEmail,
        // Don't persist success message - it should be transient
      };
      logger.d('💾 Persisting sync state...');
      logger.d('📊 Status: ${state.syncStatus.name}');
      logger.d('📅 Last sync: ${state.lastSyncTime?.toIso8601String()}');
      logger.d('⚙️ SyncToken: ${state.syncToken != null ? 'Yes' : 'No'}');
      await _prefs.setString(_persistKey, jsonEncode(data));
      logger.d('✅ State persisted successfully');
    } catch (e) {
      logger.e('❌ Failed to persist state: $e');
    }
  }

  Future<void> _restorePersistedState(Emitter<SyncState> emit) async {
    try {
      logger.d('🔄 Restoring persisted sync state...');
      final raw = _prefs.getString(_persistKey);
      if (raw == null) {
        logger.d('📭 No persisted state found');
        return;
      }
      logger.d('📄 Found persisted state: $raw');
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final persistedStatus = switch (map['syncStatus'] as String?) {
        'connecting' => SyncStatus
            .disconnected, // Reset connecting state to avoid getting stuck
        'connected' => SyncStatus.connected,
        'syncing' => SyncStatus.syncing,
        'synced' => SyncStatus.synced,
        'error' => SyncStatus.error,
        _ => SyncStatus.disconnected,
      };

      final syncTokenMap = map['syncToken'] as Map<String, dynamic>?;
      SyncToken? syncToken;
      if (syncTokenMap != null) {
        try {
          syncToken = SyncToken.fromJson(syncTokenMap);
          logger.d('✅ SyncToken restored successfully');
        } catch (e) {
          logger.e('❌ Failed to restore SyncToken: $e');
          syncToken = null;
        }
      } else {
        logger.d('📭 No SyncToken to restore');
      }

      final workingBaseUrl = map['workingBaseUrl'] as String?;

      // Reset working base URL if we were in connecting state (might be wrong protocol)
      final finalWorkingBaseUrl = (map['syncStatus'] as String?) == 'connecting'
          ? null
          : workingBaseUrl;

      // Restore user information
      final serverUsername = map['serverUsername'] as String?;
      final serverUserEmail = map['serverUserEmail'] as String?;

      logger.d('📊 Restored sync status: $persistedStatus');
      logger.d('📅 Restored last sync time: ${map['lastSyncTime']}');
      logger.d('⚙️ Restored SyncToken: ${syncToken != null ? 'Yes' : 'No'}');
      logger
          .d('🌐 Restored working base URL: ${finalWorkingBaseUrl ?? 'None'}');
      logger.d('👤 Restored username: ${serverUsername ?? 'None'}');
      logger.d('📧 Restored email: ${serverUserEmail ?? 'None'}');

      emit(state.copyWith(
        isLoading: false,
        syncStatus: persistedStatus,
        lastSyncTime: (map['lastSyncTime'] as String?) != null
            ? DateTime.tryParse(map['lastSyncTime'] as String)
            : null,
        syncToken: syncToken,
        workingBaseUrl: finalWorkingBaseUrl,
        serverUsername: serverUsername,
        serverUserEmail: serverUserEmail,
        successMessage: null,
        hasSyncData: syncToken != null && map['lastSyncTime'] != null,
      ));

      logger.d('✅ State restoration completed');

      // Reset connection flag to avoid getting stuck
      _isConnecting = false;
    } catch (_) {
      _isConnecting = false;
    }
  }

  // QR Code Sync Event Handlers

  Future<void> _onScanQRCode(
      SyncScanQRCode event, Emitter<SyncState> emit) async {
    emit(state.copyWith(
      isQRScanning: true,
      qrError: null,
    ));
  }

  Future<void> _onProcessQRCode(
      SyncProcessQRCode event, Emitter<SyncState> emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        qrError: null,
      ));

      try {
        final qrData = jsonDecode(event.qrData) as Map<String, dynamic>;
        final syncToken = SyncToken.fromQRData(qrData);

        // Validate the token
        if (syncToken.isExpired) {
          emit(state.copyWith(
            isLoading: false,
            qrError: 'QR code configuration is expired',
          ));
          return;
        }

        // Save the token
        await _tokenService.saveToken(syncToken);

        logger.d('✅ SyncToken created and saved successfully');
        logger.d('🔑 Token ID: ${syncToken.tokenId}');
        logger.d('🌐 Server: ${syncToken.address}:${syncToken.port}');
        logger.d('🔗 Base URL: ${syncToken.baseUrl}');

        // Store in state for UI (we can now use SyncToken directly)
        emit(state.copyWith(
          isLoading: false,
          syncToken: syncToken, // Use the unified SyncToken
          isQRScanning: false,
        ));
      } catch (e) {
        logger.e('❌ Failed to parse QR code or create SyncToken: $e');
        emit(state.copyWith(
          isLoading: false,
          qrError: 'Invalid QR code format: $e',
        ));
        return;
      }

      // Persist the state after storing QR config
      await _persistState();

      // Don't auto-connect - let user manually connect
      logger.d('✅ QR code parsed successfully. Ready to connect.');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        qrError: 'QR error: $e',
      ));
    }
  }

  Future<void> _onConnectWithQR(
      SyncConnectWithQR event, Emitter<SyncState> emit) async {
    try {
      // Prevent multiple simultaneous connection attempts
      if (_isConnecting ||
          state.isLoading ||
          state.syncStatus == SyncStatus.connecting) {
        logger
            .w('⚠️ Connection already in progress, ignoring duplicate request');
        return;
      }
      _isConnecting = true;

      if (state.syncToken == null) {
        emit(state.copyWith(
          qrError: 'No sync token available',
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: true,
        syncStatus: SyncStatus.connecting,
        qrError: null,
      ));

      String? workingBaseUrl;
      final allAddresses = state.syncToken!.allAddresses;
      logger.d('🔍 Available addresses: $allAddresses');

      for (int i = 0; i < allAddresses.length; i++) {
        final address = allAddresses[i];
        final parts = address.split(':');
        final host = parts[0];
        final originalPort = parts.length > 1 ? parts[1] : '8080';

        // Try original port first, then common Fasten ports
        final portsToTry = <String>{originalPort, '9090', '8080'}.toList();

        bool foundWorking = false;
        for (final port in portsToTry) {
          final httpsUrl = '${state.syncToken!.protocol}://$host:$port';
          final httpUrl = httpsUrl.replaceFirst('https://', 'http://');

          logger.d('🏥 Checking [$i:$port] HTTPS: $httpsUrl');
          if (await _tokenService.checkServerHealth(baseUrl: httpsUrl)) {
            logger.d('✅ HTTPS OK [$i:$port]: $httpsUrl');
            workingBaseUrl = httpsUrl;
            foundWorking = true;
            break;
          }

          logger.w('❌ HTTPS failed [$i:$port], trying HTTP: $httpUrl');
          if (await _tokenService.checkServerHealth(baseUrl: httpUrl)) {
            logger.d('✅ HTTP OK [$i:$port]: $httpUrl');
            workingBaseUrl = httpUrl;
            foundWorking = true;
            break;
          }

          logger.e('❌ Both failed [$i:$port]: $host:$port');
        }

        if (foundWorking) break;
      }

      if (workingBaseUrl == null) {
        logger.e('❌ All connection attempts failed');
        emit(state.copyWith(
          isLoading: false,
          syncStatus: SyncStatus.error,
          qrError:
              'Cannot connect to server. Tried all addresses: ${allAddresses.join(', ')}',
        ));
        _isConnecting = false;
        return;
      }

      // Persist the chosen URL immediately for consistency across retries/UI
      emit(state.copyWith(workingBaseUrl: workingBaseUrl));
      await _persistState();
      logger.d('🌐 Using working base URL: $workingBaseUrl');

      // Validate the token using the working base URL
      logger.d('🔑 Validating token...');
      logger.d('🌐 Using base URL: $workingBaseUrl');

      // Construct the endpoint URL using the working base URL, not the original token URL
      final accessTokensEndpoint =
          '${state.syncToken!.endpoints['accessTokens']}';
      logger.d('🔗 Endpoint path: $accessTokensEndpoint');
      logger.d('🔑 Token: ${state.syncToken!.token.substring(0, 20)}...');

      final tokenValid = await _tokenService.validateToken(
        baseUrl: workingBaseUrl,
        token: state.syncToken!.token,
        endpoint: accessTokensEndpoint,
      );

      if (!tokenValid) {
        logger.e('❌ Token validation failed');
        emit(state.copyWith(
          isLoading: false,
          syncStatus: SyncStatus.error,
          qrError: 'Invalid or expired token',
        ));
        return;
      }
      logger.d('✅ Token validation successful');

      // Fetch user information from the server
      String? serverUsername;
      String? serverUserEmail;
      try {
        logger.d('👤 Fetching user information...');
        // Update the API service base URL before making the call
        _fhirApiService.updateBaseUrl(workingBaseUrl);
        _fhirApiService.updateAuthorizationToken(state.syncToken!.token);
        final userDto = await _fhirApiService.fetchCurrentUser();
        if (userDto != null) {
          logger.d('✅ User info fetched: ${userDto['username']}');
          serverUsername = userDto['full_name'] ?? userDto['username'];
          serverUserEmail = userDto['email'];
        } else {
          logger.w('⚠️ Could not fetch user information from server');
        }
      } catch (e) {
        logger.w('⚠️ Failed to fetch user info: $e');
      }

      // Connection successful
      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.connected,
        workingBaseUrl: workingBaseUrl,
        lastSyncTime: DateTime.now(),
        serverUsername: serverUsername,
        serverUserEmail: serverUserEmail,
      ));

      // Persist the connected state
      await _persistState();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        syncStatus: SyncStatus.error,
        qrError: 'Connection failed: $e',
      ));
    } finally {
      _isConnecting = false;
    }
  }

  Future<void> _onDisconnectQR(
      SyncDisconnectQR event, Emitter<SyncState> emit) async {
    logger.d('🔌 Disconnecting from QR sync...');

    // Reset connection flag
    _isConnecting = false;

    // Only disconnect, don't clear the token
    emit(state.copyWith(
      syncStatus: SyncStatus.disconnected,
      workingBaseUrl: null, // Clear working base URL
      qrConnectionTestResult: null,
      qrError: null,
      successMessage: null,
      hasSyncData: false,
    ));

    // Persist the disconnected state
    await _persistState();
    logger.d('✅ Disconnected (token preserved)');
  }

  Future<void> _onClearToken(
      SyncClearToken event, Emitter<SyncState> emit) async {
    logger.d('🗑️ Clearing QR token and all sync data...');

    // Reset connection flag
    _isConnecting = false;

    emit(state.copyWith(
      syncStatus: SyncStatus.disconnected,
      syncToken: null,
      workingBaseUrl: null,
      qrConnectionTestResult: null,
      qrError: null,
      successMessage: null,
      lastSyncTime: null,
      hasSyncData: false, // Reset sync data flag when token is cleared
    ));

    // Persist the cleared state
    await _persistState();
    logger.d('✅ Token cleared and state reset');
  }

  Future<void> _onResetStatus(
      SyncResetStatus event, Emitter<SyncState> emit) async {
    logger.d('🔄 Resetting sync status to connected...');
    emit(state.copyWith(
      syncStatus: SyncStatus.connected,
      error: null,
      qrError: null,
      successMessage: null,
      hasSyncData: false, // Reset sync data flag when resetting status
    ));
    await _persistState();
  }

  Future<void> _onCancelQRScanning(
      SyncCancelQRScanning event, Emitter<SyncState> emit) async {
    logger.d('🛑 Canceling QR scanning...');
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

      add(SyncDataCompleted(
        sourceId: 'demo',
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
        sourceId: 'demo',
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
      if (event.sourceId == 'demo') {
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
