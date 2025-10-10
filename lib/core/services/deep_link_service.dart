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
  final _appLinks = AppLinks();  // Updated
  StreamSubscription? _linkSubscription;
  final _deepLinkController = StreamController<DeepLinkData>.broadcast();

  /// Stream of incoming deep links
  Stream<DeepLinkData> get deepLinkStream => _deepLinkController.stream;

  /// Initialize deep link listeners
  Future<void> initialize() async {
    // Check for initial deep link (when app was closed)
    try {
      final initialUri = await _appLinks.getInitialLink();  // Updated
      if (initialUri != null) {
        debugPrint('Initial deep link: $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    // Listen for deep links while app is open
    _linkSubscription = _appLinks.uriLinkStream.listen(  // Updated
      (Uri uri) {
        debugPrint('Received deep link: $uri');
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  }

  /// Parse and handle deep link
  void _handleDeepLink(Uri uri) {
    // Expected format: healthwallet://add-document?url=...&type=...&patient=...
    
    if (uri.scheme != 'healthwallet') {
      debugPrint('Invalid scheme: ${uri.scheme}');
      return;
    }

    if (uri.host == 'add-document') {
      final fileUrl = uri.queryParameters['url'];
      final docType = uri.queryParameters['type'];
      final patientId = uri.queryParameters['patient'];
      final providerName = uri.queryParameters['provider'];
      final documentName = uri.queryParameters['name'];

      if (fileUrl == null || fileUrl.isEmpty) {
        debugPrint('Missing required parameter: url');
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
  }

  /// Download file from URL
  Future<String> downloadFile(String fileUrl, {String? customFileName}) async {
    try {
      debugPrint('Downloading file from: $fileUrl');
      
      final response = await http.get(Uri.parse(fileUrl));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download file: ${response.statusCode}');
      }

      // Get app documents directory
      final appDocDir = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(path.join(appDocDir.path, 'provider_downloads'));
      
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      // Generate filename
      final fileName = customFileName ?? 
          'provider_doc_${DateTime.now().millisecondsSinceEpoch}${_getExtensionFromUrl(fileUrl)}';
      final filePath = path.join(downloadsDir.path, fileName);

      // Write file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      debugPrint('File downloaded successfully: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('Error downloading file: $e');
      rethrow;
    }
  }

  /// Extract file extension from URL
  String _getExtensionFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        final lastSegment = pathSegments.last;
        if (lastSegment.contains('.')) {
          return path.extension(lastSegment);
        }
      }
    } catch (e) {
      debugPrint('Error extracting extension: $e');
    }
    return '.pdf'; // Default to PDF
  }

  /// Validate if URL is from trusted provider
  bool isTrustedProvider(String url) {
    // TODO: Add your trusted provider domains
    final trustedDomains = [
      'labcorp.com',
      'questdiagnostics.com',
      'mychart.com',
      'w3.org', // For testing with dummy PDFs
      // Add your partner providers here
    ];

    try {
      final uri = Uri.parse(url);
      return trustedDomains.any((domain) => 
        uri.host.contains(domain)
      );
    } catch (e) {
      return false;
    }
  }

  /// Get file size in MB
  Future<double> getFileSizeInMB(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final bytes = await file.length();
        return bytes / (1024 * 1024);
      }
    } catch (e) {
      debugPrint('Error getting file size: $e');
    }
    return 0;
  }

  void dispose() {
    _linkSubscription?.cancel();
    _deepLinkController.close();
  }
}

/// Data class for deep link information
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

  @override
  String toString() {
    return 'DeepLinkData(action: $action, fileUrl: $fileUrl, type: $documentType, provider: $providerName)';
  }
}

enum DeepLinkAction {
  addDocument,
}