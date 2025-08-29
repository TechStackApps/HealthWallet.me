import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/exceptions/sync_exception.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Configuration for retry policies
class RetryPolicy {
  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final List<String> retryableErrorCodes;

  const RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.retryableErrorCodes = const [
      'CONNECTION_TIMEOUT',
      'SEND_TIMEOUT',
      'RECEIVE_TIMEOUT',
      'SERVER_ERROR',
      'SERVICE_UNAVAILABLE',
      'RATE_LIMITED',
      'NETWORK_ERROR',
      'CONNECTION_ERROR',
    ],
  });

  /// Check if an error should trigger a retry
  bool shouldRetry(dynamic error, int attemptNumber) {
    if (attemptNumber >= maxAttempts) return false;
    
    if (error is SyncException) {
      return error.isRetryable && retryableErrorCodes.contains(error.code);
    }
    
    // For non-SyncException errors, check error message
    final errorMessage = error.toString().toLowerCase();
    return errorMessage.contains('timeout') ||
           errorMessage.contains('connection') ||
           errorMessage.contains('network') ||
           errorMessage.contains('server');
  }

  /// Calculate delay for the next attempt using exponential backoff
  Duration calculateDelay(int attemptNumber) {
    final baseDelay = initialDelay.inMilliseconds;
    final exponentialDelay = baseDelay * pow(backoffMultiplier, attemptNumber - 1);
    final delayMs = min(exponentialDelay, maxDelay.inMilliseconds.toDouble());
    
    // Add jitter to prevent thundering herd
    final jitter = Random().nextDouble() * 0.1; // 10% jitter
    final finalDelay = delayMs * (1 + jitter);
    
    return Duration(milliseconds: finalDelay.round());
  }
}

/// Circuit breaker states
enum CircuitBreakerState { closed, open, halfOpen }

/// Circuit breaker to prevent cascading failures
class CircuitBreaker {
  final int failureThreshold;
  final Duration recoveryTimeout;
  final Duration halfOpenTimeout;
  
  CircuitBreakerState _state = CircuitBreakerState.closed;
  int _failureCount = 0;
  DateTime? _lastFailureTime;

  CircuitBreaker({
    this.failureThreshold = 5,
    this.recoveryTimeout = const Duration(minutes: 2),
    this.halfOpenTimeout = const Duration(seconds: 30),
  });

  CircuitBreakerState get state => _state;
  int get failureCount => _failureCount;

  /// Check if circuit breaker allows the operation
  bool canExecute() {
    switch (_state) {
      case CircuitBreakerState.closed:
        return true;
      case CircuitBreakerState.open:
        if (_lastFailureTime != null &&
            DateTime.now().difference(_lastFailureTime!) > recoveryTimeout) {
          _state = CircuitBreakerState.halfOpen;
          logger.d('🔄 Circuit breaker transitioning to half-open');
          return true;
        }
        return false;
      case CircuitBreakerState.halfOpen:
        return true;
    }
  }

  /// Record a successful operation
  void recordSuccess() {
    if (_state == CircuitBreakerState.halfOpen) {
      logger.d('✅ Circuit breaker closed after successful operation');
      _state = CircuitBreakerState.closed;
    }
    _failureCount = 0;
    _lastFailureTime = null;
  }

  /// Record a failed operation
  void recordFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();

    if (_state == CircuitBreakerState.halfOpen) {
      logger.w('⚠️ Circuit breaker reopened after failure in half-open state');
      _state = CircuitBreakerState.open;
    } else if (_failureCount >= failureThreshold) {
      logger.w('🔴 Circuit breaker opened after $failureThreshold failures');
      _state = CircuitBreakerState.open;
    }
  }
}

/// Service for handling retries with exponential backoff and circuit breaker
@injectable
class SyncRetryService {
  final Map<String, CircuitBreaker> _circuitBreakers = {};

