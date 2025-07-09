import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isManualEntryVisible = false;
  bool _isScannerActive = true;

  @override
  void initState() {
    super.initState();
    context.read<SyncBloc>().add(const SyncEvent.historyLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.closeKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.syncTitle),
        ),
        body: Column(
          children: [
            if (_isScannerActive)
              SizedBox(
                height: 300,
                child: MobileScanner(
                  onDetect: (capture) {
                    if (!_isScannerActive) return;
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      final String code = barcodes.first.rawValue ?? '';
                      if (code.isNotEmpty) {
                        setState(() {
                          _isScannerActive = false;
                        });
                        context
                            .read<SyncBloc>()
                            .add(SyncEvent.syncDataWithJson(code));
                      }
                    }
                  },
                ),
              ),
            if (!_isScannerActive)
              Column(
                children: [
                  const SizedBox(height: Insets.normal),
                  BlocBuilder<SyncBloc, SyncState>(
                    builder: (context, state) {
                      return state.status.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const CircularProgressIndicator(),
                        success: () => Column(
                          children: [
                            Text(context.l10n.syncSuccessful),
                            const SizedBox(height: Insets.normal),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isScannerActive = true;
                                });
                              },
                              child: Text(context.l10n.syncAgain),
                            ),
                          ],
                        ),
                        failure: (error) => Column(
                          children: [
                            Text('${context.l10n.syncFailed}$error'),
                            const SizedBox(height: Insets.normal),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isScannerActive = true;
                                });
                              },
                              child: Text(context.l10n.tryAgain),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            Expanded(
              child: BlocBuilder<SyncBloc, SyncState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      final dateTime = state.history[index];
                      return ListTile(
                        title: Text(
                          '${context.l10n.syncedAt}${DateFormat.yMd().add_jm().format(dateTime)}',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (_isManualEntryVisible)
              Padding(
                padding: const EdgeInsets.all(Insets.normal),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: context.l10n.pasteSyncData,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 10,
                    ),
                    const SizedBox(height: Insets.normal),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SyncBloc>()
                            .add(SyncEvent.syncDataWithJson(_controller.text));
                      },
                      child: Text(context.l10n.submit),
                    ),
                  ],
                ),
              ),
            BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
              if (state.status.whenOrNull(success: () => true) != null) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () {
                  setState(() {
                    _isManualEntryVisible = !_isManualEntryVisible;
                  });
                },
                child: Text(
                  _isManualEntryVisible
                      ? context.l10n.hideManualEntry
                      : context.l10n.enterDataManually,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
