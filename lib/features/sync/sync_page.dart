import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

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
      final data = jsonDecode(code);
      final token = data['token'];
      final address = data['address'];
      final port = data['port'];

      final dio = Dio();
      final response = await dio.get(
        'http://$address:$port/api/secure/sync/data',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final resources = response.data['data'];
        final box = await Hive.openBox('health_records');
        await box.put('records', resources);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync failed. Please try again.')),
        );
      }
    } catch (e) {
      print('Error during sync: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
