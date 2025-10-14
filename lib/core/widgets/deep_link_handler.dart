import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/services/deep_link_service.dart';

/// Widget that listens to deep links and shows import dialog
class DeepLinkHandler extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const DeepLinkHandler({
    Key? key,
    required this.child,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  final DeepLinkService _deepLinkService = getIt<DeepLinkService>();
  StreamSubscription<DeepLinkData>? _deepLinkSubscription;

  @override
  void initState() {
    super.initState();
    // Delay initialization until after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDeepLinks();
    });
  }

  Future<void> _initializeDeepLinks() async {
    debugPrint('🔗 Initializing deep links...');
    await _deepLinkService.initialize();
    debugPrint('🔗 Deep link service initialized');

    _deepLinkSubscription = _deepLinkService.deepLinkStream.listen(
      (deepLinkData) {
        debugPrint('Deep link received: $deepLinkData');
        _handleDeepLink(deepLinkData);
      },
      onError: (error) {
        debugPrint('Deep link error: $error');
      },
    );
  }

Future<void> _handleDeepLink(DeepLinkData data) async {
  // Wait until navigator context becomes available or widget disposed
  while (mounted && widget.navigatorKey.currentContext == null) {
    debugPrint('⚠️ Waiting for Navigator context...');
    await Future.delayed(const Duration(milliseconds: 100));
  }

  if (!mounted) return;

  final navigatorContext = widget.navigatorKey.currentContext!;
  
  debugPrint('✅ Navigator context ready, showing dialog...');
  
  // Validate trusted provider
  if (!_deepLinkService.isTrustedProvider(data.fileUrl)) {
    ScaffoldMessenger.of(navigatorContext).showSnackBar(
      const SnackBar(
        content: Text('Untrusted provider.'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  _showImportDialog(navigatorContext, data);
}


Future<void> _showImportDialog(BuildContext navigatorContext, DeepLinkData data) async {
  debugPrint('🔍 About to show dialog...');
  debugPrint('🔍 Context mounted: ${navigatorContext.mounted}');
  
  try {
    debugPrint('🔍 Calling dialog');
    final shouldImport = await showDialog<bool>(
      context: navigatorContext,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        debugPrint('🔍 Dialog builder called!');
        return ImportDocumentDialog(data: data);
      },
    );
    
    debugPrint('🔍 Dialog returned: $shouldImport');

    if (shouldImport == true) {
      await _downloadAndImport(navigatorContext, data);
    }
  } catch (e) {
    debugPrint('❌ Dialog error: $e');
  }
}

  Future<void> _downloadAndImport(BuildContext context, DeepLinkData data) async {
    final navigatorContext = widget.navigatorKey.currentContext!;
    showDialog(
      context: navigatorContext,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Downloading document...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Download the file
      final filePath = await _deepLinkService.downloadFile(
        data.fileUrl,
        customFileName: data.documentName,
      );

      if (!mounted) return;
      Navigator.of(navigatorContext).pop(); // Close loading dialog

      ScaffoldMessenger.of(navigatorContext).showSnackBar(
        const SnackBar(
          content: Text('Document downloaded successfully! Ready to add to your records.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      debugPrint('Downloaded file path: $filePath');
      debugPrint('Provider: ${data.providerName}');
      debugPrint('Document type: ${data.documentType}');
    } catch (e) {
      if (!mounted) return;
      Navigator.of(navigatorContext).pop(); // Close loading dialog
      ScaffoldMessenger.of(navigatorContext).showSnackBar(
        SnackBar(
          content: Text('Failed to download document: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void dispose() {
    _deepLinkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Dialog to confirm document import from provider
class ImportDocumentDialog extends StatelessWidget {
  final DeepLinkData data;

  const ImportDocumentDialog({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('🔍 Building ImportDocumentDialog');
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.medical_information, color: Colors.blue),
          SizedBox(width: 8),
          Text('Import Document'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'A medical provider wants to add a document to your HealthWallet:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          if (data.providerName != null) ...[
            _buildInfoRow('Provider', data.providerName!),
            const SizedBox(height: 8),
          ],
          if (data.documentName != null) ...[
            _buildInfoRow('Document', data.documentName!),
            const SizedBox(height: 8),
          ],
          if (data.documentType != null) ...[
            _buildInfoRow('Type', _formatDocType(data.documentType!)),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'This document will be downloaded and added to your medical records.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Import Document'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  String _formatDocType(String type) {
    switch (type.toLowerCase()) {
      case 'lab_result':
        return 'Lab Result';
      case 'prescription':
        return 'Prescription';
      case 'imaging':
        return 'Medical Imaging';
      case 'vaccination':
        return 'Vaccination Record';
      default:
        return type;
    }
  }
}
