import 'package:dio/dio.dart';

/// Custom exception for sync-related errors with user-friendly messages
class SyncException implements Exception {
  /// User-friendly error message
  final String message;
  
  /// Original exception that caused this error
  final Exception? cause;
  
  /// Error code for programmatic handling
  final String? code;
  
  /// Additional context about the error
  final Map<String, dynamic>? context;

  const SyncException(
    this.message, [
    this.cause,
    this.code,
    this.context,
  ]);

  /// Creates a SyncException from a DioException with enhanced error details
  factory SyncException.fromDioException(DioException dioException) {
    String message;
    String? code;
    Map<String, dynamic> context = {
      'url': dioException.requestOptions.uri.toString(),
      'method': dioException.requestOptions.method,
    };

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. The server is not responding.';
        code = 'CONNECTION_TIMEOUT';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout. Failed to send data to server.';
        code = 'SEND_TIMEOUT';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout. Server is taking too long to respond.';
        code = 'RECEIVE_TIMEOUT';
        break;
      case DioExceptionType.connectionError:
        if (dioException.message?.contains('Connection refused') ?? false) {
          message = 'Server is not running or not accessible. Please check the server status.';
          code = 'CONNECTION_REFUSED';
        } else if (dioException.message?.contains('Network is unreachable') ?? false) {
          message = 'Network is unreachable. Please check your internet connection.';
          code = 'NETWORK_UNREACHABLE';
        } else {
          message = 'Cannot connect to server. Please verify the server address.';
          code = 'CONNECTION_ERROR';
        }
        break;
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        context['statusCode'] = statusCode;
        
        switch (statusCode) {
          case 401:
            message = 'Authentication failed. Your sync token may have expired.';
            code = 'AUTH_FAILED';
            break;
          case 403:
            message = 'Access denied. You do not have permission to sync.';
            code = 'ACCESS_DENIED';
            break;
          case 404:
            message = 'Server endpoint not found. The sync API may not be available.';
            code = 'ENDPOINT_NOT_FOUND';
            break;
          case 429:
            message = 'Rate limit exceeded. Please wait before trying again.';
            code = 'RATE_LIMITED';
            break;
          case 500:
            message = 'Server error. Please try again later.';
            code = 'SERVER_ERROR';
            break;
          case 503:
            message = 'Service unavailable. The server is temporarily down.';
            code = 'SERVICE_UNAVAILABLE';
            break;
          default:
            message = 'Server returned error $statusCode.';
            code = 'HTTP_ERROR';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Sync was cancelled.';
        code = 'CANCELLED';
        break;
      case DioExceptionType.unknown:
      default:
        message = 'An unexpected error occurred while syncing.';
        code = 'UNKNOWN_ERROR';
    }

    return SyncException(message, dioException, code, context);
  }

  /// Creates a connection error for when server is not accessible
  factory SyncException.connectionRefused(String serverAddress) {
    return SyncException(
      'Cannot connect to server at $serverAddress. Please check if the server is running.',
      null,
      'CONNECTION_REFUSED',
      {'serverAddress': serverAddress},
    );
  }

  /// Creates an authentication error
  factory SyncException.authenticationFailed() {
    return const SyncException(
      'Authentication failed. Please generate a new sync token.',
      null,
      'AUTH_FAILED',
    );
  }

  /// Creates a token expired error
  factory SyncException.tokenExpired() {
    return const SyncException(
      'Sync token has expired. Please generate a new QR code.',
      null,
      'TOKEN_EXPIRED',
    );
  }

  /// Creates a server unavailable error
  factory SyncException.serverUnavailable() {
    return const SyncException(
      'Server is currently unavailable. Please try again later.',
      null,
      'SERVER_UNAVAILABLE',
    );
  }



  /// Creates an invalid data error
  factory SyncException.invalidData(String details) {
    return SyncException(
      'Invalid sync data: $details',
      null,
      'INVALID_DATA',
      {'details': details},
    );
  }

  /// Creates a validation error for response format issues
  factory SyncException.validationError(
    String message, {
    Map<String, dynamic>? context,
  }) {
    return SyncException(
      message,
      null,
      'VALIDATION_ERROR',
      context,
    );
  }

  /// Creates a server error for HTTP status errors
  factory SyncException.serverError(
    String message, {
    Map<String, dynamic>? context,
  }) {
    return SyncException(
      message,
      null,
      'SERVER_ERROR',
      context,
    );
  }

  /// Creates a network error for connection issues
  factory SyncException.networkError(
    String message, {
    Map<String, dynamic>? context,
  }) {
    return SyncException(
      message,
      null,
      'NETWORK_ERROR',
      context,
    );
  }



  /// Returns true if this is a connection-related error
  bool get isConnectionError {
    return code == 'CONNECTION_REFUSED' ||
           code == 'CONNECTION_TIMEOUT' ||
           code == 'CONNECTION_ERROR' ||
           code == 'NETWORK_UNREACHABLE' ||
           code == 'NETWORK_ERROR';
  }

  /// Returns true if this is an authentication-related error
  bool get isAuthError {
    return code == 'AUTH_FAILED' ||
           code == 'TOKEN_EXPIRED' ||
           code == 'ACCESS_DENIED';
  }

  /// Returns true if this is a server-related error
  bool get isServerError {
    return code == 'SERVER_ERROR' ||
           code == 'SERVICE_UNAVAILABLE' ||
           code == 'SERVER_UNAVAILABLE';
  }

  /// Returns true if this is a temporary error that might succeed on retry
  bool get isRetryable {
    return code == 'CONNECTION_TIMEOUT' ||
           code == 'SEND_TIMEOUT' ||
           code == 'RECEIVE_TIMEOUT' ||
           code == 'SERVER_ERROR' ||
           code == 'SERVICE_UNAVAILABLE' ||
           code == 'RATE_LIMITED';
  }

  /// Returns a user action suggestion based on the error type
  String get suggestedAction {
    switch (code) {
      case 'CONNECTION_REFUSED':
      case 'CONNECTION_ERROR':
        return 'Check if the server is running and accessible.';
      case 'AUTH_FAILED':
      case 'TOKEN_EXPIRED':
        return 'Generate a new sync token or QR code.';
      case 'NETWORK_ERROR':
      case 'NETWORK_UNREACHABLE':
        return 'Check your internet connection.';
      case 'RATE_LIMITED':
        return 'Wait a moment before trying again.';
      case 'SERVER_ERROR':
      case 'SERVICE_UNAVAILABLE':
        return 'Try again later or contact server administrator.';
      case 'CONNECTION_TIMEOUT':
      case 'SEND_TIMEOUT':
      case 'RECEIVE_TIMEOUT':
        return 'Check your connection and try again.';
      default:
        return 'Try again or check your connection settings.';
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer('SyncException: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    if (cause != null) {
      buffer.write('\nCaused by: $cause');
    }
    return buffer.toString();
  }
} 