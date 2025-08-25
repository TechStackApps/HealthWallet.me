import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/qr_sync_config.dart';
import 'package:health_wallet/core/utils/logger.dart';

@injectable
class QRCodeParserService {
  /// Parse QR code data string into QRSyncConfig
  ///
  /// Returns null if the data is invalid or cannot be parsed
  QRSyncConfig? parseQRCodeData(String qrData) {
    logger.d('🔍 Starting QR code parsing...');
    logger.d('📝 Raw QR data length: ${qrData.length}');
    logger.d(
        '📝 Raw QR data preview: ${qrData.substring(0, qrData.length > 100 ? 100 : qrData.length)}...');

    try {
      // Try to parse as JSON
      logger.d('🔄 Attempting JSON parsing...');
      final Map<String, dynamic> jsonData = json.decode(qrData);
      logger.d('✅ JSON parsing successful');
      logger.d('📊 JSON keys found: ${jsonData.keys.toList()}');
      logger.d('📋 Full JSON data: $jsonData');

      // Validate required fields
      logger.d('🔍 Validating required fields...');
      if (!_validateRequiredFields(jsonData)) {
        logger.e('❌ Required fields validation failed');
        return null;
      }
      logger.d('✅ Required fields validation passed');

      // Parse the configuration
      logger.d('🔄 Creating QRSyncConfig from JSON...');
      final config = QRSyncConfig.fromJson(jsonData);
      logger.d('✅ QRSyncConfig created successfully');
      logger.d('🔑 Token preview: ${config.token.substring(0, 20)}...');
      logger.d('⏰ Expires: ${config.expiresAt}');
      return config;
    } catch (e, stackTrace) {
      logger.e('❌ JSON parsing failed: $e');
      logger.e('📚 Stack trace: $stackTrace');
      // If JSON parsing fails, try to extract from other formats
      return _tryAlternativeParsing(qrData);
    }
  }

  /// Validate that all required fields are present
  bool _validateRequiredFields(Map<String, dynamic> jsonData) {
    logger.d('🔍 Validating required top-level fields...');
    final requiredFields = [
      'token',
      'connections',
      'endpoints',
    ];

    for (final field in requiredFields) {
      if (!jsonData.containsKey(field)) {
        logger.e('❌ Missing required field: $field');
        return false;
      }
      logger.d('✅ Found field: $field (type: ${jsonData[field].runtimeType})');
    }

    // Validate connections array
    logger.d('🔍 Validating connections array...');
    if (jsonData['connections'] is! List) {
      logger.e(
          '❌ Connections field is not a List, got: ${jsonData['connections'].runtimeType}');
      return false;
    }

    final connections = jsonData['connections'] as List;
    if (connections.isEmpty) {
      logger.e('❌ Connections array is empty');
      return false;
    }

    for (int i = 0; i < connections.length; i++) {
      final connection = connections[i];
      if (connection is! Map<String, dynamic>) {
        logger
            .e('❌ Connection $i is not a Map, got: ${connection.runtimeType}');
        return false;
      }

      final connectionMap = connection as Map<String, dynamic>;
      final requiredConnectionFields = ['host', 'port', 'protocol'];
      for (final field in requiredConnectionFields) {
        if (!connectionMap.containsKey(field)) {
          logger.e(
              '❌ Missing required connection field: $field in connection $i');
          return false;
        }
        logger
            .d('✅ Found connection $i field: $field = ${connectionMap[field]}');
      }
    }

    // Validate endpoints object
    logger.d('🔍 Validating endpoints object...');
    if (jsonData['endpoints'] is! Map<String, dynamic>) {
      logger.e(
          '❌ Endpoints field is not a Map, got: ${jsonData['endpoints'].runtimeType}');
      return false;
    }

    final endpoints = jsonData['endpoints'] as Map<String, dynamic>;
    final requiredEndpointFields = [
      'access_tokens',
      'sync_data',
      'sync_updates'
    ];
    for (final field in requiredEndpointFields) {
      if (!endpoints.containsKey(field)) {
        logger.e('❌ Missing required endpoint field: $field');
        return false;
      }
      logger.d(
          '✅ Found endpoint field: $field = "${endpoints[field]}" (type: ${endpoints[field].runtimeType})');
    }

    logger.d('✅ All required fields validation passed');
    return true;
  }

  /// Try alternative parsing methods for non-JSON formats
  QRSyncConfig? _tryAlternativeParsing(String qrData) {
    // This could be extended to handle other QR code formats
    // For now, return null if JSON parsing fails
    return null;
  }

  /// Validate if a parsed configuration is usable
  bool isValidConfiguration(QRSyncConfig config) {
    return config.isValid;
  }

  /// Get a human-readable error message for invalid QR codes
  String getErrorMessage(String qrData) {
    try {
      final jsonData = json.decode(qrData);

      if (!jsonData.containsKey('token')) {
        return 'Invalid QR code: Missing authentication token';
      }

      if (!jsonData.containsKey('connections')) {
        return 'Invalid QR code: Missing server connections information';
      }

      if (!jsonData.containsKey('endpoints')) {
        return 'Invalid QR code: Missing API endpoints';
      }

      final connections = jsonData['connections'];
      if (connections is! List || connections.isEmpty) {
        return 'Invalid QR code: No server connections available';
      }

      return 'Invalid QR code format';
    } catch (e) {
      return 'Invalid QR code: Not a valid JSON format';
    }
  }
}
