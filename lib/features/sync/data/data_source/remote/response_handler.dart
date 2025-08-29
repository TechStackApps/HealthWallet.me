import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/exceptions/sync_exception.dart';

@injectable
class ResponseHandler {
  /// Handles HTTP responses and converts them to the expected format
  /// Throws SyncException for any errors
  Map<String, dynamic> handleResponse(Response response, String operation) {
    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw SyncException.validationError(
          'Invalid response format: expected JSON object, got ${response.data.runtimeType}',
          context: {
            'operation': operation,
            'dataType': response.data.runtimeType.toString(),
            'statusCode': response.statusCode,
          },
        );
      }
    } else {
      throw SyncException.serverError(
        'Operation failed with status: ${response.statusCode}',
        context: {
          'operation': operation,
          'statusCode': response.statusCode,
          'responseData': response.data?.toString(),
        },
      );
    }
  }

  /// Handles responses that might be null or empty
  Map<String, dynamic> handleNullableResponse(Response? response, String operation) {
    if (response == null) {
              throw SyncException.networkError(
          'No response received from server',
        );
    }
    
    return handleResponse(response, operation);
  }

  /// Validates that a response contains required fields
  void validateRequiredFields(
    Map<String, dynamic> data,
    List<String> requiredFields,
    String operation,
  ) {
    final missingFields = <String>[];
    
    for (final field in requiredFields) {
      if (!data.containsKey(field) || data[field] == null) {
        missingFields.add(field);
      }
    }
    
    if (missingFields.isNotEmpty) {
      throw SyncException.validationError(
        'Response missing required fields: ${missingFields.join(', ')}',
        context: {
          'operation': operation,
          'missingFields': missingFields,
          'availableFields': data.keys.toList(),
        },
      );
    }
  }
}
