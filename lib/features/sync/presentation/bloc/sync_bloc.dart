import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';
import 'package:health_wallet/features/sync/domain/services/sync_token_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Added for jsonDecode

part 'sync_bloc.freezed.dart';
part 'sync_event.dart';
part 'sync_state.dart';

@injectable
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final FhirRepository _fhirRepository;
  final SyncTokenService _syncTokenService;
  final SharedPreferences _prefs;

  SyncBloc(
    this._fhirRepository,
    this._syncTokenService,
    this._prefs,
  ) : super(const SyncState()) {
    on<SyncEvent>((event, emit) async {
      await event.when(
        syncData: () => _onSyncData(emit),
        syncDataWithJson: (jsonData) => _onSyncDataWithJson(jsonData, emit),
        historyLoaded: () => _onHistoryLoaded(emit),
        tokenStatusLoaded: () => _onTokenStatusLoaded(emit),
        tokenRevoked: (tokenId) => _onTokenRevoked(emit, tokenId),
        checkTokenStatus: () => _onCheckTokenStatus(emit),
        checkConnectionValidity: () => _onCheckConnectionValidity(emit),
      );
    });
  }

  Future<void> _onSyncData(Emitter<SyncState> emit) async {
    emit(state.copyWith(status: const SyncStatus.loading()));
    try {
      await _fhirRepository.syncData();
      await _addSyncTimeToHistory();
      emit(state.copyWith(
        status: const SyncStatus.success(),
        history: _getSyncHistory(),
      ));
      add(const SyncEvent.checkConnectionValidity());
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

      // Check if this was a token setup and save it
      await _handleTokenFromJsonData(jsonData);

      emit(state.copyWith(
        status: const SyncStatus.success(),
        history: _getSyncHistory(),
      ));
    } catch (e) {
      emit(state.copyWith(status: SyncStatus.failure(e.toString())));
    }
  }

  Future<void> _onHistoryLoaded(Emitter<SyncState> emit) async {
    emit(state.copyWith(history: _getSyncHistory()));
  }

  Future<void> _onTokenStatusLoaded(Emitter<SyncState> emit) async {
    try {
      final token = await _syncTokenService.getCurrentToken();
      emit(state.copyWith(
        currentToken: token,
        tokenStatus: _getTokenStatus(token),
      ));
    } catch (e) {
      emit(state.copyWith(
        currentToken: null,
        tokenStatus: const SyncTokenStatus.none(),
      ));
    }
  }

  Future<void> _onTokenRevoked(Emitter<SyncState> emit, String? tokenId) async {
    try {
      await _syncTokenService.revokeToken(tokenId: tokenId);

      // If no specific tokenId was provided or it was the current token, clear current token
      if (tokenId == null || state.currentToken?.tokenId == tokenId) {
        emit(state.copyWith(
          currentToken: null,
          tokenStatus: const SyncTokenStatus.none(),
        ));
      } else {
        // Just refresh the token status if a different token was revoked
        await _onTokenStatusLoaded(emit);
      }
    } catch (e) {
      emit(state.copyWith(status: SyncStatus.failure(e.toString())));
    }
  }

  Future<void> _onCheckTokenStatus(Emitter<SyncState> emit) async {
    try {
      await _syncTokenService.clearExpiredTokens();
      final token = await _syncTokenService.getCurrentToken();
      emit(state.copyWith(
        currentToken: token,
        tokenStatus: _getTokenStatus(token),
      ));
    } catch (e) {
      emit(state.copyWith(
        currentToken: null,
        tokenStatus: const SyncTokenStatus.none(),
      ));
    }
  }

  Future<void> _onCheckConnectionValidity(Emitter<SyncState> emit) async {
    try {
      final status = await _syncTokenService.checkConnectionValidity();
      switch (status) {
        case ConnectionStatus.valid:
          emit(state.copyWith(
              connectionValid: true, status: const SyncStatus.connected()));
          break;
        case ConnectionStatus.invalidToken:
          emit(state.copyWith(
              connectionValid: false,
              tokenStatus: const SyncTokenStatus.expired()));
          break;
        case ConnectionStatus.serverDown:
          // Try to reconnect automatically when server is down
          final reconnected = await _syncTokenService.attemptReconnection();
          if (reconnected) {
            emit(state.copyWith(
                connectionValid: true, status: const SyncStatus.connected()));
          } else {
            emit(state.copyWith(
                connectionValid: false,
                status: const SyncStatus.failure(
                    'Server is down - try updating server address')));
          }
          break;
      }
    } catch (e) {
      emit(state.copyWith(
          connectionValid: false, status: SyncStatus.failure(e.toString())));
    }
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

  Future<void> _handleTokenFromJsonData(String jsonData) async {
    try {
      final decodedData = await _parseJsonData(jsonData);

      // Check if this is server connection data (has token and port)
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('token') &&
          decodedData.containsKey('port')) {
        final token =
            await _syncTokenService.createTokenFromSyncData(decodedData);
        await _syncTokenService.saveToken(token);
      }
    } catch (e) {
      // If we can't parse or save the token, continue without error
      // The sync operation itself may still succeed
    }
  }

  Future<dynamic> _parseJsonData(String jsonData) async {
    try {
      return jsonDecode(jsonData);
    } catch (e) {
      throw Exception('Invalid JSON data: $e');
    }
  }

  SyncTokenStatus _getTokenStatus(SyncToken? token) {
    if (token == null) {
      return const SyncTokenStatus.none();
    }

    if (token.isExpired) {
      return const SyncTokenStatus.expired();
    }

    if (token.isExpiringSoon) {
      return const SyncTokenStatus.expiringSoon();
    }

    return const SyncTokenStatus.active();
  }
}
