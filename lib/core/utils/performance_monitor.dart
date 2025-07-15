import 'dart:developer' as developer;
import 'package:health_wallet/core/utils/logger.dart';

/// Performance monitoring utility for tracking loading times and bottlenecks
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, DateTime> _startTimes = {};
  final Map<String, List<int>> _operationDurations = {};
  final Map<String, int> _operationCounts = {};

  /// Start timing an operation
  void startOperation(String operationName) {
    _startTimes[operationName] = DateTime.now();
    developer.Timeline.startSync(operationName);
    logger.d('PerformanceMonitor: Started operation: $operationName');
  }

  /// End timing an operation and record the duration
  void endOperation(String operationName) {
    final endTime = DateTime.now();
    final startTime = _startTimes.remove(operationName);

    if (startTime != null) {
      final duration = endTime.difference(startTime).inMilliseconds;

      // Record the duration
      _operationDurations.putIfAbsent(operationName, () => []);
      _operationDurations[operationName]!.add(duration);

      // Increment operation count
      _operationCounts[operationName] =
          (_operationCounts[operationName] ?? 0) + 1;

      logger.d(
          'PerformanceMonitor: Completed operation: $operationName in ${duration}ms');

      // Log warning for slow operations
      if (duration > 1000) {
        logger.w(
            'PerformanceMonitor: Slow operation detected: $operationName took ${duration}ms');
      }

      developer.Timeline.finishSync();
    } else {
      logger.w(
          'PerformanceMonitor: No start time found for operation: $operationName');
    }
  }

  /// Time an async operation
  Future<T> timeOperation<T>(
      String operationName, Future<T> Function() operation) async {
    startOperation(operationName);
    try {
      final result = await operation();
      endOperation(operationName);
      return result;
    } catch (e) {
      endOperation(operationName);
      rethrow;
    }
  }

  /// Time a sync operation
  T timeSync<T>(String operationName, T Function() operation) {
    startOperation(operationName);
    try {
      final result = operation();
      endOperation(operationName);
      return result;
    } catch (e) {
      endOperation(operationName);
      rethrow;
    }
  }

  /// Get performance statistics for an operation
  PerformanceStats? getStats(String operationName) {
    final durations = _operationDurations[operationName];
    final count = _operationCounts[operationName];

    if (durations == null || durations.isEmpty || count == null) {
      return null;
    }

    final sorted = List<int>.from(durations)..sort();
    final average = durations.reduce((a, b) => a + b) / durations.length;
    final median = sorted.length % 2 == 0
        ? (sorted[sorted.length ~/ 2 - 1] + sorted[sorted.length ~/ 2]) / 2
        : sorted[sorted.length ~/ 2].toDouble();

    return PerformanceStats(
      operationName: operationName,
      count: count,
      averageDuration: average,
      medianDuration: median,
      minDuration: sorted.first,
      maxDuration: sorted.last,
      p95Duration:
          sorted[(sorted.length * 0.95).floor().clamp(0, sorted.length - 1)],
      p99Duration:
          sorted[(sorted.length * 0.99).floor().clamp(0, sorted.length - 1)],
    );
  }

  /// Get all performance statistics
  Map<String, PerformanceStats> getAllStats() {
    final stats = <String, PerformanceStats>{};
    for (final operationName in _operationDurations.keys) {
      final stat = getStats(operationName);
      if (stat != null) {
        stats[operationName] = stat;
      }
    }
    return stats;
  }

  /// Get a summary report of all operations
  String getSummaryReport() {
    final buffer = StringBuffer();
    buffer.writeln('=== Performance Monitor Summary ===');

    final allStats = getAllStats();
    if (allStats.isEmpty) {
      buffer.writeln('No performance data available.');
      return buffer.toString();
    }

    // Sort by average duration (slowest first)
    final sortedStats = allStats.entries.toList()
      ..sort(
          (a, b) => b.value.averageDuration.compareTo(a.value.averageDuration));

    for (final entry in sortedStats) {
      final stats = entry.value;
      buffer.writeln('');
      buffer.writeln('Operation: ${stats.operationName}');
      buffer.writeln('  Count: ${stats.count}');
      buffer
          .writeln('  Average: ${stats.averageDuration.toStringAsFixed(1)}ms');
      buffer.writeln('  Median: ${stats.medianDuration.toStringAsFixed(1)}ms');
      buffer.writeln('  Min: ${stats.minDuration}ms');
      buffer.writeln('  Max: ${stats.maxDuration}ms');
      buffer.writeln('  P95: ${stats.p95Duration}ms');
      buffer.writeln('  P99: ${stats.p99Duration}ms');

      // Add performance rating
      if (stats.averageDuration > 2000) {
        buffer.writeln('  Rating: 🔴 VERY SLOW');
      } else if (stats.averageDuration > 1000) {
        buffer.writeln('  Rating: 🟠 SLOW');
      } else if (stats.averageDuration > 500) {
        buffer.writeln('  Rating: 🟡 MODERATE');
      } else if (stats.averageDuration > 100) {
        buffer.writeln('  Rating: 🟢 GOOD');
      } else {
        buffer.writeln('  Rating: ⚡ EXCELLENT');
      }
    }

    return buffer.toString();
  }

  /// Reset all performance data
  void reset() {
    _startTimes.clear();
    _operationDurations.clear();
    _operationCounts.clear();
    logger.d('PerformanceMonitor: Reset all performance data');
  }

  /// Log the current performance summary
  void logSummary() {
    logger.i(getSummaryReport());
  }

  /// Get the slowest operations
  List<PerformanceStats> getSlowestOperations({int limit = 5}) {
    final allStats = getAllStats();
    final sortedStats = allStats.values.toList()
      ..sort((a, b) => b.averageDuration.compareTo(a.averageDuration));

    return sortedStats.take(limit).toList();
  }
}

/// Performance statistics for an operation
class PerformanceStats {
  final String operationName;
  final int count;
  final double averageDuration;
  final double medianDuration;
  final int minDuration;
  final int maxDuration;
  final int p95Duration;
  final int p99Duration;

  const PerformanceStats({
    required this.operationName,
    required this.count,
    required this.averageDuration,
    required this.medianDuration,
    required this.minDuration,
    required this.maxDuration,
    required this.p95Duration,
    required this.p99Duration,
  });

  @override
  String toString() {
    return 'PerformanceStats(operation: $operationName, count: $count, '
        'avg: ${averageDuration.toStringAsFixed(1)}ms, '
        'median: ${medianDuration.toStringAsFixed(1)}ms, '
        'min: ${minDuration}ms, max: ${maxDuration}ms, '
        'p95: ${p95Duration}ms, p99: ${p99Duration}ms)';
  }
}

/// Extension to easily add performance monitoring to any operation
extension PerformanceMonitoringExtension on Future {
  Future<T> withPerformanceMonitoring<T>(String operationName) async {
    return PerformanceMonitor()
        .timeOperation(operationName, () async => await this as T);
  }
}

/// Global performance monitor instance
final performanceMonitor = PerformanceMonitor();
