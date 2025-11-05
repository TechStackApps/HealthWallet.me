import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/services/share_intent_service.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';

class ShareIntentHandler extends StatefulWidget {
  final Widget child;

  const ShareIntentHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ShareIntentHandler> createState() => _ShareIntentHandlerState();
}

class _ShareIntentHandlerState extends State<ShareIntentHandler> {
  final ShareIntentService _shareIntentService = getIt<ShareIntentService>();
  StreamSubscription<List<String>>? _shareSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeShareIntent();
    });
  }

  Future<void> _initializeShareIntent() async {
    await _shareIntentService.initialize();

    _shareSubscription = _shareIntentService.sharedFilesStream.listen(
      (filePaths) {
        debugPrint('📥 Received ${filePaths.length} shared files');
        _handleSharedFiles(filePaths);
      },
    );
  }

  void _handleSharedFiles(List<String> filePaths) async {
    if (!mounted) return;

    final scanBloc = context.read<ScanBloc>();

    // Dispatch all import events
    for (final filePath in filePaths) {
      debugPrint('📥 Adding shared file to ScanBloc: $filePath');
      scanBloc.add(DocumentImported(filePath: filePath));
    }

    // Wait for all events to be processed by the BLoC
    // Use multiple frame delays to ensure state is fully committed
    await Future.delayed(const Duration(milliseconds: 100));

    // Reload PDFs to ensure all PDFs (including from shared_files) are included
    scanBloc.add(const LoadSavedPdfs());
    await Future.delayed(const Duration(milliseconds: 100));

    // Verify files were actually added
    int retries = 0;
    while (retries < 10) {
      final currentState = scanBloc.state;
      final currentImportedCount = currentState.importedImagePaths.length;
      final currentPdfCount = currentState.savedPdfPaths.length;

      // Check if at least one file was added
      if (currentImportedCount > 0 || currentPdfCount > 0) {
        debugPrint(
            '✅ Files added to state: $currentImportedCount images, $currentPdfCount PDFs');
        break;
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (!mounted) return;

    final router = getIt<AppRouter>();
    router.push(DashboardRoute(initialPage: 3));
  }

  @override
  void dispose() {
    _shareSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
