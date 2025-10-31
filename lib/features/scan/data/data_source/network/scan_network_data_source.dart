import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_gemma/mobile/flutter_gemma_mobile.dart';
import 'package:health_wallet/core/config/env/env.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class ScanNetworkDataSource {
  Stream<DownloadProgress> downloadModel(InferenceModelSpec spec);

  Future<bool> checkModelExistence(InferenceModelSpec spec);

  Future startSession({required InferenceModelSpec spec});

  Future closeSession();

  Future<String?> runPrompt({
    required String prompt,
  });
}

@LazySingleton(as: ScanNetworkDataSource)
class ScanNetworkDataSourceImpl implements ScanNetworkDataSource {
  ScanNetworkDataSourceImpl(Dio dio)
      : _dio = dio
          ..interceptors.add(
            LogInterceptor(
              request: true,
              responseBody: true,
              requestBody: true,
              requestHeader: true,
            ),
          );

  final Dio _dio;
  InferenceModel? _model;
  InferenceModelSession? _session;

  @override
  Future<bool> checkModelExistence(InferenceModelSpec spec) async {
    final manager = FlutterGemmaPlugin.instance.modelManager;
    final isInstalled = await manager.isModelInstalled(spec);

    if (isInstalled) {
      return true;
    }

    // Fallback: check physical file existence with size validation
    final filePath = await getFilePath(spec.name);
    final file = File(filePath);

    // Check remote file size
    final headResponse = await _dio.head(
      spec.modelUrl,
      options:
          Options(headers: {'Authorization': 'Bearer ${Env.huggingFaceToken}'}),
    );

    if (headResponse.statusCode == 200) {
      final contentLengthHeaders = headResponse.headers['content-length'];
      if (contentLengthHeaders != null && contentLengthHeaders.isNotEmpty) {
        final remoteFileSize = int.parse(contentLengthHeaders.first);
        if (file.existsSync() && await file.length() == remoteFileSize) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Stream<DownloadProgress> downloadModel(InferenceModelSpec spec) async* {
    yield* FlutterGemmaPlugin.instance.modelManager
        .downloadModelWithProgress(spec, token: Env.huggingFaceToken);
  }

  /// Helper method to get the file path.
  Future<String> getFilePath(String fileName) async {
    // Use the same path correction logic as the unified system
    final directory = await getApplicationDocumentsDirectory();
    // Apply Android path correction for consistency with unified download system
    final correctedPath = directory.path.contains('/data/user/0/')
        ? directory.path.replaceFirst('/data/user/0/', '/data/data/')
        : directory.path;
    return '$correctedPath/$fileName';
  }

  @override
  Future startSession({required InferenceModelSpec spec}) async {
    if (_model == null) {
      await FlutterGemmaPlugin.instance.modelManager.ensureModelReady(
        spec.name,
        spec.modelUrl,
      );
      _model = await FlutterGemmaPlugin.instance
          .createModel(modelType: ModelType.gemmaIt, maxTokens: 4096);
    }

    _session = await _model!.createSession();
  }

  @override
  Future closeSession() async {
    await _session?.close();
  }

  @override
  Future<String?> runPrompt({
    required String prompt,
  }) async {
    if (_session == null) {
      throw Exception("Session is not open");
    }

    await _session!.addQueryChunk(Message(text: prompt, isUser: true));

    String response = await _session!.getResponse();

    return response;
  }
}
