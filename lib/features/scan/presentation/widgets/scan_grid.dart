import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/action_buttons.dart';

class ScanGrid extends StatelessWidget {
  final VoidCallback onAddScan;
  final Function(String, int) onScanTap;
  final Function(String, int) onDeleteScan;

  const ScanGrid({
    super.key,
    required this.onAddScan,
    required this.onScanTap,
    required this.onDeleteScan,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      builder: (context, state) {

        final allScans = <Map<String, dynamic>>[];


        for (String imagePath in state.scannedImagePaths) {
          allScans.add({
            'path': imagePath,
            'type': 'image',
            'name': imagePath.split('/').last,
          });
        }

        for (String imagePath in state.importedImagePaths) {
          allScans.add({
            'path': imagePath,
            'type': 'image',
            'name': imagePath.split('/').last,
          });
        }


        for (String pdfPath in state.savedPdfPaths) {
          allScans.add({
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
          itemCount: allScans.length + 1,
          itemBuilder: (context, index) {
            if (index == allScans.length) {

              return AddButtonCard(onTap: onAddScan);
            }


            final scan = allScans[index];
            final isImage = scan['type'] == 'image';

            return ScanCard(
              document: scan,
              isImage: isImage,
              index: index,
              onTap: () => onScanTap(scan['path'], index),
              onDelete: () => onDeleteScan(scan['path'], index),
            );
          },
        );
      },
    );
  }
}

class ScanCard extends StatelessWidget {
  final Map<String, dynamic> document;
  final bool isImage;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ScanCard({
    super.key,
    required this.document,
    required this.isImage,
    required this.index,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: isImage ? Colors.grey[200] : Colors.red[50],
                    child: isImage
                        ? Hero(
                            tag: 'image_$index',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.file(
                                File(document['path']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error,
                                              color: Colors.red, size: 40),
                                          Text('Failed to load',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.picture_as_pdf,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.white, size: 20),
                        onPressed: onDelete,
                        padding: const EdgeInsets.all(4),
                        constraints:
                            const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isImage ? Icons.visibility : Icons.picture_as_pdf,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isImage ? 'Tap to view' : 'PDF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isImage ? Icons.image : Icons.picture_as_pdf,
                        size: 16,
                        color: isImage ? Colors.blue : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          document['name'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isImage ? 'Page ${index + 1}' : 'PDF',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
