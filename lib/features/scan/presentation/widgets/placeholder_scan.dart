import 'package:flutter/material.dart';

class PlaceholderScan extends StatelessWidget {
  final VoidCallback? onScan;

  const PlaceholderScan({
    super.key,
    this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          Icons.document_scanner,
          size: 100,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'No scans yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Scan or import documents to get started',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.document_scanner_outlined),
            label: const Text('Scan Document'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: onScan,
          ),
        ),
      ],
    );
  }
}
