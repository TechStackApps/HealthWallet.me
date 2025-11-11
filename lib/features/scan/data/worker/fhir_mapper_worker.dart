import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:health_wallet/features/scan/data/data_source/network/scan_network_data_source.dart';
import 'package:health_wallet/features/scan/domain/entity/slm_model.dart';

class FhirMapperWorker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<Object?> runPrompt(String prompt) async {
    if (_closed) throw StateError("worker is closed");
    final completer = Completer<Object?>();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, prompt));

    return await completer.future;
  }

  static Future<FhirMapperWorker> spawn() async {
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>();

    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    try {
      await Isolate.spawn(_startRemoteIsolate, initPort.sendPort);
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return FhirMapperWorker._(receivePort, sendPort);
  }

  FhirMapperWorker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }

      final (int id, String prompt) = message as (int, String);

      try {
        final networkDataSource = ScanNetworkDataSourceImpl(Dio());
        final promptResponse = await networkDataSource.runPrompt(
          spec: SlmModel.gemmaModel().toInferenceSpec(),
          prompt: prompt,
        );

        sendPort.send((id, promptResponse));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
    }
  }
}
