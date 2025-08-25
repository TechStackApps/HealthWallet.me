import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/exceptions/sync_exception.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Severity levels for sync errors
enum SyncErrorSeverity {
  low,     // Non-critical errors that don't affect functionality
  medium,  // Errors that affect some functionality but sync can continue
  high,    // Critical errors that require immediate attention
  critical // Errors that completely block sync functionality
}

/// Standardized error handler for sync operations
@injectable
class SyncErrorHandler {
  
  /// Handle and transform any error into a standardized SyncException
  SyncException handleError(
    dynamic error, {
    String? operation,
    Map<String, dynamic>? context,
  }) {
    final operationContext = {
      'operation': operation,
      'timestamp': DateTime.now().toIso8601String(),
      ...?context,
    };

    // If it's already a SyncException, enhance it with context
    if (error is SyncException) {
      return _enhanceSyncException(error, operationContext);
    }

    // Handle DioException
    if (error is DioException) {
      return _handleDioException(error, operationContext);
    }

    // Handle common exception types
    if (error is FormatException) {
      return SyncException.validationError(
        'Data format error: ${error.message}',
        context: operationContext,
      );
    }

    if (error is TimeoutException) {
      return SyncException.networkError(
        'Operation timed out: ${error.message}',
        context: operationContext,
      );
    }

    if (error is ArgumentError) {
      return SyncException.validationError(
        'Invalid argument: ${error.message}',
        context: operationContext,
      );
    }

    // Handle generic exceptions
    return SyncException(
      'Unexpected error during sync operation: ${error.toString()}',
      error is Exception ? error : Exception(error.toString()),
      'UNKNOWN_ERROR',
      operationContext,
    );
  }

  /// Determine the severity of an error
  SyncErrorSeverity getErrorSeverity(SyncException error) {
    switch (error.code) {
      // Critical errors that completely block functionality
      case 'AUTH_FAILED':
      case 'TOKEN_EXPIRED':
      case 'ACCESS_DENIED':
        return SyncErrorSeverity.critical;

      // High severity errors that require attention
      case 'SERVER_ERROR':
      case 'SERVICE_UNAVAILABLE':
      case 'ENDPOINT_NOT_FOUND':
        return SyncErrorSeverity.high;

      // Medium severity errors that affect some functionality
      case 'CONNECTION_TIMEOUT':
      case 'SEND_TIMEOUT':
      case 'RECEIVE_TIMEOUT':
      case 'RATE_LIMITED':
      case 'VALIDATION_ERROR':
        return SyncErrorSeverity.medium;

      // Low severity errors that are often temporary
      case 'NETWORK_ERROR':
      case 'CONNECTION_ERROR':
      case 'CONNECTION_REFUSED':
      case 'NETWORK_UNREACHABLE':
        return SyncErrorSeverity.low;

      default:
        return SyncErrorSeverity.medium;
    }
  }

  /// Get user-friendly error message based on error type and context
  String getUserFriendlyMessage(SyncException error) {
    final severity = getErrorSeverity(error);
    
    switch (severity) {
      case SyncErrorSeverity.critical:
        return _getCriticalErrorMessage(error);
      case SyncErrorSeverity.high:
        return _getHighSeverityMessage(error);
      case SyncErrorSeverity.medium:
        return _getMediumSeverityMessage(error);
      case SyncErrorSeverity.low:
        return _getLowSeverityMessage(error);
    }
  }

  /// Get suggested actions for resolving the error
  List<String> getSuggestedActions(SyncException error) {
    final actions = <String>[];
    
    switch (error.code) {
      case 'AUTH_FAILED':
      case 'TOKEN_EXPIRED':
        actions.addAll([
          'Generate a new sync token',
          'Check token expiration date',
          'Verify server permissions',
        ]);
        break;
      
      case 'CONNECTION_TIMEOUT':
      case 'SEND_TIMEOUT':
      case 'RECEIVE_TIMEOUT':
        actions.addAll([
          'Check internet connection',
          'Try again in a few moments',
          'Contact administrator if problem persists',
        ]);
        break;
      
      case 'SERVER_ERROR':
      case 'SERVICE_UNAVAILABLE':
        actions.addAll([
          'Try again later',
          'Check server status',
          'Contact system administrator',
        ]);
        break;
      
      case 'RATE_LIMITED':
        actions.addAll([
          'Wait before trying again',
          'Reduce sync frequency',
          'Contact administrator about rate limits',
        ]);
        break;
      
      case 'NETWORK_ERROR':
      case 'CONNECTION_ERROR':
        actions.addAll([
          'Check internet connection',
          'Verify server address',
          'Try switching networks',
        ]);
        break;
      
      default:
        actions.addAll([
          'Try again',
          'Check connection settings',
          'Contact support if problem persists',
        ]);
    }
    
    return actions;
  }

