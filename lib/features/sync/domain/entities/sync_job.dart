import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';

part 'sync_job.freezed.dart';
part 'sync_job.g.dart';

enum SyncJobStatus {
  pending,
  running,
  completed,
  failed,
  cancelled,
}

@freezed
class SyncJob with _$SyncJob {
  const factory SyncJob({
    required String id,
    required SyncJobStatus status,
    required DateTime startTime,
    DateTime? endTime,
    required SyncToken token,
    required int totalResourceTypes,
    required int completedResourceTypes,
    List<String>? resourceTypes,
    Map<String, int>? resourceCounts,
    int? chunkSize,
    String? error,
  }) = _SyncJob;

  factory SyncJob.fromJson(Map<String, dynamic> json) => _$SyncJobFromJson(json);
}

extension SyncJobExtensions on SyncJob {
  double get progressPercentage {
    if (totalResourceTypes == 0) return 0.0;
    return (completedResourceTypes / totalResourceTypes) * 100;
  }

  Duration? get duration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return DateTime.now().difference(startTime);
  }

  bool get isCompleted => status == SyncJobStatus.completed;
  bool get isFailed => status == SyncJobStatus.failed;
  bool get isRunning => status == SyncJobStatus.running;
  bool get isCancelled => status == SyncJobStatus.cancelled;
}
