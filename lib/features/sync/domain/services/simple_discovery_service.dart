import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// Service for discovering Fasten services on the network using simple TCP discovery
abstract class SimpleDiscoveryService {
  /// Start the discovery process
  Future<void> startDiscovery();

  /// Stop the discovery process
  Future<void> stopDiscovery();

  /// Stream of discovered services
  Stream<List<SSDPServiceInfo>> get discoveredServicesStream;

  /// Manually trigger a discovery
  Future<void> triggerDiscovery();

  /// Discover services by directly scanning IP addresses
  Future<List<SSDPServiceInfo>> discoverByDirectIP({
    String? startIP,
    String? endIP,
    List<String>? specificIPs,
  });

  /// Get current discovery status
  SimpleDiscoveryStatus get status;

  /// Check if discovery is currently scanning
  bool get isScanning;

  /// Force stop scanning immediately
  void forceStopScanning();

  /// Quick test of a single IP (for debugging/testing)
  Future<SSDPServiceInfo?> testSingleIP(String ip);
}

/// Status of discovery
enum SimpleDiscoveryStatus {
  stopped,
  running,
  error,
}

/// Implementation of simple TCP discovery service
class SimpleDiscoveryServiceImpl implements SimpleDiscoveryService {
  static const int _discoveryPort = 1901; // Our simple discovery port
  static const String _discoveryService = 'Fasten Health Server';

  Timer? _discoveryTimer;
  Timer? _cleanupTimer;
  final StreamController<List<SSDPServiceInfo>> _servicesController =
      StreamController<List<SSDPServiceInfo>>.broadcast();

  final List<SSDPServiceInfo> _discoveredServices = [];
  SimpleDiscoveryStatus _status = SimpleDiscoveryStatus.stopped;

  @override
  SimpleDiscoveryStatus get status => _status;

  @override
  Future<SSDPServiceInfo?> testSingleIP(String ip) async {
    return await _testIPForFastenService(ip);
  }

  @override
  Stream<List<SSDPServiceInfo>> get discoveredServicesStream =>
      _servicesController.stream;

  @override
  Future<void> startDiscovery() async {
    if (_status == SimpleDiscoveryStatus.running) return;

    try {
      _status = SimpleDiscoveryStatus.running;
      print('🔍 Simple Discovery started successfully');

      // Kick off an initial scan immediately
      // Do not await to keep call fast; UI can still call discoverByDirectIP
      unawaited(_discoverServices());
    } catch (e) {
      _status = SimpleDiscoveryStatus.error;
      print('❌ Failed to start simple discovery: $e');
      rethrow;
    }
  }

  @override
  Future<void> stopDiscovery() async {
    if (_status == SimpleDiscoveryStatus.stopped) return;

    _discoveryTimer?.cancel();
    _cleanupTimer?.cancel();

    _status = SimpleDiscoveryStatus.stopped;
    print('🛑 Simple Discovery stopped');
  }

  /// Discover services using our simple TCP discovery
  Future<void> _discoverServices() async {
    try {
      // Use the direct IP discovery method
      await discoverByDirectIP();
    } catch (e) {
      print('❌ Error in service discovery: $e');
    }
  }

  /// Check if discovery is currently scanning
  bool get isScanning => _status == SimpleDiscoveryStatus.running;

  /// Force stop scanning immediately
  void forceStopScanning() {
    if (_status == SimpleDiscoveryStatus.running) {
      print('🛑 Force stopping discovery scan');
      _status = SimpleDiscoveryStatus.stopped;
    }
  }

  @override
  Future<void> triggerDiscovery() async {
    if (_status != SimpleDiscoveryStatus.running) {
      // Auto-start if not running to avoid early-abort
      await startDiscovery();
    }

    // Clear previous discoveries before starting new scan
    _discoveredServices.clear();
    _servicesController.add([]);
    print('🔍 Starting new discovery scan...');
    await _discoverServices();
  }

