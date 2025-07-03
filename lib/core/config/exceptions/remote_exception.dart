import 'package:equatable/equatable.dart';

class RemoteException extends Equatable implements Exception {
  const RemoteException({
    required this.kind,
    this.httpErrorCode,
    this.message,
    this.rootException,
  });

  final RemoteExceptionKind kind;
  final int? httpErrorCode;
  final String? message;
  final Object? rootException;

  @override
  String toString() {
    return '''RemoteException: {
      kind: $kind
      httpErrorCode: $httpErrorCode,
      rootException: $rootException,
      message: $message,
      stackTrace: ${rootException is Error ? (rootException as Error).stackTrace : ''}
}''';
  }

  @override
  List<Object?> get props => [kind, httpErrorCode, message, rootException];
}

enum RemoteExceptionKind {
  noInternet,
  cancel,

  /// host not found, cannot connect to host
  network,
  server,
  timeout,
  unknown,
}
