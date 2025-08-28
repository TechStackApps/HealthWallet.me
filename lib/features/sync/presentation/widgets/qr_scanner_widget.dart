import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String) onQRCodeDetected;
  final VoidCallback? onCancel;
  final String? title;
  final String? cancelButtonText;

  const QRScannerWidget({
    super.key,
    required this.onQRCodeDetected,
    this.onCancel,
    this.title,
    this.cancelButtonText,
  });

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  bool _isScannerActive = true;
  final MobileScannerController _controller = MobileScannerController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _isScannerActive = false;
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: Text(
                widget.title!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(
            height: 400,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(
                children: [
                  MobileScanner(
                    controller: _controller,
                    onDetect: (capture) {
                      if (!_isScannerActive) return;
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isNotEmpty) {
                        final String code = barcodes.first.rawValue ?? '';
                        if (code.isNotEmpty) {
                          setState(() {
                            _isScannerActive = false;
                          });
                          widget.onQRCodeDetected(code);
                        }
                      }
                    },
                  ),
                  if (_errorMessage != null)
                    Container(
                      color: Colors.black54,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(Insets.normal),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.white,
                                size: 48,
                              ),
                              const SizedBox(height: Insets.small),
                              Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Insets.medium),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _errorMessage = null;
                                  });
                                  _controller.start();
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Insets.normal),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isScannerActive = false;
                      });
                      if (widget.onCancel != null) {
                        widget.onCancel!();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.isDarkMode
                          ? Colors.white
                          : context.colorScheme.primary,
                      side: BorderSide(color: context.colorScheme.primary),
                    ),
                    child: Text(widget.cancelButtonText ?? 'Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
