// core/services/deep_link_service.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@lazySingleton
class DeepLinkService {
  final _appLinks = AppLinks();
  StreamSubscription? _linkSubscription;
  final _deepLinkController = StreamController<DeepLinkData>.broadcast();

  Stream<DeepLinkData> get deepLinkStream => _deepLinkController.stream;

  Future<void> initialize() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint('Initial deep link: $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        debugPrint('Received deep link: $uri');
        _handleDeepLink(uri);
      },
      onError: (err) => debugPrint('Deep link error: $err'),
    );
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme != 'https' || uri.host != 'add.healthwallet.me') {
      debugPrint('Ignored URI (not our FQDN): $uri');
      return;
    }

    final fileUrl = uri.queryParameters['file'];
    final docType = uri.queryParameters['type'];
    final patientId = uri.queryParameters['patient'];
    final providerName = uri.queryParameters['provider'];
    final documentName = uri.queryParameters['name'];

    if (fileUrl == null || fileUrl.isEmpty) {
      debugPrint('Missing required parameter: file');
      _deepLinkController.addError('Missing document URL');
      return;
    }

    final deepLinkData = DeepLinkData(
      action: DeepLinkAction.addDocument,
      fileUrl: fileUrl,
      documentType: docType,
      patientId: patientId,
      providerName: providerName,
      documentName: documentName,
    );

    _deepLinkController.add(deepLinkData);
  }

  Future<String> downloadFile(String fileUrl, {String? customFileName}) async {
    try {
      debugPrint('Downloading file from: $fileUrl');

      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download file: ${response.statusCode}');
      }

      final appDocDir = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(path.join(appDocDir.path, 'provider_downloads'));
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      final fileName = customFileName ??
          'provider_doc_${DateTime.now().millisecondsSinceEpoch}${_getExtensionFromUrl(fileUrl)}';
      final filePath = path.join(downloadsDir.path, fileName);

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      rethrow;
    }
  }

  String _getExtensionFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segs = uri.pathSegments;
      if (segs.isNotEmpty && segs.last.contains('.')) {
        return path.extension(segs.last);
      }
    } catch (_) {}
    return '.pdf';
  }

  bool isTrustedProvider(String url) {
    final trustedDomains = [
      'lifevalue.com',
      'labcorp.com',
      'questdiagnostics.com',
      'mychart.com',
      'w3.org',
    ];
    try {
      final uri = Uri.parse(url);
      return trustedDomains.any((d) => uri.host.endsWith(d));
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
    _deepLinkController.close();
  }
}

class DeepLinkData {
  final DeepLinkAction action;
  final String fileUrl;
  final String? documentType;
  final String? patientId;
  final String? providerName;
  final String? documentName;

  DeepLinkData({
    required this.action,
    required this.fileUrl,
    this.documentType,
    this.patientId,
    this.providerName,
    this.documentName,
  });
}

enum DeepLinkAction { addDocument }
