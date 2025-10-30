import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/services/share_intent_service.dart';
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


void _handleSharedFiles(List<String> filePaths) {
  if (!mounted) return;

  // Add all files to ScanBloc
  final scanBloc = getIt<ScanBloc>();
  
  for (final filePath in filePaths) {
    debugPrint('📥 Adding shared file to ScanBloc: $filePath');
    scanBloc.add(ScanEvent.documentImported(filePath: filePath));
  }
  print("Navigating to Scan route");
  final router = getIt<AppRouter>();
  router.push(ScanRoute()); // Adjust based on your route name

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${filePaths.length} file${filePaths.length > 1 ? 's' : ''} added to Scan!',
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
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