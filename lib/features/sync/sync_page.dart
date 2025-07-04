import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/services/sync_service.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_status_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  bool _isScanning = false;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync with Fasten'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isScanning)
              SizedBox(
                height: 300,
                width: 300,
                child: MobileScanner(
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      _handleScannedCode(barcode.rawValue!);
                    }
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Paste the sync data from your Fasten desktop app to sync your health data.',
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sync Data',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _handleScannedCode(_textController.text);
                      },
                      child: const Text('Sync'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isScanning = !_isScanning;
                });
              },
              child: Text(_isScanning ? 'Cancel' : 'Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleScannedCode(String code) async {
    print('Scanned code: $code');
    setState(() {
      _isScanning = false;
    });

    try {
      print('Step 1: Decoding JSON');
      // Clean up the scanned code to ensure it's valid JSON
      String cleanedCode = code.trim();
      if (!cleanedCode.startsWith('{')) {
        int firstBrace = cleanedCode.indexOf('{');
        if (firstBrace != -1) {
          cleanedCode = cleanedCode.substring(firstBrace);
        }
      }
      print('Cleaned scanned code: ' + cleanedCode);
      final data = jsonDecode(cleanedCode);
      print('Step 2: Decoded data: \\${data.runtimeType} - \\${data}');
      final token = data['token'];
      print('Step 3: token: \\${token}');
      final address = data['address'];
      print('Step 4: address: \\${address}');
      final portRaw = data['port'];
      print('Step 5: portRaw: \\${portRaw} (type: \\${portRaw.runtimeType})');
      final port = portRaw is int ? portRaw : int.parse(portRaw.toString());
      print('Step 6: port: \\${port}');

      final prefs = await SharedPreferences.getInstance();
      print('Step 7: Got SharedPreferences');
      await prefs.setString('sync_token', token);
      await prefs.setString('sync_address', address);
      await prefs.setString('sync_port', port.toString());
      print('Step 8: Saved to SharedPreferences');

      final dio = Dio();
      print('Step 9: Created Dio');
      final response = await dio.get(
        'http://$address:$port/api/secure/sync/data',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Step 10: Got response: statusCode=${response.statusCode}");
      print("Step 10.1: response.data type: ${response.data.runtimeType}");
      print("Step 10.2: response.data: ${response.data}");

      dynamic responseData = response.data;
      if (responseData is String) {
        print("response.data is a String, attempting to decode as JSON...");
        try {
          responseData = jsonDecode(responseData);
          print("Decoded responseData: $responseData");
        } catch (e) {
          print("Failed to decode response.data as JSON: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Sync failed: Server returned invalid data.')),
          );
          return;
        }
      }
      print("Step 10.3: responseData after possible decode: $responseData");
      print(
          "Step 10.4: responseData type after possible decode: ${responseData.runtimeType}");
      if (responseData is! Map) {
        print(
            "Error: responseData is not a Map. Actual type: ${responseData.runtimeType}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Sync failed: Server returned unexpected data structure.')),
        );
        return;
      }

      if (response.statusCode == 200) {
        final dataList = responseData['data'];
        if (dataList is List && dataList.length > 2 && dataList[2] is List) {
          final resources = dataList[2];
          print('resources type: \\${resources.runtimeType}');
          print('resources: \\${resources}');
          if (resources.isEmpty) {
            print('Warning: resources list is empty.');
          }
          final box = await Hive.openBox('health_records');
          await box.put('records', resources);
          await getIt<SyncService>().setLastSyncTimestamp();
          context
              .read<SyncStatusBloc>()
              .add(const SyncStatusEvent.checkSyncStatus());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sync successful!')),
          );
        } else {
          print(
              'Error: Unexpected data structure for responseData["data"]: $dataList');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Sync failed: Unexpected data structure from server.')),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync failed. Please try again.')),
        );
      }
    } catch (e, stack) {
      print('Error during sync: $e');
      print('Stack: $stack');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
