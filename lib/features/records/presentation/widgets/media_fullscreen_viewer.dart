// health_wallet/features/records/presentation/widgets/media_fullscreen_viewer.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart' as entities;
import 'package:health_wallet/features/document_scanner/domain/services/media_integration_service.dart';
import 'package:get_it/get_it.dart';

class MediaFullscreenViewer extends StatelessWidget {
  final entities.Media media;

  const MediaFullscreenViewer({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(media.displayTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'info':
                  _showMediaInfo(context);
                  break;
                case 'link':
                  _showLinkToEncounterDialog(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'info',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Media Info'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'link',
                child: ListTile(
                  leading: Icon(Icons.link),
                  title: Text('Link to Encounter'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: _buildMediaContent(context),
      ),
    );
  }

  Widget _buildMediaContent(BuildContext context) {
    final contentType = media.content?.contentType?.valueString;
    
    if (_isImage(contentType)) {
      return _buildImageViewer(context);
    } else {
      return _buildFileViewer(context);
    }
  }

  Widget _buildImageViewer(BuildContext context) {
    if (media.content?.data?.valueString == null) {
      return _buildPlaceholder(context, Icons.image, 'No image data available');
    }

    try {
      final Uint8List imageBytes = base64Decode(media.content!.data!.valueString!);
      return InteractiveViewer(
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 4.0,
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder(context, Icons.broken_image, 'Failed to load image');
          },
        ),
      );
    } catch (e) {
      return _buildPlaceholder(context, Icons.broken_image, 'Invalid image data');
    }
  }

  Widget _buildFileViewer(BuildContext context) {
    final contentType = media.content?.contentType?.valueString ?? 'unknown';
    IconData icon;
    String message;

    switch (contentType.toLowerCase()) {
      case 'application/pdf':
        icon = Icons.picture_as_pdf;
        message = 'PDF Document\nTap info for details';
        break;
      case 'video/mp4':
      case 'video/avi':
        icon = Icons.video_file;
        message = 'Video File\nPlayback not supported in viewer';
        break;
      case 'audio/mp3':
      case 'audio/wav':
        icon = Icons.audio_file;
        message = 'Audio File\nPlayback not supported in viewer';
        break;
      default:
        icon = Icons.file_present;
        message = 'File Preview\nNot available for this format';
    }

    return _buildPlaceholder(context, icon, message);
  }

  Widget _buildPlaceholder(BuildContext context, IconData icon, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 64,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showMediaInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Media Information'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Title:', media.displayTitle),
              if (media.content?.contentType?.valueString != null)
                _buildInfoRow('Type:', media.content!.contentType!.valueString!),
              if (media.statusDisplay.isNotEmpty)
                _buildInfoRow('Status:', media.statusDisplay),
              if (media.subject?.display?.valueString != null)
                _buildInfoRow('Patient:', media.subject!.display!.valueString!),
              if (media.encounter?.display?.valueString != null)
                _buildInfoRow('Encounter:', media.encounter!.display!.valueString!),
              if (media.content?.size?.valueString != null)
                _buildInfoRow('File Size:', _formatFileSize(_parseFileSize(media.content!.size!.valueString!))),
              if (media.date != null)
                _buildInfoRow('Created:', media.date!.toString().split(' ')[0]),
              _buildInfoRow('Resource ID:', media.resourceId),
              _buildInfoRow('Source:', media.sourceId),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLinkToEncounterDialog(BuildContext context) {
    final encounterController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Link to Encounter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Link this media resource to an encounter:'),
            const SizedBox(height: 16),
            TextFormField(
              controller: encounterController,
              decoration: const InputDecoration(
                labelText: 'Encounter ID',
                hintText: 'e.g., encounter-123',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (encounterController.text.trim().isNotEmpty) {
                try {
                  await GetIt.instance.get<MediaIntegrationService>().linkMediaToEncounter(
                    mediaResourceId: media.resourceId,
                    encounterId: encounterController.text.trim(),
                    sourceId: media.sourceId,
                  );
                  
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Media linked to encounter successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to link media: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            child: const Text('Link'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  int _parseFileSize(String sizeString) {
    try {
      return int.parse(sizeString);
    } catch (e) {
      return 0;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  bool _isImage(String? contentType) {
    return contentType?.startsWith('image/') ?? false;
  }
}