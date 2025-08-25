import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_progress.freezed.dart';
part 'sync_progress.g.dart';

@freezed
class SyncProgress with _$SyncProgress {
  const factory SyncProgress({
    required String currentResourceType,
    required int completedResourceTypes,
    required int totalResourceTypes,
    required int currentChunk,
    required int totalChunks,
    required bool isComplete,
  }) = _SyncProgress;

  factory SyncProgress.fromJson(Map<String, dynamic> json) => _$SyncProgressFromJson(json);
}

extension SyncProgressExtensions on SyncProgress {
  double get overallProgress {
    if (totalResourceTypes == 0) return 0.0;
    
    // Calculate progress as: (completed types + current type progress) / total types
    final currentTypeProgress = totalChunks > 0 ? currentChunk / totalChunks : 0.0;
    return ((completedResourceTypes + currentTypeProgress) / totalResourceTypes) * 100;
  }

  double get currentResourceTypeProgress {
    if (totalChunks == 0) return 0.0;
    return (currentChunk / totalChunks) * 100;
  }

  String get statusMessage {
    if (isComplete) {
      return 'Sync completed successfully';
    }
    
    return 'Syncing $currentResourceType (${currentChunk}/${totalChunks} chunks)';
  }
}
