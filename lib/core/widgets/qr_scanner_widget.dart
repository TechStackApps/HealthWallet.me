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
            height: 300,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
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
                      widget.onQRCodeDetected(code);
                    }
                  }
                },
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
                      widget.onCancel?.call();
                    },
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

  @override
  void dispose() {
    _isScannerActive = false;
    super.dispose();
  }
}
