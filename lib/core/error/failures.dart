import 'package:equatable/equatable.dart';

/// Base failure class for all failures in the app.
/// Failures are returned in the Result type when use cases fail.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure when server returns an error response.
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

/// Failure when network connection fails.
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
  }) : super(statusCode: null);
}

/// Failure when local cache operations fail.
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
  }) : super(statusCode: null);
}

/// Failure when input validation fails.
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
  }) : super(statusCode: 400);

  @override
  List<Object?> get props => [message, statusCode, fieldErrors];
}

/// Failure when authentication fails.
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.statusCode,
  });
}

/// Failure when resource is not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
  }) : super(statusCode: 404);
}

/// Failure when user lacks permissions.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.message,
  }) : super(statusCode: 401);
}

/// Unknown failure for unexpected errors.
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
  }) : super(statusCode: null);
}
