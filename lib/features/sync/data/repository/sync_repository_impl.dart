import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fhir_r4/fhir_r4.dart' hide BundleEntry;
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
import 'package:health_wallet/features/user/data/mapper/user_mapper.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';

@Injectable(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final FhirApiService _fhirApiService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final SyncTokenService _syncTokenService;
  final UserRepository _userRepository;

  SyncRepositoryImpl(
    this._fhirApiService,
    this._fhirLocalDataSource,
    this._syncTokenService,
    this._userRepository,
  );

  @override
  Future<void> syncData() async {
    try {
      // Check if we have a valid token
      final currentToken = await _syncTokenService.getCurrentToken();
      if (currentToken == null) {
        // No token available - this should not happen in the normal flow
        // since we get tokens from the mobile sync endpoint
        throw Exception(
            'No valid token available. Please connect to a service first.');
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

      // Check if this is server connection data (has token and server info)
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('token') &&
          decodedData.containsKey('server')) {
        // Handle server connection data
        final token =
            await _syncTokenService.createTokenFromSyncData(decodedData);
        await _syncTokenService.saveToken(token);

        logger.d('Processing server connection data');
        logger.d('Token: ${token.token}');
        logger.d('Address: ${token.address}');
        logger.d('Port: ${token.port}');

        await _sync(token.token, token.address, token.port);
      } else if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('resourceType') &&
          decodedData['resourceType'] == 'Bundle') {
        // Handle FHIR Bundle data directly
        final bundle = FhirBundle.fromJson(decodedData);
        final resourcesToCache =
            bundle.entry.map((entry) => entry.resource).toList();
        _fhirLocalDataSource.cacheFhirResources(resourcesToCache);
        await _fhirLocalDataSource
            .setLastSyncTimestamp(DateTime.now().toIso8601String());
      } else {
        throw Exception(
            'Invalid JSON format. Expected either server connection data (token, server) or FHIR Bundle (resourceType: Bundle)');
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

        // Always do full sync since the updates endpoint doesn't exist on the server
        logger.d('Full sync - updates endpoint not available on server');
        bundle = await tempApiService.syncData();

        try {
          final populatedEntries = bundle.entry.map(
            (entry) {
              try {
                BundleEntry populatedEntry = entry.copyWith(
                  resource: entry.resource
                      .populateEncounterIdFromRaw()
                      .populateSubjectIdFromRaw(),
                );
                return populatedEntry;
              } catch (e) {
                logger
                    .e('⚠️ Error processing resource ${entry.resource.id}: $e');
                // Return the original entry if processing fails
                return entry;
              }
            },
          ).toList();
          FhirBundle newBundle = bundle.copyWith(entry: populatedEntries);

          final resourcesToCache =
              newBundle.entry.map((entry) => entry.resource).toList();

          _fhirLocalDataSource.cacheFhirResources(resourcesToCache);
        } catch (e) {
          logger.e(
              '⚠️ Error processing FHIR bundle, attempting to cache raw resources: $e');
          // Fallback: try to cache the raw resources without processing
          try {
            final resourcesToCache =
                bundle.entry.map((entry) => entry.resource).toList();
            _fhirLocalDataSource.cacheFhirResources(resourcesToCache);
          } catch (fallbackError) {
            logger.e('❌ Failed to cache even raw resources: $fallbackError');
            throw Exception('Failed to process and cache FHIR resources: $e');
          }
        }

        // Try to fetch user info, but don't fail if it doesn't work
        try {
          await _fetchAndUpdateUserInfo(tempApiService);
        } catch (e) {
          logger.d('ℹ️ User info fetch failed, continuing with sync: $e');
        }

        await _fhirLocalDataSource
            .setLastSyncTimestamp(DateTime.now().toIso8601String());
        return;
      } on DioException catch (e, s) {
        logger.e('⛔ Error during sync with $serverAddress: ${e.message}', e, s);
        lastException =
            SyncException(_getUserFriendlyErrorMessage(e, serverAddress), e);

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

  Future<void> _fetchAndUpdateUserInfo(FhirApiService apiService) async {
    try {
      final userDto = await apiService.fetchCurrentUser();

      if (userDto != null) {
        final user = UserMapper.fromDto(userDto);
        await _userRepository.updateUser(user);
        logger.d('✅ User information updated successfully');
      } else {
        logger.d(
            'ℹ️ No user information available, continuing without user update');
      }
    } catch (e, s) {
      logger.e('⚠️ Failed to fetch user information: $e', e, s);
      // Don't fail the entire sync if user info can't be fetched
      // This is non-critical information
    }
  }

  Future<void> _validateServerConnection(
      Dio dio, String address, String port) async {
    try {
      logger.d('🔍 Validating server connection to $address:$port');

      // Try to reach the health endpoint first (public, no auth required)
      final response = await dio.get('/health');

      if (response.statusCode == 200) {
        logger.d('✅ Server connection validated successfully');
        final data = response.data;
        if (data['success'] == true) {
          logger.d('📊 Server is healthy and responding');
        }
      } else {
        throw Exception(
            'Server health check failed with code: ${response.statusCode}');
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