  /// Execute a function with retry logic and circuit breaker protection
  Future<T> executeWithRetry<T>(
    String operationId,
    Future<T> Function() operation, {
    RetryPolicy? policy,
    Map<String, dynamic>? context,
  }) async {
    final retryPolicy = policy ?? const RetryPolicy();
    final circuitBreaker = _getOrCreateCircuitBreaker(operationId);

    // Check circuit breaker
    if (!circuitBreaker.canExecute()) {
      throw SyncException.serverError(
        'Operation blocked by circuit breaker: $operationId',
        context: {
          'operationId': operationId,
          'circuitBreakerState': circuitBreaker.state.name,
          'failureCount': circuitBreaker.failureCount,
          ...?context,
        },
      );
    }

    int attemptNumber = 0;
    dynamic lastError;

    while (attemptNumber < retryPolicy.maxAttempts) {
      attemptNumber++;
      
      try {
        logger.d('🔄 Executing $operationId (attempt $attemptNumber/${retryPolicy.maxAttempts})');
        
        final result = await operation();
        
        // Record success
        circuitBreaker.recordSuccess();
        
        if (attemptNumber > 1) {
          logger.i('✅ $operationId succeeded after $attemptNumber attempts');
        }
        
        return result;
        
              } catch (error) {
        lastError = error;
        logger.e('❌ $operationId failed (attempt $attemptNumber): $error');
        
        // Record failure for circuit breaker
        circuitBreaker.recordFailure();
        
        // Check if we should retry
        if (!retryPolicy.shouldRetry(error, attemptNumber)) {
          logger.e('🚫 $operationId will not be retried: ${_getRetryReason(error, attemptNumber, retryPolicy)}');
          break;
        }
        
        // Calculate and apply delay before next attempt
        if (attemptNumber < retryPolicy.maxAttempts) {
          final delay = retryPolicy.calculateDelay(attemptNumber);
          logger.d('⏳ $operationId retrying in ${delay.inMilliseconds}ms');
          await Future.delayed(delay);
        }
      }
    }

    // All retries exhausted, throw the last error
    throw SyncException.serverError(
      'Operation failed after $attemptNumber attempts: $operationId',
      context: {
        'operationId': operationId,
        'attempts': attemptNumber,
        'maxAttempts': retryPolicy.maxAttempts,
        'lastError': lastError.toString(),
        ...?context,
      },
    );
  }

  /// Get or create a circuit breaker for an operation
  CircuitBreaker _getOrCreateCircuitBreaker(String operationId) {
    return _circuitBreakers.putIfAbsent(
      operationId,
      () => CircuitBreaker(),
    );
  }

  /// Get the reason why an operation won't be retried
  String _getRetryReason(dynamic error, int attemptNumber, RetryPolicy policy) {
    if (attemptNumber >= policy.maxAttempts) {
      return 'Maximum attempts reached';
    }
    
    if (error is SyncException) {
      if (!error.isRetryable) {
        return 'Error is not retryable (${error.code})';
      }
      if (!policy.retryableErrorCodes.contains(error.code)) {
        return 'Error code not in retry policy (${error.code})';
      }
    }
    
    return 'Error type not retryable';
  }

  /// Get circuit breaker status for monitoring
  Map<String, Map<String, dynamic>> getCircuitBreakerStatus() {
    return _circuitBreakers.map((key, breaker) => MapEntry(key, {
      'state': breaker.state.name,
      'failureCount': breaker.failureCount,
      'canExecute': breaker.canExecute(),
    }));
  }

  /// Reset a specific circuit breaker
  void resetCircuitBreaker(String operationId) {
    _circuitBreakers.remove(operationId);
    logger.d('🔄 Circuit breaker reset for $operationId');
  }

  /// Reset all circuit breakers
  void resetAllCircuitBreakers() {
    _circuitBreakers.clear();
    logger.d('🔄 All circuit breakers reset');
  }
}