  /// Discover services by directly scanning IP addresses
  Future<List<SSDPServiceInfo>> discoverByDirectIP({
    String? startIP,
    String? endIP,
    List<String>? specificIPs,
  }) async {
    final discoveredServices = <SSDPServiceInfo>[];

    try {
      print('🔍 Starting smart local network discovery...');

      // Check if we should stop scanning
      if (_status != SimpleDiscoveryStatus.running) {
        print('🛑 Discovery stopped, aborting scan');
        return discoveredServices;
      }

      // Add known IPs and common server IPs for fastest discovery
      final knownIPs = ['192.168.1.164']; // Your known Fasten server
      final commonServerIPs = [
        '192.168.1.1', // Router
        '192.168.1.100', // Common server IP
        '192.168.1.200', // Common server IP
        '192.168.0.1', // Alternative router
        '10.0.0.1', // Alternative router
      ];

      if (specificIPs == null) {
        specificIPs = [...knownIPs, ...commonServerIPs];
      } else {
        specificIPs = [...knownIPs, ...commonServerIPs, ...specificIPs];
      }

      // If specific IPs provided, scan those first (fastest path)
      if (specificIPs != null && specificIPs.isNotEmpty) {
        print('🚀 Parallel scanning specific IPs: $specificIPs');

        // Test all specific IPs simultaneously
        final futures =
            specificIPs.map((ip) => _testIPForFastenService(ip)).toList();
        final results = await Future.wait(futures);

        // Check if any service was found
        for (int i = 0; i < results.length; i++) {
          final service = results[i];
          if (service != null) {
            final ip = specificIPs[i];
            print('✅ Found Fasten server at specific IP: $ip');
            discoveredServices.add(service);
            // Immediately update the stream so UI gets notified
            _addOrUpdateService(service);
            return discoveredServices; // Exit immediately if found
          }
        }
        print(
            '❌ No Fasten server found at specific IPs, trying local network scan');
      }

      // If no specific IPs or none found, scan local network
      if (discoveredServices.isEmpty) {
        // Get the device's current network IP and scan the local subnet
        final localIP = await _getLocalNetworkIP();
        if (localIP != null) {
          print('🔍 Device is on network: $localIP');

          // Extract subnet (e.g., if IP is 192.168.1.100, subnet is 192.168.1)
          final subnet = localIP.substring(0, localIP.lastIndexOf('.'));
          print('🔍 Scanning local subnet: $subnet.0/24');

          // Scan the local subnet (1-254, excluding 0 and 255) with early exit
          print('🔍 Scanning local subnet: $subnet.0/24');

          // Parallel scan with early exit (much faster than sequential)
          print('🚀 Starting parallel scan of subnet $subnet.0/24');

          // Create batches of IPs to test in parallel
          final batchSize = 10; // Test 10 IPs simultaneously
          final batches = <List<int>>[];

          for (int i = 1; i <= 254; i += batchSize) {
            final end = (i + batchSize - 1).clamp(1, 254);
            batches.add(List.generate(end - i + 1, (index) => i + index));
          }

          // Test batches in parallel
          for (final batch in batches) {
            // Check if discovery was stopped
            if (_status != SimpleDiscoveryStatus.running) {
              print('🛑 Discovery stopped during scan, aborting');
              break;
            }

            // Test all IPs in this batch simultaneously
            final futures = batch.map((i) {
              final ip = '$subnet.$i';
              return _testIPForFastenService(ip);
            }).toList();

            // Wait for any service to be found
            final results = await Future.wait(futures);

            // Check if any service was found
            for (int i = 0; i < results.length; i++) {
              final service = results[i];
              if (service != null) {
                final ip = '$subnet.${batch[i]}';
                print('✅ Found Fasten server at $ip, stopping parallel scan');
                discoveredServices.add(service);
                // Immediately update the stream so UI gets notified
                _addOrUpdateService(service);
                return discoveredServices; // Exit immediately if found
              }
            }
          }
        } else {
          print(
              '❌ Could not determine local network IP, falling back to common ranges');
          // Fallback to common network ranges if we can't get local IP
          await _scanCommonNetworkRanges(discoveredServices);
        }
      }

      // Services are already added to stream when found
      return discoveredServices;
    } catch (e) {
      print('❌ Error in direct IP discovery: $e');
      return discoveredServices;
    }
  }

