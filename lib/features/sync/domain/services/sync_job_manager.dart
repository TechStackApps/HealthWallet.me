import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_job.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Manages sync job lifecycle and status tracking
@injectable
class SyncJobManager {
  final Map<String, SyncJob> _activeJobs = {};
  final Map<String, DateTime> _jobStartTimes = {};

  /// Creates a new sync job with unique ID
  SyncJob createSyncJob({
    required SyncToken token,
    required int totalResourceTypes,
    List<String>? resourceTypes,
    int? chunkSize,
  }) {
    final jobId = _generateJobId();
    final job = SyncJob(
      id: jobId,
      status: SyncJobStatus.pending,
      startTime: DateTime.now(),
      token: token,
      totalResourceTypes: totalResourceTypes,
      completedResourceTypes: 0,
      resourceTypes: resourceTypes,
      chunkSize: chunkSize,
    );
    
    _activeJobs[jobId] = job;
    _jobStartTimes[jobId] = DateTime.now();
    
    logger.d('📋 Created sync job: $jobId');
    return job;
  }

  /// Updates the status of a sync job
  void updateJobStatus(String jobId, SyncJobStatus status) {
    final job = _activeJobs[jobId];
    if (job != null) {
      final updatedJob = job.copyWith(status: status);
      _activeJobs[jobId] = updatedJob;
      
      logger.d('📊 Job $jobId status updated: $status');
    } else {
      logger.w('⚠️ Attempted to update non-existent job: $jobId');
    }
  }

  /// Marks a job as completed
  void completeJob(String jobId) {
    final job = _activeJobs[jobId];
    if (job != null) {
      final updatedJob = job.copyWith(
        status: SyncJobStatus.completed,
        endTime: DateTime.now(),
      );
      
      _activeJobs[jobId] = updatedJob;
      
      logger.d('✅ Job $jobId completed successfully');
    }
  }

  /// Marks a job as failed
  void failJob(String jobId, {String? error}) {
    final job = _activeJobs[jobId];
    if (job != null) {
      final updatedJob = job.copyWith(
        status: SyncJobStatus.failed,
        endTime: DateTime.now(),
        error: error,
      );
      
      _activeJobs[jobId] = updatedJob;
      
      logger.e('❌ Job $jobId failed: $error');
    }
  }

  /// Checks if a specific job is currently running
  bool isJobRunning(String jobId) {
    final job = _activeJobs[jobId];
    return job?.status == SyncJobStatus.running;
  }

  /// Checks if any sync job is currently running
  bool get hasRunningJobs {
    return _activeJobs.values.any((job) => job.status == SyncJobStatus.running);
  }

  /// Gets the current status of a job
  SyncJobStatus? getJobStatus(String jobId) {
    return _activeJobs[jobId]?.status;
  }

  /// Gets a job by ID
  SyncJob? getJob(String jobId) {
    return _activeJobs[jobId];
  }

  /// Gets all active jobs
  List<SyncJob> get activeJobs => _activeJobs.values.toList();

  /// Gets running jobs
  List<SyncJob> get runningJobs {
    return _activeJobs.values
        .where((job) => job.status == SyncJobStatus.running)
        .toList();
  }

  /// Gets completed jobs
  List<SyncJob> get completedJobs {
    return _activeJobs.values
        .where((job) => job.status == SyncJobStatus.completed)
        .toList();
  }

  /// Gets failed jobs
  List<SyncJob> get failedJobs {
    return _activeJobs.values
        .where((job) => job.status == SyncJobStatus.failed)
        .toList();
  }

  /// Removes completed/failed jobs older than specified duration
  void cleanupOldJobs({Duration maxAge = const Duration(hours: 24)}) {
    final cutoffTime = DateTime.now().subtract(maxAge);
    final jobsToRemove = <String>[];
    
    for (final entry in _activeJobs.entries) {
      final job = entry.value;
      if ((job.status == SyncJobStatus.completed || job.status == SyncJobStatus.failed) &&
          job.endTime != null &&
          job.endTime!.isBefore(cutoffTime)) {
        jobsToRemove.add(entry.key);
      }
    }
    
    for (final jobId in jobsToRemove) {
      _activeJobs.remove(jobId);
      _jobStartTimes.remove(jobId);
    }
    
    if (jobsToRemove.isNotEmpty) {
      logger.d('🧹 Cleaned up ${jobsToRemove.length} old jobs');
    }
  }

  /// Gets the duration a job has been running
  Duration? getJobDuration(String jobId) {
    final startTime = _jobStartTimes[jobId];
    if (startTime != null) {
      return DateTime.now().difference(startTime);
    }
    return null;
  }

  /// Generates a unique job ID
  String _generateJobId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'sync_${timestamp}_$random';
  }
}
