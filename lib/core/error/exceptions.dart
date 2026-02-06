/// Base exception class for all custom exceptions in the app.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

/// Server exception thrown when server returns an error response.
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
  });
}

/// Network exception thrown when network connection fails.
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
  }) : super(statusCode: null);
}

/// Cache exception thrown when local cache operations fail.
class CacheException extends AppException {
  const CacheException({
    required super.message,
  }) : super(statusCode: null);
}

/// Validation exception thrown when input validation fails.
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    this.fieldErrors,
  }) : super(statusCode: 400);
}

/// Authentication exception thrown when auth fails.
class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.statusCode,
  });
}

/// Not found exception thrown when resource is not found.
class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
  }) : super(statusCode: 404);
}

/// Unauthorized exception thrown when user lacks permissions.
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    required super.message,
  }) : super(statusCode: 401);
}
