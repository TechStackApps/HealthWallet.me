import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@lazySingleton
class ShareIntentService {
  StreamSubscription? _intentSub;
  final _sharedFilesController = StreamController<List<String>>.broadcast();

  /// Stream of shared file paths
  Stream<List<String>> get sharedFilesStream => _sharedFilesController.stream;

  /// Initialize share intent listeners
  Future<void> initialize() async {
    debugPrint('📤 Initializing share intent service...');

    // Listen to media sharing coming from outside the app while the app is in the memory.
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
      (sharedFiles) async {
        if (sharedFiles.isNotEmpty) {
          debugPrint('📤 Received ${sharedFiles.length} files (app was open)');
          await _processSharedFiles(sharedFiles);
        }
      },
      onError: (err) {
        debugPrint('Error receiving shared files: $err');
      },
    );

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.instance.getInitialMedia().then((sharedFiles) async {
      if (sharedFiles.isNotEmpty) {
        debugPrint('📤 Received ${sharedFiles.length} files (app was closed)');
        await _processSharedFiles(sharedFiles);
        
        // Tell the library that we are done processing the intent.
        ReceiveSharingIntent.instance.reset();
      }
    });

    debugPrint('📤 Share intent service initialized');
  }

  /// Process shared files and copy to app directory
  Future<void> _processSharedFiles(List<SharedMediaFile> sharedFiles) async {
    try {
      final List<String> processedPaths = [];
      final appDocDir = await getApplicationDocumentsDirectory();
      final sharedDir = Directory(path.join(appDocDir.path, 'shared_files'));

      // Create directory if it doesn't exist
      if (!await sharedDir.exists()) {
        await sharedDir.create(recursive: true);
      }

      for (final sharedFile in sharedFiles) {
        try {
          final sourceFile = File(sharedFile.path);

          // Verify file exists
          if (!await sourceFile.exists()) {
            debugPrint('⚠️ File does not exist: ${sharedFile.path}');
            continue;
          }

          // Verify it's an image or PDF
          if (!_isValidFileType(sharedFile.path)) {
            debugPrint('⚠️ Invalid file type: ${sharedFile.path}');
            continue;
          }

          // Generate unique filename
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final extension = path.extension(sharedFile.path);
          final newFileName = 'shared_${timestamp}_${processedPaths.length}$extension';
          final targetPath = path.join(sharedDir.path, newFileName);

          // Copy file to app directory
          await sourceFile.copy(targetPath);
          processedPaths.add(targetPath);

          debugPrint('✅ Processed file: $targetPath');
        } catch (e) {
          debugPrint('Error processing file ${sharedFile.path}: $e');
        }
      }

      if (processedPaths.isNotEmpty) {
        _sharedFilesController.add(processedPaths);
      }
    } catch (e) {
      debugPrint('Error processing shared files: $e');
    }
  }

  /// Check if file is a valid image or PDF
  bool _isValidFileType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    final validExtensions = ['.jpg', '.jpeg', '.png', '.pdf', '.gif', '.bmp', '.webp'];
    return validExtensions.contains(extension);
  }

  void dispose() {
    _intentSub?.cancel();
    _sharedFilesController.close();
  }
}