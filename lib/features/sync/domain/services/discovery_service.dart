import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';
import 'package:network_info_plus/network_info_plus.dart';

abstract class DiscoveryService {
  Future<void> startDiscovery();

  Future<void> stopDiscovery();

  Future<List<SSDPServiceInfo>> discoverByDirectIP({
    String? startIP,
    String? endIP,
    List<String>? specificIPs,
  });

  DiscoveryStatus get status;

  bool get isScanning;
}

enum DiscoveryStatus {
  stopped,
  running,
  error,
}

class DiscoveryServiceImpl implements DiscoveryService {
  static const int _discoveryPort = 1901;

  Timer? _discoveryTimer;
  DiscoveryStatus _status = DiscoveryStatus.stopped;

  @override
  DiscoveryStatus get status => _status;

  @override
  Future<void> startDiscovery() async {
    if (_status == DiscoveryStatus.running) return;

    try {
      _status = DiscoveryStatus.running;

      unawaited(_discoverServices());
    } catch (e) {
      _status = DiscoveryStatus.error;
      rethrow;
    }
  }

  @override
  Future<void> stopDiscovery() async {
    if (_status == DiscoveryStatus.stopped) return;

    _discoveryTimer?.cancel();

    _status = DiscoveryStatus.stopped;
  }

  Future<void> _discoverServices() async {
    try {
      await discoverByDirectIP();
    } catch (e) {}
  }

  bool get isScanning => _status == DiscoveryStatus.running;

  Future<List<SSDPServiceInfo>> discoverByDirectIP({
    String? startIP,
    String? endIP,
    List<String>? specificIPs,
  }) async {
    final discoveredServices = <SSDPServiceInfo>[];

    try {
      if (_status != DiscoveryStatus.running) {
        return discoveredServices;
      }

      final knownIPs = ['192.168.1.164'];
      final commonServerIPs = [
        '192.168.1.1',
        '192.168.1.100',
        '192.168.1.200',
        '192.168.0.1',
        '10.0.0.1',
      ];

      specificIPs = [...knownIPs, ...commonServerIPs, ...?specificIPs];

      if (specificIPs.isNotEmpty) {
        final futures =
            specificIPs.map((ip) => _testIPForFastenService(ip)).toList();
        final results = await Future.wait(futures);

        for (int i = 0; i < results.length; i++) {
          final service = results[i];
          if (service != null) {
            discoveredServices.add(service);
            _status = DiscoveryStatus.stopped;
            return discoveredServices;
          }
        }
      }

      if (discoveredServices.isEmpty) {
        final localIP = await _getLocalNetworkIP();
        if (localIP != null) {
          final subnet = localIP.substring(0, localIP.lastIndexOf('.'));

          final batchSize = 10;
          final batches = <List<int>>[];

          for (int i = 1; i <= 254; i += batchSize) {
            final end = (i + batchSize - 1).clamp(1, 254);
            batches.add(List.generate(end - i + 1, (index) => i + index));
          }

          for (final batch in batches) {
            if (_status != DiscoveryStatus.running) {
              break;
            }

            final futures = batch.map((i) {
              final ip = '$subnet.$i';
              return _testIPForFastenService(ip);
            }).toList();

            final results = await Future.wait(futures);

            for (int i = 0; i < results.length; i++) {
              final service = results[i];
              if (service != null) {
                discoveredServices.add(service);
                _status = DiscoveryStatus.stopped;
                return discoveredServices;
              }
            }
          }
        } else {
          await _scanCommonNetworkRanges(discoveredServices);
        }
      }

      return discoveredServices;
    } catch (e) {
      return discoveredServices;
    }
  }

  Future<String?> _getLocalNetworkIP() async {
    try {
      final wifiIP = await NetworkInfo().getWifiIP();
      if (wifiIP != null && wifiIP.isNotEmpty && wifiIP.contains('.')) {
        return wifiIP;
      }

      final interfaces = await NetworkInterface.list();
      for (final interface in interfaces) {
        if (interface.name.toLowerCase().contains('en') ||
            interface.name.toLowerCase().contains('eth') ||
            interface.name.toLowerCase().contains('wi-fi') ||
            interface.name.toLowerCase().contains('wlan')) {
          for (final addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
              return addr.address;
            }
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _scanCommonNetworkRanges(
      List<SSDPServiceInfo> discoveredServices) async {
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

    for (final range in commonRanges) {
      if (_status != DiscoveryStatus.running) {
        return;
      }

      final futures = List.generate(50, (i) {
        final ip = '$range.${i + 1}';
        return _testIPForFastenService(ip);
      });

      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        final service = results[i];
        if (service != null) {
          discoveredServices.add(service);
          _status = DiscoveryStatus.stopped;
          return;
        }
      }
    }
  }

  Future<SSDPServiceInfo?> _testIPForFastenService(String ip) async {
    try {
      final socket = await Socket.connect(ip, _discoveryPort,
          timeout: const Duration(milliseconds: 50));

      socket.write('DISCOVER');

      final responseBytes =
          await socket.timeout(const Duration(milliseconds: 100)).toList();

      final response = utf8.decode(responseBytes.expand((x) => x).toList());

      socket.close();

      if (response.contains('"server": "Fasten Health Server"')) {
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
      // IP doesn't have Fasten service or is unreachable
    }

    return null;
  }
}
