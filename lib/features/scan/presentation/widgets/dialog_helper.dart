import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';

class DialogHelper {
  static void showPermissionRequiredDialog(
      BuildContext context, VoidCallback onRetry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Required'),
          content: const Text(
            'This app needs camera access to scan. Please grant permission to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  static void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Denied'),
          content: const Text(
            'Camera permission has been permanently denied. Please enable it in Settings to use the scanner.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteConfirmation(
      BuildContext context, String filePath, int index) {
    final state = context.read<ScanBloc>().state;
    final isPdf = state.savedPdfPaths.contains(filePath);
    final fileName = filePath.split('/').last;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(isPdf ? 'Delete PDF' : 'Delete Page'),
          content: Text(
              'Are you sure you want to delete ${isPdf ? 'PDF: $fileName' : 'Page ${index + 1}'}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (isPdf) {
                  context.read<ScanBloc>().add(
                        DeletePdf(pdfPath: filePath),
                      );
                } else {
                  context.read<ScanBloc>().add(
                        DeleteDocument(imagePath: filePath),
                      );
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  static void showClearAllDialog(BuildContext context) {
    final state = context.read<ScanBloc>().state;
    final totalDocuments =
        state.scannedImagePaths.length + state.savedPdfPaths.length;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Scans'),
          content: Text(
              'Are you sure you want to delete all $totalDocuments scan${totalDocuments > 1 ? 's' : ''}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<ScanBloc>().add(
                      const ClearScans(),
                    );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  static Widget buildAttachmentSuccessDialog(
      BuildContext context, int count, String encounterId, ScanBloc bloc) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text('Success!'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Successfully attached $count scan${count > 1 ? 's' : ''} to the encounter.',
          ),
          const SizedBox(height: 8),
          Text(
            'Scans have been grouped by type (scanned, imported images, PDFs) and saved as FHIR Media resources.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Encounter: $encounterId',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            bloc.add(const ClearScans());
            bloc.add(const ClearImports());
          },
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.router.push(RecordsRoute());
          },
          child: const Text('View Records'),
        ),
      ],
    );
  }

  static void showAttachmentSuccessDialog(
      BuildContext context, int count, String encounterId, ScanBloc bloc) {
    showDialog(
      context: context,
      builder: (context) =>
          buildAttachmentSuccessDialog(context, count, encounterId, bloc),
    );
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Something went wrong'),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
