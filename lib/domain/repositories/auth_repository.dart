import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/auth_result.dart';

abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Either<Failure, AuthResult>> register({
    required String email,
    required String username,
    required String password,
    String? fullName,
  });

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Refresh access token
  Future<Either<Failure, String>> refreshToken();

  /// Check if user is logged in
  Future<Either<Failure, bool>> isLoggedIn();
}
