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
    super.key,
    required this.child,
  });

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
        _handleSharedFiles(filePaths);
      },
    );
  }

  void _handleSharedFiles(List<String> filePaths) {
    if (!mounted) return;

    final scanBloc = context.read<ScanBloc>();

    for (final filePath in filePaths) {
      scanBloc.add(DocumentImported(filePath: filePath));
    }

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
