import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/document_scanner/presentation/bloc/document_scanner_bloc.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_card.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/add_button_card.dart';

class DocumentGrid extends StatelessWidget {
  final VoidCallback onAddDocument;
  final Function(String, int) onDocumentTap;
  final Function(String, int) onDeleteDocument;

  const DocumentGrid({
    super.key,
    required this.onAddDocument,
    required this.onDocumentTap,
    required this.onDeleteDocument,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentScannerBloc, DocumentScannerState>(
      builder: (context, state) {
        // Combine images and PDFs for display
        final allDocuments = <Map<String, dynamic>>[];

        // Add images
        for (String imagePath in state.scannedImagePaths) {
          allDocuments.add({
            'path': imagePath,
            'type': 'image',
            'name': imagePath.split('/').last,
          });
        }

        // Add PDFs
        for (String pdfPath in state.savedPdfPaths) {
          allDocuments.add({
            'path': pdfPath,
            'type': 'pdf',
            'name': pdfPath.split('/').last,
          });
        }

        return GridView.builder(
          key: ValueKey(
              '${state.scannedImagePaths.length}_${state.savedPdfPaths.length}'),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: allDocuments.length + 1, // +1 for the add button
          itemBuilder: (context, index) {
            if (index == allDocuments.length) {
              // Add button card
              return AddButtonCard(onTap: onAddDocument);
            }

            // Regular document card (image or PDF)
            final document = allDocuments[index];
            final isImage = document['type'] == 'image';

            return DocumentCard(
              document: document,
              isImage: isImage,
              index: index,
              onTap: () => onDocumentTap(document['path'], index),
              onDelete: () => onDeleteDocument(document['path'], index),
            );
          },
        );
      },
    );
  }
}
