import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';

class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return _handleRemoteError(
        error.message ?? 'An unexpected error occurred',
      );
    }
    return Failure(message: 'An unexpected error occurred');
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();
    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return Failure(message: 'Unauthorized access');
    }

    if (errorMessage.contains('403') || errorMessage.contains('Forbidden')) {
      return Failure(message: 'Access forbidden');
    }

    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return Failure(message: 'Resource not found');
    }

    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return Failure(message: 'Unprocessable Content');
    }

    if (errorMessage.contains('500') ||
        errorMessage.contains('Internal Server Error')) {
      return Failure(message: 'Internal Server Error');
    }

    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Connection failed') ||
        errorMessage.contains('HandshakeException')) {
      return Failure(message: 'Socket Exception: Connection failed');
    }

    if (errorMessage.contains('Timeout') || errorMessage.contains('Deadline')) {
      return Failure(message: 'Request timeout');
    }

    if (errorMessage.contains('TypeError') ||
        errorMessage.contains('FormatException')) {
      return Failure(message: 'Data format error');
    }

    if (errorMessage.isNotEmpty &&
        !errorMessage.contains('Exception') &&
        !errorMessage.contains('Error')) {
      return Failure(message: errorMessage);
    }

    return Failure(message: 'An unexpected error occurred');
  }
}
