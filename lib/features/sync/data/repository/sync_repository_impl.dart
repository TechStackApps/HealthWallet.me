import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_bundle.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/services/sync_token_service.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/exceptions/sync_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';

@Injectable(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final FhirApiService _fhirApiService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final SyncTokenService _syncTokenService;

  SyncRepositoryImpl(
    this._fhirApiService,
    this._fhirLocalDataSource,
    this._syncTokenService,
  );

  @override
  Future<void> syncData() async {
    try {
      // Check if we have a valid token
      final currentToken = await _syncTokenService.getCurrentToken();
      if (currentToken == null) {
        // Try to get a new token through initiation
        final initiationResponse = await _fhirApiService.initiateSync();
        final data = initiationResponse.data?['data'] as Map<String, dynamic>?;

        if (data != null) {
          final token = await _syncTokenService.createTokenFromSyncData(data);
          await _syncTokenService.saveToken(token);
          await _sync(token.token, token.address, token.port);
        }
      } else {
        // Use existing token
        await _sync(
            currentToken.token, currentToken.address, currentToken.port);
      }
    } catch (e, s) {
      logger.e('Error in syncData: $e', e, s);
      rethrow;
    }
  }

  @override
  Future<void> syncDataWithJson(String jsonData) async {
    try {
      logger.d('--- Sync Data with JSON ---');
      logger.d('Received JSON data: $jsonData');
      final decodedData = jsonDecode(jsonData);

      // Check if this is server connection data (has token and port)
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('token') &&
          decodedData.containsKey('port')) {
        // Handle server connection data
        final token =
            await _syncTokenService.createTokenFromSyncData(decodedData);
        await _syncTokenService.saveToken(token);

        logger.d('Processing server connection data');
        logger.d('Token: ${token.token}');
        logger.d('Address: ${token.address}');
        logger.d('Port: ${token.port}');

        await _sync(token.token, token.address, token.port);
      } else {
        throw Exception(
            'Invalid JSON format. Expected either server connection data (token, port) or FHIR Bundle (resourceType: Bundle)');
      }
    } catch (e, s) {
      logger.e('Error in syncDataWithJson: $e', e, s);
      rethrow;
    }
  }

  Future<void> _sync(String token, String address, String port) async {
    final currentToken = await _syncTokenService.getCurrentToken();
    if (currentToken == null) {
      throw Exception('No valid token available');
    }

    // Try all available addresses for the token
    final addressesToTry = currentToken.allAddresses;
    Exception? lastException;

    for (final serverAddress in addressesToTry) {
      try {
        final dio = Dio(
          BaseOptions(
            baseUrl: 'http://$serverAddress/api',
            headers: {'Authorization': 'Bearer $token'},
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 60),
            sendTimeout: const Duration(seconds: 30),
          ),
        );

        final tempApiService = FhirApiService(dio);
        final lastSyncTimestamp =
            await _fhirLocalDataSource.getLastSyncTimestamp();

        FhirBundle bundle;
        // First, validate server connection
        await _validateServerConnection(
            dio, serverAddress.split(':')[0], serverAddress.split(':')[1]);

        if (lastSyncTimestamp != null) {
          logger.d('Syncing updates since: $lastSyncTimestamp');
          bundle = await tempApiService.syncDataUpdates(lastSyncTimestamp);
        } else {
          logger.d('Full sync - no previous sync timestamp');
          bundle = await tempApiService.syncData();
        }

        final populatedEntries = bundle.entry.map(
          (entry) {
            BundleEntry populatedEntry = entry.copyWith(
              resource: entry.resource
                  .populateEncounterIdFromRaw()
                  .populateSubjectIdFromRaw(),
            );
            return populatedEntry;
          },
        ).toList();
        FhirBundle newBundle = bundle.copyWith(entry: populatedEntries);

        _fhirLocalDataSource.cacheFhirResources(
            newBundle.entry.map((entry) => entry.resource).toList());
      } on DioException catch (e, s) {
        logger.e('⛔ Error during sync with $serverAddress: ${e.message}', e, s);
        lastException =
            SyncException(_getUserFriendlyErrorMessage(e, serverAddress), e);

        // Continue to next address if this one failed
        continue;
      } catch (e, s) {
        logger.e('⛔ Error in syncData with $serverAddress: $e', e, s);
        lastException = e as Exception;
        continue;
      }
    }

    // If we get here, all addresses failed
    if (lastException != null) {
      throw lastException;
    }

    throw Exception('All server addresses failed to connect');
  }

  Future<void> _validateServerConnection(
      Dio dio, String address, String port) async {
    try {
      logger.d('🔍 Validating server connection to $address:$port');

      // Try to reach the server status endpoint first
      final response = await dio.get('/secure/sync/status');

      if (response.statusCode == 200) {
        logger.d('✅ Server connection validated successfully');
        final data = response.data;
        if (data['success'] == true) {
          final serverInfo = data['data']?['serverInfo'];
          if (serverInfo != null) {
            logger.d(
                '📊 Server info: ${serverInfo['name']} v${serverInfo['version']}');
            if (serverInfo['docker'] == true) {
              logger.d('🐳 Server is running in Docker');
            }
          }
        }
      } else {
        throw Exception(
            'Server status check failed with code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('❌ Server validation failed: ${e.message}');
      // Let the main sync method handle the DioException with proper error messages
      rethrow;
    } catch (e) {
      logger.e('❌ Server validation failed: $e');
      throw Exception('Failed to validate server connection: $e');
    }
  }

  String _getUserFriendlyErrorMessage(DioException e, String serverAddress) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. The server at $serverAddress is not responding. Please check if the server is running and try again.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Failed to send data to server $serverAddress.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Server $serverAddress is taking too long to respond.';
      case DioExceptionType.connectionError:
        if (e.message?.contains('Connection refused') ?? false) {
          return 'Connection refused. The server at $serverAddress is not running or not accessible. Please check the server status and connection details.';
        } else if (e.message?.contains('Network is unreachable') ?? false) {
          return 'Network is unreachable. Please check your internet connection and server address.';
        } else {
          return 'Connection error. Cannot connect to server at $serverAddress. Please verify the server is running and the address is correct.';
        }
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 401:
            return 'Authentication failed. Your sync token may have expired. Please generate a new QR code.';
          case 403:
            return 'Access denied. You do not have permission to sync with this server.';
          case 404:
            return 'Server endpoint not found. The sync API may not be available on this server.';
          case 429:
            return 'Rate limit exceeded. Please wait a moment before trying to sync again.';
          case 500:
            return 'Server error. The server encountered an internal error. Please try again later.';
          case 503:
            return 'Service unavailable. The server is temporarily down for maintenance.';
          default:
            return 'Server returned error ${statusCode}. Please check the server status and try again.';
        }
      case DioExceptionType.cancel:
        return 'Sync was cancelled.';
      case DioExceptionType.unknown:
      default:
        return 'An unexpected error occurred while syncing. Please check your connection and try again.';
    }
  }

  @override
  Future<List<entity.Source>> getSources() async {
    final sources = await _fhirLocalDataSource.getSources();
    return sources
        .map(
          (e) => entity.Source(
            id: e.id,
            name: e.name ?? '',
            logo: e.logo,
          ),
        )
        .toList();
  }

  @override
  Future<void> checkConnection(String token) async {
    try {
      final currentToken = await _syncTokenService.getCurrentToken();
      if (currentToken == null) {
        throw SyncException('No token available.');
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: 'http://${currentToken.address}:${currentToken.port}/api',
          headers: {'Authorization': 'Bearer ${currentToken.token}'},
        ),
      );

      await _validateServerConnection(
          dio, currentToken.address, currentToken.port);
    } on DioException catch (e) {
      throw SyncException('Connection check failed: ${e.message}', e);
    } catch (e) {
      throw SyncException(
          'An unexpected error occurred during connection check.',
          e as Exception?);
    }
  }

  @override
  Future<ConnectionStatus> checkConnectionValidity() async {
    logger.d('Checking connection validity...');
    final currentToken = await _syncTokenService.getCurrentToken();
    if (currentToken == null) {
      logger.w('No current token found, connection is not valid.');
      return ConnectionStatus.invalidToken;
    }
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://${currentToken.address}:${currentToken.port}/api',
        headers: {'Authorization': 'Bearer ${currentToken.token}'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );
    final tempApiService = FhirApiService(dio);
    try {
      final response = await tempApiService.ping();
      if (response.statusCode == 200) {
        logger.i('Connection is valid.');
        return ConnectionStatus.valid;
      } else {
        logger.w(
            'Connection check failed with status code: ${response.statusCode}');
        return ConnectionStatus.serverDown;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        logger.w('Connection check failed with 401, token is likely expired.');
        return ConnectionStatus.invalidToken;
      } else {
        logger.e('Connection check failed with DioException: ${e.message}');
        return ConnectionStatus.serverDown;
      }
    } catch (e) {
      logger.e('An unexpected error occurred during connection check: $e');
      return ConnectionStatus.serverDown;
    }
  }
}
