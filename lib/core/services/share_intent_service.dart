import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:health_wallet/core/utils/logger.dart';

@lazySingleton
class ShareIntentService {
  StreamSubscription? _intentSub;
  final _sharedFilesController = StreamController<List<String>>.broadcast();

  Stream<List<String>> get sharedFilesStream => _sharedFilesController.stream;

  Future<void> initialize() async {
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
      (sharedFiles) async {
        if (sharedFiles.isNotEmpty) {
          await _processSharedFiles(sharedFiles);
        }
      },
      onError: (err) {
        logger.e('Error receiving shared files: $err');
      },
    );

    ReceiveSharingIntent.instance.getInitialMedia().then((sharedFiles) async {
      if (sharedFiles.isNotEmpty) {
        await _processSharedFiles(sharedFiles);

        ReceiveSharingIntent.instance.reset();
      }
    });
  }

  Future<void> _processSharedFiles(List<SharedMediaFile> sharedFiles) async {
    try {
      final List<String> processedPaths = [];
      final appDocDir = await getApplicationDocumentsDirectory();
      final sharedDir = Directory(path.join(appDocDir.path, 'shared_files'));

      if (!await sharedDir.exists()) {
        await sharedDir.create(recursive: true);
      }

      for (final sharedFile in sharedFiles) {
        try {
          final sourceFile = File(sharedFile.path);

          if (!await sourceFile.exists()) {
            continue;
          }

          if (!_isValidFileType(sharedFile.path)) {
            continue;
          }

          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final extension = path.extension(sharedFile.path);
          final newFileName =
              'shared_${timestamp}_${processedPaths.length}$extension';
          final targetPath = path.join(sharedDir.path, newFileName);

          // Copy file to app directory
          await sourceFile.copy(targetPath);
          processedPaths.add(targetPath);
        } catch (e) {
          logger.e('Error processing file ${sharedFile.path}: $e');
        }
      }

      if (processedPaths.isNotEmpty) {
        _sharedFilesController.add(processedPaths);
      }
    } catch (e) {
      logger.e('Error processing shared files: $e');
    }
  }

  /// Check if file is a valid image or PDF
  bool _isValidFileType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    final validExtensions = [
      '.jpg',
      '.jpeg',
      '.png',
      '.pdf',
      '.gif',
      '.bmp',
      '.webp'
    ];
    return validExtensions.contains(extension);
  }

  void dispose() {
    _intentSub?.cancel();
    _sharedFilesController.close();
  }
}