  /// Get the device's current local network IP address
  Future<String?> _getLocalNetworkIP() async {
    try {
      // Use network_info_plus to get WiFi IP (fastest method)
      final wifiIP = await NetworkInfo().getWifiIP();
      if (wifiIP != null && wifiIP.isNotEmpty && wifiIP.contains('.')) {
        print('🔍 Device WiFi IP: $wifiIP');
        return wifiIP;
      }

      // Fallback: try to get IP from network interfaces
      final interfaces = await NetworkInterface.list();
      for (final interface in interfaces) {
        if (interface.name.toLowerCase().contains('en') ||
            interface.name.toLowerCase().contains('eth') ||
            interface.name.toLowerCase().contains('wi-fi') ||
            interface.name.toLowerCase().contains('wlan')) {
          for (final addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
              print('🔍 Device network IP: ${addr.address}');
              return addr.address;
            }
          }
        }
      }

      print('❌ Could not determine device network IP');
      return null;
    } catch (e) {
      print('❌ Error getting local network IP: $e');
      return null;
    }
  }

  /// Scan common network ranges as fallback
  Future<void> _scanCommonNetworkRanges(
      List<SSDPServiceInfo> discoveredServices) async {
    print('🔍 Scanning common network ranges as fallback...');

    final commonRanges = [
      '192.168.1',
      '192.168.0',
      '10.0.0',
      '10.0.1',
      '172.16.0',
      '172.17.0',
      '172.18.0',
      '172.19.0',
      '172.20.0',
      '172.21.0',
      '172.22.0',
      '172.23.0',
      '172.24.0',
      '172.25.0',
      '172.26.0',
      '172.27.0',
      '172.28.0',
      '172.29.0',
      '172.30.0',
      '172.31.0',
    ];

    // Parallel scan of common ranges with early exit
    print('🚀 Starting parallel fallback scan of common ranges');

    for (final range in commonRanges) {
      // Check if discovery was stopped
      if (_status != SimpleDiscoveryStatus.running) {
        print('🛑 Discovery stopped during fallback scan, aborting');
        return;
      }

      print('🚀 Parallel scanning range: $range.0/24');

      // Test first 50 IPs in parallel (most likely to have servers)
      final futures = List.generate(50, (i) {
        final ip = '$range.${i + 1}';
        return _testIPForFastenService(ip);
      });

      // Wait for any service to be found
      final results = await Future.wait(futures);

      // Check if any service was found
      for (int i = 0; i < results.length; i++) {
        final service = results[i];
        if (service != null) {
          final ip = '$range.${i + 1}';
          print('✅ Found Fasten server at $ip, stopping fallback scan');
          discoveredServices.add(service);
          // Immediately update the stream so UI gets notified
          _addOrUpdateService(service);
          return; // Early exit - stop scanning once found
        }
      }
    }
  }

  /// Test if a specific IP has a Fasten service running
  Future<SSDPServiceInfo?> _testIPForFastenService(String ip) async {
    try {
      // Test our simple discovery service on port 1901 (ultra-fast timeout)
      final socket = await Socket.connect(ip, _discoveryPort,
          timeout: const Duration(milliseconds: 50)); // Reduced from 100ms

      // Send a simple discovery request
      socket.write('DISCOVER');

      // Wait for response with ultra-fast timeout
      final responseBytes = await socket
          .timeout(const Duration(milliseconds: 100))
          .toList(); // Reduced from 200ms

      final response = utf8.decode(responseBytes.expand((x) => x).toList());

      socket.close();

      // Parse the JSON response
      if (response.contains('"server": "Fasten Health Server"')) {
        print('✅ Found Fasten server at $ip!');
        final service = SSDPServiceInfo(
          id: 'fasten-$ip',
          friendlyName: 'Fasten On-Prem Server',
          serverAddress: ip,
          serverPort: 9090,
          serviceType: 'urn:fastenhealth:service:FastenHealth:1',
          discoveredAt: DateTime.now(),
        );
        return service;
      }
    } catch (e) {
      // IP doesn't have Fasten service or is unreachable - silent fail for speed
    }

    return null;
  }

  /// Add or update discovered service
  void _addOrUpdateService(SSDPServiceInfo service) {
    final existingIndex =
        _discoveredServices.indexWhere((s) => s.id == service.id);

    if (existingIndex >= 0) {
      _discoveredServices[existingIndex] = service;
    } else {
      _discoveredServices.add(service);
    }

    _servicesController.add(List.from(_discoveredServices));
    print(
        '🔍 Discovered service: ${service.friendlyName} at ${service.serverAddress}:${service.serverPort}');

    // Stop discovery immediately after finding a service (chofu style)
    if (_status == SimpleDiscoveryStatus.running) {
      print('🛑 Stopping discovery after finding service (chofu style)');
      _status = SimpleDiscoveryStatus.stopped;
    }
  }

  /// Clean up expired services
  void _cleanupExpiredServices() {
    final now = DateTime.now();
    _discoveredServices.removeWhere((service) {
      // Remove services older than 1 hour
      final expiresAt = service.discoveredAt?.add(const Duration(hours: 1));
      return expiresAt != null && now.isAfter(expiresAt);
    });

    if (_discoveredServices.isNotEmpty) {
      _servicesController.add(List.from(_discoveredServices));
    }
  }

  /// Dispose resources
  void dispose() {
    stopDiscovery();
    _servicesController.close();
  }
}