  /// Log error with appropriate level based on severity
  void logError(SyncException error, {StackTrace? stackTrace}) {
    final severity = getErrorSeverity(error);
    final logMessage = '${error.code}: ${error.message}';
    
    switch (severity) {
      case SyncErrorSeverity.critical:
        logger.e('🚨 CRITICAL: $logMessage', error, stackTrace);
        break;
      case SyncErrorSeverity.high:
        logger.e('🔴 HIGH: $logMessage', error, stackTrace);
        break;
      case SyncErrorSeverity.medium:
        logger.w('🟡 MEDIUM: $logMessage');
        break;
      case SyncErrorSeverity.low:
        logger.d('🟢 LOW: $logMessage');
        break;
    }
    
    // Log context if available
    if (error.context != null && error.context!.isNotEmpty) {
      logger.d('📋 Error context: ${error.context}');
    }
  }

  /// Create error report for debugging/monitoring
  Map<String, dynamic> createErrorReport(SyncException error) {
    return {
      'errorCode': error.code,
      'message': error.message,
      'severity': getErrorSeverity(error).name,
      'userMessage': getUserFriendlyMessage(error),
      'suggestedActions': getSuggestedActions(error),
      'context': error.context,
      'timestamp': DateTime.now().toIso8601String(),
      'isRetryable': error.isRetryable,
    };
  }

  // Private helper methods

  SyncException _enhanceSyncException(
    SyncException error,
    Map<String, dynamic> context,
  ) {
    final enhancedContext = {
      ...?error.context,
      ...context,
    };
    
    return SyncException(
      error.message,
      error.cause,
      error.code,
      enhancedContext,
    );
  }

  SyncException _handleDioException(
    DioException dioException,
    Map<String, dynamic> context,
  ) {
    // Use existing DioException handling from SyncException
    final syncException = SyncException.fromDioException(dioException);
    
    // Enhance with additional context
    return _enhanceSyncException(syncException, context);
  }

  String _getCriticalErrorMessage(SyncException error) {
    switch (error.code) {
      case 'AUTH_FAILED':
        return 'Authentication failed. Please generate a new sync token to continue.';
      case 'TOKEN_EXPIRED':
        return 'Your sync token has expired. Please generate a new QR code to reconnect.';
      case 'ACCESS_DENIED':
        return 'Access denied. You do not have permission to access this data.';
      default:
        return 'A critical error occurred that requires immediate attention.';
    }
  }

  String _getHighSeverityMessage(SyncException error) {
    switch (error.code) {
      case 'SERVER_ERROR':
        return 'The server encountered an error. Please try again later.';
      case 'SERVICE_UNAVAILABLE':
        return 'The sync service is temporarily unavailable. Please try again later.';
      case 'ENDPOINT_NOT_FOUND':
        return 'The sync endpoint was not found. Please check your server configuration.';
      default:
        return 'A server error occurred that may affect sync functionality.';
    }
  }

  String _getMediumSeverityMessage(SyncException error) {
    switch (error.code) {
      case 'CONNECTION_TIMEOUT':
        return 'Connection timed out. Please check your internet connection and try again.';
      case 'RATE_LIMITED':
        return 'Too many requests. Please wait a moment before trying again.';
      case 'VALIDATION_ERROR':
        return 'Data validation failed. Some sync data may be incorrect.';
      default:
        return 'A temporary error occurred. Please try again.';
    }
  }

  String _getLowSeverityMessage(SyncException error) {
    switch (error.code) {
      case 'NETWORK_ERROR':
        return 'Network connectivity issue. Please check your connection.';
      case 'CONNECTION_ERROR':
        return 'Unable to connect to server. Please verify the server address.';
      default:
        return 'A minor connectivity issue occurred. This usually resolves automatically.';
    }
  }
}

/// Timeout exception for operations that take too long
class TimeoutException implements Exception {
  final String message;
  final Duration timeout;

  const TimeoutException(this.message, this.timeout);

  @override
  String toString() => 'TimeoutException: $message (timeout: ${timeout.inSeconds}s)';
}
