import 'package:freezed_annotation/freezed_annotation.dart';

part 'ssdp_service_info.freezed.dart';
part 'ssdp_service_info.g.dart';

/// Simplified SSDP service information for Fasten On-Prem
@freezed
class SSDPServiceInfo with _$SSDPServiceInfo {
  const factory SSDPServiceInfo({
    required String id,
    required String friendlyName,
    required String serverAddress,
    required int serverPort,
    required String serviceType,
    @Default(false) bool isConnected,
    @Default(0) int connectionQuality,
    DateTime? discoveredAt,
    String? lastError,
  }) = _SSDPServiceInfo;

  factory SSDPServiceInfo.fromJson(Map<String, dynamic> json) =>
      _$SSDPServiceInfoFromJson(json);
}

extension SSDPServiceInfoExtensions on SSDPServiceInfo {
  /// Get the base URL for API calls
  String get baseUrl => 'http://$serverAddress:$serverPort';

  /// Get the health check endpoint
  String get healthUrl => '$baseUrl/api/health';

  /// Get the sync data URL (returns FHIR Bundle)
  String get syncDataUrl => '$baseUrl/api/secure/sync/data';

  /// Get the sync initiate URL
  String get syncInitiateUrl => '$baseUrl/api/mobile/sync';

  /// Get the FHIR resources URL (returns individual resources)
  String get fhirResourcesUrl => '$baseUrl/api/secure/resource/fhir';

  /// Get the mobile sync URL for JWT token
  String get mobileSyncUrl => '$baseUrl/api/mobile/sync';

  /// Check if service is reachable
  bool get isReachable => serverAddress.isNotEmpty && serverPort > 0;

  /// Get connection status description
  String get connectionStatus {
    if (isConnected) return 'Connected';
    if (lastError != null) return 'Error: $lastError';
    return 'Available';
  }

  /// Get connection quality description
  String get connectionQualityDescription {
    switch (connectionQuality) {
      case 0:
        return 'Unknown';
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Excellent';
      default:
        return 'Unknown';
    }
  }
}
